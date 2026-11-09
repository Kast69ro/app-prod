import '../../l10n/app_localizations.dart';
import '../api/api_exception.dart';

/// Текст ошибки для экранов данных. `detail` с бэка — в приоритете.
String apiErrorText(Object error, AppLocalizations l) {
  if (error is! ApiException) return l.errorUnknown;
  return switch (error.kind) {
    ApiErrorKind.network => l.errorNoConnection,
    ApiErrorKind.timeout => l.errorTimeout,
    ApiErrorKind.notConfigured => l.errorNotConfigured,
    ApiErrorKind.http ||
    ApiErrorKind.badResponse => error.detail ?? l.errorUnknown,
  };
}
