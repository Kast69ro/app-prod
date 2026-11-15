import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/env.dart';
import '../storage/token_store.dart';
import 'api_client.dart';
import 'auth_interceptor.dart';
import 'auth_tokens.dart';

part 'api_providers.g.dart';

/// Токены, с которыми сейчас идут запросы. `null` — не вошли или
/// приложение заблокировано (ждём код). Заполняет `SessionController`.
@Riverpod(keepAlive: true)
class AuthCredentials extends _$AuthCredentials {
  @override
  AuthTokens? build() => null;

  void set(AuthTokens? tokens) => state = tokens;
}

/// Счётчик «refresh отклонён». `SessionController` слушает его и выходит
/// на вход по SMS. Через событие, чтобы `core/` не зависел от `features/`.
@Riverpod(keepAlive: true)
class SessionExpiry extends _$SessionExpiry {
  @override
  int build() => 0;

  void expired() => state++;
}

/// Интерсептор, связанный с хранилищем и сессией. Отдельно — для тестов.
AuthInterceptor authInterceptorFor(Ref ref, Dio dio) => AuthInterceptor(
  dio,
  readTokens: () => ref.read(authCredentialsProvider),
  saveTokens: (tokens) async {
    // В хранилище — всегда: старый refresh после ротации уже мёртв.
    await ref.read(tokenStoreProvider).write(tokens);
    final creds = ref.read(authCredentialsProvider.notifier);
    if (ref.read(authCredentialsProvider) != null) creds.set(tokens);
  },
  onExpired: () async {
    ref.read(authCredentialsProvider.notifier).set(null);
    ref.read(sessionExpiryProvider.notifier).expired();
  },
);

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
  dio.interceptors.add(authInterceptorFor(ref, dio));
  ref.onDispose(dio.close);
  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(ref.watch(dioProvider));
