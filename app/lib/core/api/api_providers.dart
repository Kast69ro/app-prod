import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/env.dart';
import 'api_client.dart';
import 'auth_interceptor.dart';

part 'api_providers.g.dart';

/// Номер терминала текущей сессии (`+992…`). Заполняет auth после входа.
@Riverpod(keepAlive: true)
class AuthCredentials extends _$AuthCredentials {
  @override
  String? build() => null;

  void setPhone(String? phone) => state = phone;
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final env = ref.watch(envProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: env.apiBaseUrl,
      connectTimeout: env.connectTimeout,
      receiveTimeout: env.receiveTimeout,
      sendTimeout: env.connectTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );
  dio.interceptors.add(
    AuthInterceptor(readPhone: () => ref.read(authCredentialsProvider)),
  );
  ref.onDispose(dio.close);
  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(ref.watch(dioProvider));
