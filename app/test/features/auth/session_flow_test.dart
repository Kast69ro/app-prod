import 'package:activbank_qr/app/router.dart';
import 'package:activbank_qr/core/api/api_providers.dart';
import 'package:activbank_qr/core/security/pin_hasher.dart';
import 'package:activbank_qr/core/storage/secure_store.dart';
import 'package:activbank_qr/features/auth/domain/session.dart';
import 'package:activbank_qr/features/auth/presentation/session_controller.dart';
import 'package:activbank_qr/features/pin/data/pin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const session = Session(
  phone: '931234567',
  terminalId: '12345',
  terminalName: 'Магазин',
);

void main() {
  late MemorySecureStore store;

  ProviderContainer makeContainer() {
    final c = ProviderContainer(
      overrides: [
        secureStoreProvider.overrideWithValue(store),
        pinRepositoryProvider.overrideWithValue(
          PinRepository(store, hasher: const PinHasher(iterations: 10)),
        ),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  setUp(() => store = MemorySecureStore());

  test('первый запуск → вход, OTP → создание кода → главная', () async {
    final c = makeContainer();
    final ctl = c.read(sessionControllerProvider.notifier);

    expect(
      (await c.read(sessionControllerProvider.future)).status,
      AuthStatus.signedOut,
    );

    ctl.otpVerified(session);
    expect(
      c.read(sessionControllerProvider).value!.status,
      AuthStatus.pinSetup,
    );
    // До создания кода сессия на диск не пишется.
    expect(store.values.containsKey(SecureKeys.session), isFalse);

    await ctl.createPin('1234');
    expect(
      c.read(sessionControllerProvider).value!.status,
      AuthStatus.unlocked,
    );
    expect(c.read(authCredentialsProvider), '+992931234567');
  });

  test('перезапуск → нужен код; верный код открывает', () async {
    final first = makeContainer();
    first.read(sessionControllerProvider.notifier).otpVerified(session);
    await first.read(sessionControllerProvider.notifier).createPin('1234');

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
  });

  test('5 неверных кодов → сессия стёрта, причина для экрана входа', () async {
    final c = makeContainer();
    await c.read(sessionControllerProvider.future);
    final ctl = c.read(sessionControllerProvider.notifier);
    ctl.otpVerified(session);
    await ctl.createPin('1234');
    ctl.lock();

    for (var i = 0; i < pinMaxAttempts; i++) {
      await ctl.unlock('0000');
    }

    final s = c.read(sessionControllerProvider).value!;
    expect(s.status, AuthStatus.signedOut);
    expect(s.reason, SignOutReason.pinLockedOut);
    expect(store.values, isEmpty);
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

  test('lock убирает телефон из запросов', () async {
    final c = makeContainer();
    await c.read(sessionControllerProvider.future);
    final ctl = c.read(sessionControllerProvider.notifier);
    ctl.otpVerified(session);
    await ctl.createPin('1234');

    ctl.lock();

    expect(c.read(sessionControllerProvider).value!.status, AuthStatus.locked);
    expect(c.read(authCredentialsProvider), isNull);
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
