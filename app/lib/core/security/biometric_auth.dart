import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'biometric_auth.g.dart';

/// Что показать на кнопке: Face ID или отпечаток.
enum BiometricKind { face, fingerprint }

/// Тексты системного окна. Без них плагин подставит английские.
class BiometricPrompt {
  const BiometricPrompt({
    required this.reason,
    required this.title,
    required this.cancel,
    this.fallback,
  });

  /// iOS — подпись под Face ID, Android — строка в окне.
  final String reason;

  /// Заголовок окна на Android.
  final String title;

  /// Кнопка «отказаться» — дальше вход по коду.
  final String cancel;

  /// iOS: кнопка, которую система показывает после неудачной попытки
  /// Face ID. По умолчанию там «Ввести пароль» (пароль телефона), а у нас
  /// biometricOnly — нажатие просто закрывает окно. Поэтому подписываем
  /// её «Ввести код» или прячем (`null`).
  final String? fallback;
}

/// Системная проверка Face ID / отпечатка. Приложение получает только
/// «да / нет» — сами биометрические данные остаются в системе.
abstract interface class BiometricAuth {
  /// Какая биометрия настроена на устройстве; `null` — нет или не настроена.
  Future<BiometricKind?> available();

  /// `true` — человек подтвердил. Отмена, блокировка, ошибка — `false`:
  /// в любом случае остаётся вход по коду.
  Future<bool> authenticate(BiometricPrompt prompt);
}

class LocalBiometricAuth implements BiometricAuth {
  LocalBiometricAuth();

  final _auth = LocalAuthentication();

  @override
  Future<BiometricKind?> available() async {
    if (kIsWeb) return null;
    try {
      if (!await _auth.isDeviceSupported()) return null;
      final types = await _auth.getAvailableBiometrics();
      if (types.isEmpty) return null;
      // iOS отдаёт ровно face или fingerprint. Android чаще отдаёт только
      // класс (strong / weak) — там почти всегда отпечаток.
      final faceOnly =
          types.contains(BiometricType.face) &&
          !types.contains(BiometricType.fingerprint);
      return faceOnly ? BiometricKind.face : BiometricKind.fingerprint;
    } on PlatformException {
      return null;
    } on LocalAuthException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  @override
  Future<bool> authenticate(BiometricPrompt prompt) async {
    try {
      return await _auth.authenticate(
        localizedReason: prompt.reason,
        // Только биометрия: пароль телефона — не замена коду приложения.
        biometricOnly: true,
        // Свернули посреди проверки — окно закрывается, а не всплывает
        // само при возврате: на Android плагин в этом режиме иногда
        // показывает окно второй раз. Повторный запрос делает экран кода.
        persistAcrossBackgrounding: false,
        // Иначе на Android после распознавания лица нужно ещё нажать
        // «Подтвердить».
        sensitiveTransaction: false,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: prompt.title,
            signInHint: '',
            cancelButton: prompt.cancel,
          ),
          IOSAuthMessages(
            cancelButton: prompt.cancel,
            // Пустая строка — iOS прячет кнопку.
            localizedFallbackTitle: prompt.fallback ?? '',
          ),
        ],
      );
    } on LocalAuthException {
      return false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
BiometricAuth biometricAuth(Ref ref) => LocalBiometricAuth();
