import 'dart:async';

import 'package:dio/dio.dart';

import 'api_paths.dart';
import 'auth_tokens.dart';

/// Авторизация запросов: `Authorization: Bearer <access>` и refresh по 401.
///
/// 401 на запросе данных → один `POST /mobi/auth/refresh` → повтор запроса
/// с новым access. Если 401 пришёл и на refresh — токены мертвы,
/// вызываем [onExpired] (выход на вход по SMS).
///
/// Refresh ротируется (старый refresh после обновления не работает),
/// поэтому параллельные запросы с 401 ждут один общий refresh,
/// а не шлют каждый свой.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._dio, {
    required this.readTokens,
    required this.saveTokens,
    required this.onExpired,
  });

  /// Тот же [Dio], куда добавлен интерсептор: через него идут refresh и повтор.
  final Dio _dio;

  /// Токены текущей сессии или `null` (не вошли / заблокировано).
  final AuthTokens? Function() readTokens;

  /// Сохранить новую пару после refresh.
  final Future<void> Function(AuthTokens tokens) saveTokens;

  /// Refresh отклонён — сессия закончилась.
  final Future<void> Function() onExpired;

  Future<AuthTokens?>? _refreshing;

  /// Метка повторного запроса: второй 401 подряд уже не обновляем.
  static const _retried = 'abqr.auth.retried';

  static const _header = 'Authorization';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!ApiPaths.public.contains(options.path)) {
      final tokens = readTokens();
      if (tokens != null) {
        options.headers[_header] = 'Bearer ${tokens.access}';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final current = readTokens();
    if (err.response?.statusCode != 401 ||
        ApiPaths.public.contains(options.path) ||
        options.extra[_retried] == true ||
        current == null) {
      return handler.next(err);
    }

    try {
      // Пока этот запрос шёл, другой уже обновил токены — просто повторяем.
      final sentWith = options.headers[_header];
      final tokens = sentWith == 'Bearer ${current.access}'
          ? await _refresh(current)
          : current;
      if (tokens == null) return handler.next(err);

      final retry = options.copyWith(
        headers: {...options.headers, _header: 'Bearer ${tokens.access}'},
        extra: {...options.extra, _retried: true},
      );
      handler.resolve(await _dio.fetch<Object?>(retry));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<AuthTokens?> _refresh(AuthTokens current) =>
      _refreshing ??= _doRefresh(current).whenComplete(() {
        _refreshing = null;
      });

  /// Новая пара или `null`, если refresh отклонён (401).
  /// Нет сети / таймаут — бросает ошибку, токены не трогаем.
  Future<AuthTokens?> _doRefresh(AuthTokens current) async {
    final Response<Object?> response;
    try {
      response = await _dio.post<Object?>(
        ApiPaths.authRefresh,
        data: {'refresh_token': current.refresh},
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await onExpired();
        return null;
      }
      rethrow;
    }

    final AuthTokens tokens;
    try {
      tokens = AuthTokens.fromJson(response.data as Map<String, dynamic>);
    } on Object {
      throw DioException.badResponse(
        statusCode: response.statusCode ?? 200,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    await saveTokens(tokens);
    return tokens;
  }
}
