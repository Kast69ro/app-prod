import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/utils/phone_format.dart';
import '../data/auth_repository.dart';
import '../data/sms_code_reader.dart';
import '../domain/login_failure.dart';
import 'session_controller.dart';

part 'login_controller.freezed.dart';
part 'login_controller.g.dart';

const otpLength = 6;
const otpResendCooldown = 60;

enum LoginStep { phone, code }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStep.phone) LoginStep step,
    @Default('') String phone,
    @Default('') String code,
    @Default(false) bool loading,
    LoginFailure? failure,

    /// Сколько секунд до «Отправить код снова».
    @Default(0) int resendIn,

    /// Срок действия кода из ответа бэка, сек.
    @Default(300) int codeExpiresIn,
  }) = _LoginState;

  const LoginState._();

  bool get phoneReady => phone.length == phoneDigits;
  bool get codeReady => code.length == otpLength;
  bool get canSubmit => step == LoginStep.phone ? phoneReady : codeReady;
}

@riverpod
class LoginController extends _$LoginController {
  Timer? _resendTimer;

  late SmsCodeReader _sms;
  bool _smsWaiting = false;

  /// Номер текущего ожидания SMS: ответ от старого ожидания
  /// (после «Сменить номер» или повторной отправки) не подставляем.
  int _smsWait = 0;

  @override
  LoginState build() {
    _sms = ref.watch(smsCodeReaderProvider);
    ref.onDispose(() {
      _resendTimer?.cancel();
      _stopSmsWait();
    });
    return const LoginState();
  }

  /// Нажатие цифры или «стереть» (`null`) на клавиатуре.
  void key(String? digit) {
    if (state.loading) return;
    final isPhone = state.step == LoginStep.phone;
    final value = isPhone ? state.phone : state.code;
    final max = isPhone ? phoneDigits : otpLength;

    final String next;
    if (digit == null) {
      if (value.isEmpty) return;
      next = value.substring(0, value.length - 1);
    } else {
      if (value.length >= max) return;
      next = value + digit;
    }

    state = isPhone
        ? state.copyWith(phone: next, failure: null)
        : state.copyWith(code: next, failure: null);

    // Как в прототипе: код уходит сам после 6-й цифры, с небольшой паузой,
    // чтобы пользователь увидел последнюю цифру.
    if (!isPhone && next.length == otpLength) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (ref.mounted && state.code == next) verifyOtp();
      });
    }
  }

  Future<void> submit() =>
      state.step == LoginStep.phone ? requestOtp() : verifyOtp();

  Future<void> requestOtp() async {
    if (!state.phoneReady || state.loading) return;
    state = state.copyWith(loading: true, failure: null);
    try {
      final expiresIn = await ref
          .read(authRepositoryProvider)
          .requestOtp(state.phone);
      if (!ref.mounted) return;
      state = state.copyWith(
        loading: false,
        step: LoginStep.code,
        code: '',
        codeExpiresIn: expiresIn,
      );
      _startResendTimer();
      unawaited(_waitForSms());
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        loading: false,
        failure: LoginFailure.fromRequest(e),
      );
    }
  }

  Future<void> verifyOtp() async {
    if (!state.codeReady || state.loading) return;
    state = state.copyWith(loading: true, failure: null);
    try {
      final session = await ref
          .read(authRepositoryProvider)
          .verifyOtp(state.phone, state.code);
      if (!ref.mounted) return;
      state = state.copyWith(loading: false);
      ref.read(sessionControllerProvider.notifier).otpVerified(session);
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        loading: false,
        code: '',
        failure: LoginFailure.fromVerify(e),
      );
    }
  }

  Future<void> resend() async {
    if (state.resendIn > 0) return;
    await requestOtp();
  }

  void backToPhone() {
    if (state.loading) return;
    _resendTimer?.cancel();
    _stopSmsWait();
    state = state.copyWith(
      step: LoginStep.phone,
      code: '',
      failure: null,
      resendIn: 0,
    );
  }

  /// Android спросит «Разрешить прочитать SMS?» — код подставится
  /// и уйдёт сам, как будто его набрали.
  Future<void> _waitForSms() async {
    if (_smsWaiting) await _sms.cancel();
    _smsWaiting = true;
    final wait = ++_smsWait;
    final code = await _sms.listen(otpLength);
    if (wait != _smsWait) return;
    _smsWaiting = false;
    if (!ref.mounted || code == null) return;
    if (state.step != LoginStep.code || state.loading) return;
    state = state.copyWith(code: '');
    for (final digit in code.split('')) {
      key(digit);
    }
  }

  void _stopSmsWait() {
    if (!_smsWaiting) return;
    _smsWaiting = false;
    _smsWait++;
    unawaited(_sms.cancel());
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    state = state.copyWith(resendIn: otpResendCooldown);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      final left = state.resendIn - 1;
      state = state.copyWith(resendIn: left < 0 ? 0 : left);
      if (left <= 0) t.cancel();
    });
  }
}
