/// Ручки бэка. Контракт — `docs/mobile_api_jwt.md`.
abstract final class ApiPaths {
  static const otpRequest = '/mobi/otp/request';
  static const otpVerify = '/mobi/otp/verify';
  static const authRefresh = '/mobi/auth/refresh';
  static const authLogout = '/mobi/auth/logout';

  /// Ручки без `Authorization: Bearer` и без refresh по 401.
  static const public = {otpRequest, otpVerify, authRefresh, authLogout};

  static const terminal = '/mobi/terminal';
  static const summary = '/mobi/summary';
  static const history = '/mobi/history';

  /// Размер страницы истории.
  static const historyPageSize = 50;

  /// Максимум `limit` на бэке — им выкачиваем период для отчёта.
  static const historyMaxPageSize = 200;
}
