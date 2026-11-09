import 'package:dio/dio.dart';

/// Подставляет данные авторизации в запросы.
///
/// Сейчас бэк узнаёт терминал по `?phone=` в GET-запросах.
/// Когда появятся токены, здесь будет `Authorization: Bearer` и refresh по 401 —
/// остальной код менять не придётся.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.readPhone});

  /// Текущий номер сессии (`+992…`) или `null`, если не вошли.
  final String? Function() readPhone;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final phone = readPhone();
    if (options.method == 'GET' && phone != null) {
      options.queryParameters = {...options.queryParameters, 'phone': phone};
    }
    handler.next(options);
  }
}
