import 'package:dio/dio.dart';

import 'api_exception.dart';

typedef Json = Map<String, dynamic>;

/// Единственная точка выхода в сеть. Экраны сюда не ходят —
/// только репозитории. Логов запросов нет намеренно (банк).
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Json> get(String path, {Map<String, Object?> query = const {}}) =>
      _send(
        () => _dio.get<Object?>(
          path,
          queryParameters: {
            for (final e in query.entries)
              if (e.value != null) e.key: e.value,
          },
        ),
      );

  Future<Json> post(String path, {Json body = const {}}) =>
      _send(() => _dio.post<Object?>(path, data: body));

  Future<Json> _send(Future<Response<Object?>> Function() request) async {
    if (_dio.options.baseUrl.isEmpty) {
      throw const ApiException(ApiErrorKind.notConfigured);
    }
    try {
      final response = await request();
      final data = response.data;
      if (data is Json) return data;
      throw ApiException(
        ApiErrorKind.badResponse,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  static ApiException _map(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiException(ApiErrorKind.timeout);
      case DioExceptionType.badResponse:
        return ApiException(
          ApiErrorKind.http,
          statusCode: e.response?.statusCode,
          detail: _detail(e.response?.data),
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return const ApiException(ApiErrorKind.network);
    }
  }

  /// `detail` бывает строкой; у ошибок валидации FastAPI — списком, его не показываем.
  static String? _detail(Object? data) {
    if (data is Map && data['detail'] is String) {
      final text = (data['detail'] as String).trim();
      return text.isEmpty ? null : text;
    }
    return null;
  }
}
