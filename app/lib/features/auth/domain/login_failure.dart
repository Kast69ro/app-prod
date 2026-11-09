import '../../../core/api/api_exception.dart';

enum LoginFailureKind {
  terminalNotFound,
  notOurMerchant,
  otpTooSoon,
  otpWrong,
  otpTooManyAttempts,
  noConnection,
  timeout,
  notConfigured,
  unknown,
}

/// Ошибка входа. Текст выбирает экран; [detail] с бэка — в приоритете.
class LoginFailure {
  const LoginFailure(this.kind, [this.detail]);

  final LoginFailureKind kind;
  final String? detail;

  /// Ошибка `POST /pos/otp/request`.
  factory LoginFailure.fromRequest(ApiException e) => switch (e) {
    ApiException(statusCode: 404) => const LoginFailure(
      LoginFailureKind.terminalNotFound,
    ),
    ApiException(statusCode: 403) => const LoginFailure(
      LoginFailureKind.notOurMerchant,
    ),
    ApiException(statusCode: 429) => LoginFailure(
      LoginFailureKind.otpTooSoon,
      e.detail,
    ),
    _ => _common(e),
  };

  /// Ошибка `POST /pos/otp/verify`.
  factory LoginFailure.fromVerify(ApiException e) => switch (e) {
    ApiException(statusCode: 429) => LoginFailure(
      LoginFailureKind.otpTooManyAttempts,
      e.detail,
    ),
    ApiException(statusCode: 400) => LoginFailure(
      LoginFailureKind.otpWrong,
      e.detail,
    ),
    _ => _common(e),
  };

  static LoginFailure _common(ApiException e) => switch (e.kind) {
    ApiErrorKind.network => const LoginFailure(LoginFailureKind.noConnection),
    ApiErrorKind.timeout => const LoginFailure(LoginFailureKind.timeout),
    ApiErrorKind.notConfigured => const LoginFailure(
      LoginFailureKind.notConfigured,
    ),
    ApiErrorKind.http || ApiErrorKind.badResponse => LoginFailure(
      LoginFailureKind.unknown,
      e.detail,
    ),
  };
}
