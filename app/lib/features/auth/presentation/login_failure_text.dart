import '../../../l10n/app_localizations.dart';
import '../domain/login_failure.dart';

/// Текст ошибки входа. Где бэк присылает `detail`, показываем его.
String loginFailureText(LoginFailure f, AppLocalizations l) => switch (f.kind) {
  LoginFailureKind.terminalNotFound => l.errTerminalNotFound,
  LoginFailureKind.notOurMerchant => l.errNotOurMerchant,
  LoginFailureKind.otpTooSoon => f.detail ?? l.errOtpTooSoon,
  LoginFailureKind.otpWrong => f.detail ?? l.errOtpWrong,
  LoginFailureKind.otpTooManyAttempts => f.detail ?? l.errOtpTooMany,
  LoginFailureKind.noConnection => l.errorNoConnection,
  LoginFailureKind.timeout => l.errorTimeout,
  LoginFailureKind.notConfigured => l.errorNotConfigured,
  LoginFailureKind.unknown => f.detail ?? l.errorUnknown,
};
