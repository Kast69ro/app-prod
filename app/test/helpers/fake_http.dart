import 'dart:convert';
import 'dart:typed_data';

import 'package:activbank_qr/core/api/api_client.dart';
import 'package:activbank_qr/core/api/auth_interceptor.dart';
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

({ApiClient client, FakeAdapter adapter}) fakeApi(
  Future<ResponseBody> Function(RequestOptions) respond, {
  String baseUrl = 'http://test',
  String? phone,
  String? Function()? readPhone,
}) {
  final adapter = FakeAdapter(respond);
  final dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..httpClientAdapter = adapter
    ..interceptors.add(AuthInterceptor(readPhone: readPhone ?? () => phone));
  return (client: ApiClient(dio), adapter: adapter);
}
