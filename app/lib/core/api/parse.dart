import 'api_exception.dart';

/// Разбор ответа: ответ не того формата — та же ошибка, что и битый JSON.
T parseResponse<T>(T Function() parse) {
  try {
    return parse();
  } on TypeError {
    throw const ApiException(ApiErrorKind.badResponse);
  } on FormatException {
    throw const ApiException(ApiErrorKind.badResponse);
  }
}
