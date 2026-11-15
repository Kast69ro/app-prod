/// Ручки бэка. Контракт — `docs/mobile_api_jwt.md`.
abstract final class ApiPaths {
  static const otpRequest = '/pos/otp/request';
  static const otpVerify = '/pos/otp/verify';
  static const authRefresh = '/pos/auth/refresh';
  static const authLogout = '/pos/auth/logout';

  /// Ручки без `Authorization: Bearer` и без refresh по 401.
  static const public = {otpRequest, otpVerify, authRefresh, authLogout};

  static const terminal = '/pos/terminal';
  static const summary = '/pos/summary';
  static const history = '/pos/history';

  /// Размер страницы истории.
  static const historyPageSize = 50;

  /// Максимум `limit` на бэке — им выкачиваем период для отчёта.
  static const historyMaxPageSize = 200;
}
