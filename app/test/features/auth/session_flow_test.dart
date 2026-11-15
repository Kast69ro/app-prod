import 'package:activbank_qr/app/router.dart';
import 'package:activbank_qr/core/api/api_providers.dart';
import 'package:activbank_qr/core/security/pin_hasher.dart';
import 'package:activbank_qr/core/storage/secure_store.dart';
import 'package:activbank_qr/features/auth/domain/session.dart';
import 'package:activbank_qr/features/auth/presentation/session_controller.dart';
import 'package:activbank_qr/features/pin/data/pin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http.dart';

const session = Session(
  phone: '931234567',
  terminalId: '12345',
  terminalName: 'Магазин',
);

void main() {
  late MemorySecureStore store;

  /// Запросы к бэку: путь и тело. Refresh всегда отклоняется (401).
  late List<RequestOptions> requests;

  ProviderContainer makeContainer() {
    final c = ProviderContainer(
      overrides: [
        secureStoreProvider.overrideWithValue(store),
        pinRepositoryProvider.overrideWithValue(
          PinRepository(store, hasher: const PinHasher(iterations: 10)),
        ),
        apiClientProvider.overrideWith(
          (ref) => fakeApi((o) async {
            requests.add(o);
            return o.path == '/pos/auth/logout'
                ? jsonBody(200, {'ok': true})
                : jsonBody(401, {'detail': 'Токен истёк'});
          }, auth: (dio) => authInterceptorFor(ref, dio)).client,
        ),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  setUp(() {
    store = MemorySecureStore();
    requests = [];
  });

  Future<ProviderContainer> signedIn() async {
    final c = makeContainer();
    await c.read(sessionControllerProvider.future);
    final ctl = c.read(sessionControllerProvider.notifier);
    ctl.otpVerified(session, testTokens);
    await ctl.createPin('1234');
    return c;
  }

  test('первый запуск → вход, OTP → создание кода → главная', () async {
    final c = makeContainer();
    final ctl = c.read(sessionControllerProvider.notifier);

    expect(
      (await c.read(sessionControllerProvider.future)).status,
      AuthStatus.signedOut,
    );

    ctl.otpVerified(session, testTokens);
    expect(
      c.read(sessionControllerProvider).value!.status,
      AuthStatus.pinSetup,
    );
    // До создания кода ни сессия, ни токены на диск не пишутся,
    // и запросы данных без кода не идут.
    expect(store.values.containsKey(SecureKeys.session), isFalse);
    expect(store.values.containsKey(SecureKeys.tokens), isFalse);
    expect(c.read(authCredentialsProvider), isNull);

    await ctl.createPin('1234');
    expect(
      c.read(sessionControllerProvider).value!.status,
      AuthStatus.unlocked,
    );
    expect(c.read(authCredentialsProvider), testTokens);
    expect(store.values.containsKey(SecureKeys.tokens), isTrue);
  });

  test('перезапуск → нужен код; верный код открывает', () async {
    await signedIn();

    final c = makeContainer();
    final s = await c.read(sessionControllerProvider.future);
    expect(s.status, AuthStatus.locked);
    expect(s.session, session);
    expect(c.read(authCredentialsProvider), isNull);

    final r = await c.read(sessionControllerProvider.notifier).unlock('1234');
    expect(r, isA<PinOk>());
    expect(
      c.read(sessionControllerProvider).value!.status,
      AuthStatus.unlocked,
    );
    expect(c.read(authCredentialsProvider), testTokens);
  });

  test('сессия от версии без токенов → при запуске вход заново', () async {
    await signedIn();
    store.values.remove(SecureKeys.tokens);

    final c = makeContainer();
    expect(
      (await c.read(sessionControllerProvider.future)).status,
      AuthStatus.signedOut,
    );
    expect(store.values, isEmpty);
  });

  test('5 неверных кодов → сессия стёрта, причина для экрана входа', () async {
    final c = await signedIn();
    final ctl = c.read(sessionControllerProvider.notifier);
    ctl.lock();

    for (var i = 0; i < pinMaxAttempts; i++) {
      await ctl.unlock('0000');
    }

    final s = c.read(sessionControllerProvider).value!;
    expect(s.status, AuthStatus.signedOut);
    expect(s.reason, SignOutReason.pinLockedOut);
    expect(store.values, isEmpty);
    // refresh отозван на бэке.
    await pumpEventQueue();
    expect(requests.single.path, '/pos/auth/logout');
    expect(requests.single.data, {'refresh_token': 'refresh-1'});
  });

  test('«Выйти» → всё стёрто, refresh отозван', () async {
    final c = await signedIn();

    await c.read(sessionControllerProvider.notifier).signOut();
    await pumpEventQueue();

    final s = c.read(sessionControllerProvider).value!;
    expect(s.status, AuthStatus.signedOut);
    expect(s.reason, isNull);
    expect(store.values, isEmpty);
    expect(c.read(authCredentialsProvider), isNull);
    expect(requests.single.path, '/pos/auth/logout');
  });

  test('refresh отклонён → выход с причиной «сессия истекла»', () async {
    final c = await signedIn();

    await expectLater(
      c.read(apiClientProvider).get('/pos/terminal'),
      throwsA(anything),
    );
    await pumpEventQueue();

    final s = c.read(sessionControllerProvider).value!;
    expect(s.status, AuthStatus.signedOut);
    expect(s.reason, SignOutReason.sessionExpired);
    expect(store.values, isEmpty);
    // Мёртвый refresh не отзываем — бэк его уже отклонил.
    expect(requests.map((r) => r.path), ['/pos/terminal', '/pos/auth/refresh']);
    expect(requests.first.headers['Authorization'], 'Bearer access-1');
  });

  test('код так и не создали → при запуске хвосты стираются', () async {
    store.values[SecureKeys.session] = '{"phone":"931234567"}';
    final c = makeContainer();
    expect(
      (await c.read(sessionControllerProvider.future)).status,
      AuthStatus.signedOut,
    );
    expect(store.values, isEmpty);
  });

  group('вход по биометрии', () {
    test('включённый — снимает блокировку и прощает неверные коды', () async {
      final c = makeContainer();
      await c.read(sessionControllerProvider.future);
      final ctl = c.read(sessionControllerProvider.notifier);
      ctl.otpVerified(session, testTokens);
      await ctl.createPin('1234', biometric: true);
      expect(store.values[SecureKeys.biometric], '1');
      ctl.lock();
      await ctl.unlock('0000');
      await ctl.unlock('0000');

      await ctl.unlockWithBiometrics();

      expect(
        c.read(sessionControllerProvider).value!.status,
        AuthStatus.unlocked,
      );
      expect(c.read(authCredentialsProvider), testTokens);
      expect(store.values.containsKey(SecureKeys.pinFailures), isFalse);
    });

    test('выключенный — блокировку не снимает', () async {
      final c = await signedIn();
      final ctl = c.read(sessionControllerProvider.notifier);
      ctl.lock();

      await ctl.unlockWithBiometrics();

      expect(
        c.read(sessionControllerProvider).value!.status,
        AuthStatus.locked,
      );
      expect(c.read(authCredentialsProvider), isNull);
    });

    test('не на экране кода — ничего не делает', () async {
      final c = makeContainer();
      await c.read(sessionControllerProvider.future);
      final ctl = c.read(sessionControllerProvider.notifier);
      ctl.otpVerified(session, testTokens);

      await ctl.unlockWithBiometrics();

      expect(
        c.read(sessionControllerProvider).value!.status,
        AuthStatus.pinSetup,
      );
    });

    test('выход стирает и отметку биометрии', () async {
      final c = makeContainer();
      await c.read(sessionControllerProvider.future);
      final ctl = c.read(sessionControllerProvider.notifier);
      ctl.otpVerified(session, testTokens);
      await ctl.createPin('1234', biometric: true);

      await ctl.signOut();

      expect(store.values, isEmpty);
    });
  });

  test('lock убирает токен из запросов, но не из хранилища', () async {
    final c = await signedIn();

    c.read(sessionControllerProvider.notifier).lock();

    expect(c.read(sessionControllerProvider).value!.status, AuthStatus.locked);
    expect(c.read(authCredentialsProvider), isNull);
    expect(store.values.containsKey(SecureKeys.tokens), isTrue);
  });

  group('redirectFor', () {
    AsyncValue<SessionState> st(AuthStatus s) =>
        AsyncData(SessionState(status: s));

    test('загрузка → сплэш', () {
      expect(redirectFor(const AsyncLoading(), Routes.home), Routes.splash);
    });

    test('не вошли → вход', () {
      expect(redirectFor(st(AuthStatus.signedOut), Routes.home), Routes.login);
      expect(redirectFor(st(AuthStatus.signedOut), Routes.login), isNull);
    });

    test('создание и ввод кода → экран кода', () {
      expect(redirectFor(st(AuthStatus.pinSetup), Routes.login), Routes.pin);
      expect(redirectFor(st(AuthStatus.locked), Routes.home), Routes.pin);
    });

    test('открыто → главная, внутренние экраны не трогаем', () {
      expect(redirectFor(st(AuthStatus.unlocked), Routes.pin), Routes.home);
      expect(redirectFor(st(AuthStatus.unlocked), Routes.home), isNull);
      expect(redirectFor(st(AuthStatus.unlocked), '/history'), isNull);
    });

    test('ошибка загрузки сессии → вход', () {
      expect(
        redirectFor(AsyncError(Exception(), StackTrace.empty), Routes.home),
        Routes.login,
      );
    });
  });
}
