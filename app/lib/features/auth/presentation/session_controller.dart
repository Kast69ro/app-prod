import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/auth_tokens.dart';
import '../../../core/storage/token_store.dart';
import '../../pin/data/pin_repository.dart';
import '../data/auth_repository.dart';
import '../data/session_store.dart';
import '../domain/session.dart';

part 'session_controller.g.dart';

/// Состояние входа на всё приложение. По нему роутер выбирает экран.
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  SessionStore get _store => ref.read(sessionStoreProvider);
  TokenStore get _tokens => ref.read(tokenStoreProvider);
  PinRepository get _pins => ref.read(pinRepositoryProvider);

  /// Токены после OTP, пока не создан код доступа. На диск — только вместе
  /// с сессией и кодом.
  AuthTokens? _pendingTokens;

  @override
  Future<SessionState> build() async {
    // Бэк отклонил refresh — выходим на вход по SMS.
    ref.listen(sessionExpiryProvider, (_, _) {
      unawaited(_signOut(reason: SignOutReason.sessionExpired, revoke: false));
    });

    final session = await _store.read();
    if (session != null &&
        await _pins.hasPin() &&
        await _tokens.read() != null) {
      return SessionState(status: AuthStatus.locked, session: session);
    }
    // Нет сессии, код так и не создали (приложение закрыли посреди)
    // или сессия от версии без токенов — начинаем вход заново без хвостов.
    await _store.wipe();
    return SessionState.signedOut;
  }

  Session? get _session => state.value?.session;

  /// OTP подтверждён. Сессию и токены сохраняем только вместе с кодом доступа.
  void otpVerified(Session session, AuthTokens tokens) {
    _pendingTokens = tokens;
    state = AsyncData(
      SessionState(status: AuthStatus.pinSetup, session: session),
    );
  }

  /// [biometric] — человек согласился входить по Face ID / отпечатку
  /// (уже подтвердил это сканированием).
  Future<void> createPin(String pin, {bool biometric = false}) async {
    final session = _session;
    final tokens = _pendingTokens;
    if (session == null || tokens == null) return;
    await _pins.save(pin, session.phone);
    await _pins.setBiometric(enabled: biometric);
    await _store.write(session);
    await _tokens.write(tokens);
    _pendingTokens = null;
    _unlock(session, tokens);
  }

  Future<PinCheck> unlock(String pin) async {
    final session = _session;
    if (session == null) return const PinLockedOut();
    final result = await _pins.check(pin, session.phone);
    switch (result) {
      case PinOk():
        final tokens = await _tokens.read();
        if (tokens == null) {
          await _signOut(reason: SignOutReason.sessionExpired, revoke: false);
        } else {
          _unlock(session, tokens);
        }
      case PinLockedOut():
        await _signOut(reason: SignOutReason.pinLockedOut);
      case PinWrong():
        break;
    }
    return result;
  }

  /// Вход по Face ID / отпечатку: сама проверка уже прошла
  /// (`BiometricAuth.authenticate`), здесь — только снять блокировку.
  /// Работает лишь на экране кода и если вход по биометрии включён.
  Future<void> unlockWithBiometrics() async {
    final current = state.value;
    final session = current?.session;
    if (current?.status != AuthStatus.locked || session == null) return;
    if (!await _pins.biometricEnabled()) return;
    final tokens = await _tokens.read();
    if (tokens == null) {
      await _signOut(reason: SignOutReason.sessionExpired, revoke: false);
      return;
    }
    await _pins.resetFailures();
    _unlock(session, tokens);
  }

  /// Проверка текущего кода при смене. Ошибки идут в тот же счётчик,
  /// что и при входе: 5 неверных — выход, как на экране кода.
  Future<PinCheck> verifyPin(String pin) async {
    final session = _session;
    if (session == null) return const PinLockedOut();
    final result = await _pins.check(pin, session.phone);
    if (result is PinLockedOut) {
      await _signOut(reason: SignOutReason.pinLockedOut);
    }
    return result;
  }

  /// Новый код (старый уже проверен через [verifyPin]).
  Future<void> changePin(String pin) async {
    final session = _session;
    if (session == null) return;
    await _pins.save(pin, session.phone);
  }

  /// Блокировка (свернули приложение) — снова спросить код.
  /// Токены остаются в хранилище, но запросы без кода не идут.
  void lock() {
    final current = state.value;
    if (current?.status != AuthStatus.unlocked) return;
    ref.read(authCredentialsProvider.notifier).set(null);
    state = AsyncData(current!.copyWith(status: AuthStatus.locked));
  }

  /// Обновлённые данные точки с бэка (название, QR).
  Future<void> updateSession(Session session) async {
    final current = state.value;
    if (current == null || current.session == null) return;
    await _store.write(session);
    state = AsyncData(current.copyWith(session: session));
  }

  /// «Выйти» в настройках и на экране кода.
  Future<void> signOut() => _signOut();

  /// [revoke] — отозвать refresh на бэке (`/pos/auth/logout`).
  /// Не нужно, если бэк сам его уже отклонил.
  Future<void> _signOut({SignOutReason? reason, bool revoke = true}) async {
    final current = state.value;
    if (current?.status == AuthStatus.signedOut) return;

    final refresh = revoke
        ? (await _tokens.read())?.refresh ?? _pendingTokens?.refresh
        : null;
    _pendingTokens = null;
    ref.read(authCredentialsProvider.notifier).set(null);
    await _store.wipe();
    state = AsyncData(
      SessionState(status: AuthStatus.signedOut, reason: reason),
    );
    // В фоне: выход не ждёт сети, а ошибка отзыва ни на что не влияет.
    if (refresh != null) unawaited(_revoke(refresh));
  }

  Future<void> _revoke(String refresh) async {
    try {
      await ref.read(authRepositoryProvider).logout(refresh);
    } on Object {
      // Нет сети и т. п. — refresh всё равно стёрт с устройства и истечёт сам.
    }
  }

  void _unlock(Session session, AuthTokens tokens) {
    ref.read(authCredentialsProvider.notifier).set(tokens);
    state = AsyncData(
      SessionState(status: AuthStatus.unlocked, session: session),
    );
  }
}
