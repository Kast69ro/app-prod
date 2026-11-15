import 'dart:async';

import 'package:activbank_qr/core/api/api_client.dart';
import 'package:activbank_qr/core/api/api_exception.dart';
import 'package:activbank_qr/core/api/auth_interceptor.dart';
import 'package:activbank_qr/core/api/auth_tokens.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http.dart';

const fresh = AuthTokens(access: 'access-2', refresh: 'refresh-2');

/// Бэк, у которого живой только access-2.
class TokenBackend {
  int refreshCalls = 0;
  int refreshStatus = 200;
  bool refreshOffline = false;

  /// Задержка ответа refresh — чтобы параллельные запросы успели упасть с 401.
  Completer<void>? refreshGate;
  final refreshBodies = <Object?>[];

  Future<ResponseBody> respond(RequestOptions o) async {
    if (o.path == '/pos/auth/refresh') {
      refreshCalls++;
      refreshBodies.add(o.data);
      await refreshGate?.future;
      if (refreshOffline) {
        throw DioException.connectionError(requestOptions: o, reason: 'x');
      }
      if (refreshStatus != 200) {
        return jsonBody(refreshStatus, {'detail': 'Refresh недействителен'});
      }
      return jsonBody(200, {'ok': true, ...fresh.toJson()});
    }
    if (o.headers['Authorization'] == 'Bearer access-2') {
      return jsonBody(200, {'path': o.path});
    }
    return jsonBody(401, {'detail': 'Токен истёк'});
  }
}

void main() {
  late TokenBackend backend;
  late AuthTokens? tokens;
  late List<AuthTokens> saved;
  late int expired;

  AuthInterceptor interceptor(Dio dio) => AuthInterceptor(
    dio,
    readTokens: () => tokens,
    saveTokens: (t) async {
      saved.add(t);
      tokens = t;
    },
    onExpired: () async {
      expired++;
      tokens = null;
    },
  );

  ({ApiClient client, FakeAdapter adapter}) api() =>
      fakeApi(backend.respond, auth: interceptor);

  setUp(() {
    backend = TokenBackend();
    tokens = testTokens;
    saved = [];
    expired = 0;
  });

  test('401 → refresh → повтор с новым access', () async {
    final t = api();

    final res = await t.client.get('/pos/terminal');

    expect(res, {'path': '/pos/terminal'});
    expect(backend.refreshCalls, 1);
    expect(backend.refreshBodies.single, {'refresh_token': 'refresh-1'});
    // Ротация: новая пара сохранена целиком.
    expect(saved, [fresh]);
    expect(expired, 0);
  });

  test('параллельные 401 ждут один общий refresh', () async {
    backend.refreshGate = Completer<void>();
    final t = api();

    final all = Future.wait([
      t.client.get('/pos/terminal'),
      t.client.get('/pos/summary'),
      t.client.get('/pos/history'),
    ]);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    backend.refreshGate!.complete();
    final results = await all;

    expect(results.map((r) => r['path']), [
      '/pos/terminal',
      '/pos/summary',
      '/pos/history',
    ]);
    expect(backend.refreshCalls, 1);
  });

  test('пока шёл запрос, пару уже обновили → повтор без refresh', () async {
    var first = true;
    final t = fakeApi((o) async {
      // Бэк ответит 401 на access-1, а к этому моменту токены уже новые.
      if (first) {
        first = false;
        tokens = fresh;
      }
      return backend.respond(o);
    }, auth: (dio) => interceptor(dio));

    final res = await t.client.get('/pos/terminal');

    expect(res, {'path': '/pos/terminal'});
    expect(backend.refreshCalls, 0);
  });

  test('refresh → 401: сессия закончилась, ошибка 401 наверх', () async {
    backend.refreshStatus = 401;
    final t = api();

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
    expect(expired, 1);
    expect(saved, isEmpty);
  });

  test('повтор снова 401 → второго refresh нет', () async {
    final t = fakeApi(
      (o) async => o.path == '/pos/auth/refresh'
          ? jsonBody(200, {'ok': true, ...fresh.toJson()})
          : jsonBody(401, {'detail': 'нет доступа'}),
      auth: interceptor,
    );

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
    expect(saved, [fresh]);
    expect(expired, 0);
  });

  test('нет сети на refresh → ошибка сети, токены не трогаем', () async {
    backend.refreshOffline = true;
    final t = api();

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>().having((e) => e.kind, 'kind', ApiErrorKind.network),
      ),
    );
    expect(expired, 0);
    expect(tokens, testTokens);
  });

  test('401 на ручках входа не запускает refresh', () async {
    final t = api();

    await expectLater(
      t.client.post('/pos/otp/verify', body: {'code': '1'}),
      throwsA(isA<ApiException>()),
    );
    expect(backend.refreshCalls, 0);
  });

  test('без токенов (заблокировано) — без Bearer и без refresh', () async {
    tokens = null;
    final t = api();

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(isA<ApiException>()),
    );
    expect(t.adapter.last!.headers.containsKey('Authorization'), isFalse);
    expect(backend.refreshCalls, 0);
  });

  test('toString не раскрывает токены', () {
    expect('$testTokens', isNot(contains('access-1')));
  });
}
