import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_auth/smart_auth.dart';

part 'sms_code_reader.g.dart';

/// Ждёт SMS с кодом входа и достаёт из неё код.
///
/// Android: SMS User Consent API — система сама ловит следующую SMS
/// (до 5 минут) и спрашивает «Разрешить прочитать?». Разрешение READ_SMS
/// не нужно, и бэку не надо менять текст SMS.
/// iOS: ничего не делает — там код подставляет клавиатура
/// через `AutofillHints.oneTimeCode`.
abstract interface class SmsCodeReader {
  /// Код из [length] цифр из пришедшей SMS или `null`:
  /// отказ, таймаут, отмена, кода в тексте нет.
  Future<String?> listen(int length);

  /// Перестать ждать SMS (ушли с экрана, сменили номер).
  Future<void> cancel();
}

class SmartAuthSmsCodeReader implements SmsCodeReader {
  const SmartAuthSmsCodeReader();

  @override
  Future<String?> listen(int length) async {
    final result = await SmartAuth.instance.getSmsWithUserConsentApi(
      // Ровно [length] цифр отдельным словом — чтобы не взять
      // кусок номера телефона или суммы.
      matcher: '\\b\\d{$length}\\b',
    );
    return result.data?.code;
  }

  @override
  Future<void> cancel() => SmartAuth.instance.removeUserConsentApiListener();
}

class _NoSmsCodeReader implements SmsCodeReader {
  const _NoSmsCodeReader();

  @override
  Future<String?> listen(int length) async => null;

  @override
  Future<void> cancel() async {}
}

@riverpod
SmsCodeReader smsCodeReader(Ref ref) {
  final android = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  return android ? const SmartAuthSmsCodeReader() : const _NoSmsCodeReader();
}
