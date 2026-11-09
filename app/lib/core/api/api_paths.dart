/// Ручки бэка. Контракт — `docs/pos_api_handoff.md`.
abstract final class ApiPaths {
  static const otpRequest = '/pos/otp/request';
  static const otpVerify = '/pos/otp/verify';
  static const terminal = '/pos/terminal';
  static const summary = '/pos/summary';
  static const history = '/pos/history';

  /// Размер страницы истории.
  static const historyPageSize = 50;

  /// Максимум `limit` на бэке — им выкачиваем период для отчёта.
  static const historyMaxPageSize = 200;
}
