import 'dart:convert';
import 'dart:typed_data';

import 'package:activbank_qr/core/api/api_client.dart';
import 'package:activbank_qr/core/api/auth_interceptor.dart';
import 'package:activbank_qr/core/api/auth_tokens.dart';
import 'package:dio/dio.dart';

/// Подменяет сеть: отдаёт заранее заданный ответ и запоминает запрос.
class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.respond);

  final Future<ResponseBody> Function(RequestOptions options) respond;
  RequestOptions? last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    last = options;
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonBody(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

const testTokens = AuthTokens(access: 'access-1', refresh: 'refresh-1');

/// [auth] — свой интерсептор (например, `authInterceptorFor` из провайдеров).
/// Без него — с фиксированными [tokens] и без refresh.
({ApiClient client, FakeAdapter adapter}) fakeApi(
  Future<ResponseBody> Function(RequestOptions) respond, {
  String baseUrl = 'http://test',
  AuthTokens? tokens,
  Interceptor Function(Dio dio)? auth,
}) {
  final adapter = FakeAdapter(respond);
  final dio = Dio(BaseOptions(baseUrl: baseUrl))..httpClientAdapter = adapter;
  dio.interceptors.add(
    auth?.call(dio) ??
        AuthInterceptor(
          dio,
          readTokens: () => tokens,
          saveTokens: (_) async {},
          onExpired: () async {},
        ),
  );
  return (client: ApiClient(dio), adapter: adapter);
}
