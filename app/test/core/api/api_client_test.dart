import 'package:activbank_qr/core/api/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http.dart';

void main() {
  test('GET возвращает JSON и добавляет phone', () async {
    final t = fakeApi(
      (_) async => jsonBody(200, {'ok': true}),
      phone: '+992931234567',
    );

    final res = await t.client.get(
      '/pos/summary',
      query: {'date': '2026-09-08'},
    );

    expect(res, {'ok': true});
    expect(t.adapter.last!.queryParameters, {
      'date': '2026-09-08',
      'phone': '+992931234567',
    });
  });

  test('POST не получает phone в query', () async {
    final t = fakeApi(
      (_) async => jsonBody(200, {'ok': true}),
      phone: '+992931234567',
    );

    await t.client.post('/pos/otp/request', body: {'phone': '+992931234567'});

    expect(t.adapter.last!.queryParameters, isEmpty);
  });

  test('null-параметры не уходят в запрос', () async {
    final t = fakeApi((_) async => jsonBody(200, {}));

    await t.client.get('/pos/history', query: {'date': null, 'limit': 50});

    expect(t.adapter.last!.queryParameters, {'limit': 50});
  });

  test('ошибка HTTP приносит код и detail', () async {
    final t = fakeApi(
      (_) async => jsonBody(400, {'detail': 'Осталось попыток: 2'}),
    );

    await expectLater(
      t.client.post('/pos/otp/verify'),
      throwsA(
        isA<ApiException>()
            .having((e) => e.kind, 'kind', ApiErrorKind.http)
            .having((e) => e.statusCode, 'statusCode', 400)
            .having((e) => e.detail, 'detail', 'Осталось попыток: 2'),
      ),
    );
  });

  test('detail-список (валидация) не показываем', () async {
    final t = fakeApi(
      (_) async => jsonBody(422, {
        'detail': [
          {'msg': 'field required'},
        ],
      }),
    );

    await expectLater(
      t.client.post('/pos/otp/verify'),
      throwsA(isA<ApiException>().having((e) => e.detail, 'detail', isNull)),
    );
  });

  test('нет сети → network', () async {
    final t = fakeApi(
      (o) async => throw DioException.connectionError(
        requestOptions: o,
        reason: 'refused',
      ),
    );

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>()
            .having((e) => e.kind, 'kind', ApiErrorKind.network)
            .having((e) => e.isConnectivity, 'isConnectivity', isTrue),
      ),
    );
  });

  test('таймаут → timeout', () async {
    final t = fakeApi(
      (o) async => throw DioException.receiveTimeout(
        timeout: const Duration(seconds: 1),
        requestOptions: o,
      ),
    );

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>().having((e) => e.kind, 'kind', ApiErrorKind.timeout),
      ),
    );
  });

  test('ответ не JSON-объект → badResponse', () async {
    final t = fakeApi((_) async => jsonBody(200, [1, 2, 3]));

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.kind,
          'kind',
          ApiErrorKind.badResponse,
        ),
      ),
    );
  });

  test('пустой адрес сервера → notConfigured, запрос не уходит', () async {
    final t = fakeApi((_) async => jsonBody(200, {}), baseUrl: '');

    await expectLater(
      t.client.get('/pos/terminal'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.kind,
          'kind',
          ApiErrorKind.notConfigured,
        ),
      ),
    );
    expect(t.adapter.last, isNull);
  });

  test('toString не содержит detail', () {
    const e = ApiException(
      ApiErrorKind.http,
      statusCode: 400,
      detail: 'секрет',
    );
    expect(e.toString(), isNot(contains('секрет')));
  });
}
