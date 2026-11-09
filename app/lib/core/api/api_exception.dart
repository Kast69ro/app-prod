/// Что пошло не так с запросом — для выбора экрана и текста ошибки.
enum ApiErrorKind {
  /// Нет сети или сервер недоступен.
  network,

  /// Сервер не ответил вовремя.
  timeout,

  /// Сервер ответил кодом 4xx / 5xx.
  http,

  /// Ответ не разобрался (не тот формат).
  badResponse,

  /// Адрес сервера не задан в сборке.
  notConfigured,
}

/// Единая ошибка API. Экран показывает [detail] с бэка, если он есть.
class ApiException implements Exception {
  const ApiException(this.kind, {this.statusCode, this.detail});

  final ApiErrorKind kind;
  final int? statusCode;

  /// Текст `detail` из ответа бэка.
  final String? detail;

  /// Нет сети / таймаут — показываем экран с кнопкой «Повторить».
  bool get isConnectivity =>
      kind == ApiErrorKind.network || kind == ApiErrorKind.timeout;

  /// Без телефона, кодов и тела ответа — безопасно для логов.
  @override
  String toString() => 'ApiException($kind, $statusCode)';
}
