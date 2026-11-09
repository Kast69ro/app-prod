import 'dart:convert';

import 'package:activbank_qr/core/api/api_exception.dart';
import 'package:activbank_qr/core/storage/secure_store.dart';
import 'package:activbank_qr/features/auth/data/auth_repository.dart';
import 'package:activbank_qr/features/auth/data/session_store.dart';
import 'package:activbank_qr/features/auth/domain/login_failure.dart';
import 'package:activbank_qr/features/auth/domain/session.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http.dart';

void main() {
  group('AuthRepository', () {
    test('requestOtp отправляет полный номер и отдаёт expires_in', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'ok': true,
          'message': 'Код отправлен по SMS',
          'expires_in': 180,
        }),
      );

      final expires = await AuthRepository(t.client).requestOtp('931234567');

      expect(expires, 180);
      expect(t.adapter.last!.path, '/pos/otp/request');
      expect(t.adapter.last!.data, {'phone': '+992931234567'});
    });

    test('verifyOtp собирает сессию, terminalId числом → строкой', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'ok': true,
          'message': 'Код подтверждён, вход выполнен',
          'terminalId': 12345,
          'terminalName': 'Магазин на Рудаки',
          'storeName': 'ООО Ромашка',
        }),
      );

      final s = await AuthRepository(t.client).verifyOtp('931234567', '123456');

      expect(
        s,
        const Session(
          phone: '931234567',
          terminalId: '12345',
          terminalName: 'Магазин на Рудаки',
          storeName: 'ООО Ромашка',
        ),
      );
      expect(t.adapter.last!.data, {
        'phone': '+992931234567',
        'code': '123456',
      });
    });

    test('ответ не того формата → badResponse', () async {
      final t = fakeApi((_) async => jsonBody(200, {'terminalName': 42}));

      await expectLater(
        AuthRepository(t.client).verifyOtp('931234567', '123456'),
        throwsA(
          isA<ApiException>().having(
            (e) => e.kind,
            'kind',
            ApiErrorKind.badResponse,
          ),
        ),
      );
    });
  });

  group('LoginFailure', () {
    ApiException http(int code, [String? detail]) =>
        ApiException(ApiErrorKind.http, statusCode: code, detail: detail);

    test('ошибки запроса кода', () {
      expect(
        LoginFailure.fromRequest(http(404)).kind,
        LoginFailureKind.terminalNotFound,
      );
      expect(
        LoginFailure.fromRequest(http(403)).kind,
        LoginFailureKind.notOurMerchant,
      );
      final tooSoon = LoginFailure.fromRequest(http(429, 'Повтор через 42 с'));
      expect(tooSoon.kind, LoginFailureKind.otpTooSoon);
      expect(tooSoon.detail, 'Повтор через 42 с');
    });

    test('ошибки проверки кода', () {
      final wrong = LoginFailure.fromVerify(http(400, 'Осталось попыток: 2'));
      expect(wrong.kind, LoginFailureKind.otpWrong);
      expect(wrong.detail, 'Осталось попыток: 2');
      expect(
        LoginFailure.fromVerify(http(429)).kind,
        LoginFailureKind.otpTooManyAttempts,
      );
    });

    test('сеть и таймаут', () {
      expect(
        LoginFailure.fromVerify(const ApiException(ApiErrorKind.network)).kind,
        LoginFailureKind.noConnection,
      );
      expect(
        LoginFailure.fromRequest(const ApiException(ApiErrorKind.timeout)).kind,
        LoginFailureKind.timeout,
      );
      expect(
        LoginFailure.fromRequest(http(500)).kind,
        LoginFailureKind.unknown,
      );
    });
  });

  group('SessionStore', () {
    const session = Session(
      phone: '931234567',
      terminalId: '12345',
      terminalName: 'Магазин',
      storeName: 'ООО',
      terminalQR: '000201...',
    );

    test('запись и чтение', () async {
      final store = SessionStore(MemorySecureStore());
      expect(await store.read(), isNull);
      await store.write(session);
      expect(await store.read(), session);
    });

    test('повреждённая запись удаляется', () async {
      final mem = MemorySecureStore()
        ..values[SecureKeys.session] = jsonEncode({'phone': 5});
      final store = SessionStore(mem);
      expect(await store.read(), isNull);
      expect(mem.values.containsKey(SecureKeys.session), isFalse);
    });

    test('wipe стирает всё', () async {
      final mem = MemorySecureStore()
        ..values[SecureKeys.pinRecord] = 'x'
        ..values[SecureKeys.pinFailures] = '2';
      final store = SessionStore(mem);
      await store.write(session);
      await store.wipe();
      expect(mem.values, isEmpty);
    });
  });
}
