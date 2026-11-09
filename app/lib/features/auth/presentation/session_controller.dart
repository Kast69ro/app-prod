import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/utils/phone_format.dart';
import '../../pin/data/pin_repository.dart';
import '../data/session_store.dart';
import '../domain/session.dart';

part 'session_controller.g.dart';

/// Состояние входа на всё приложение. По нему роутер выбирает экран.
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  SessionStore get _store => ref.read(sessionStoreProvider);
  PinRepository get _pins => ref.read(pinRepositoryProvider);

  @override
  Future<SessionState> build() async {
    final session = await _store.read();
    if (session != null && await _pins.hasPin()) {
      return SessionState(status: AuthStatus.locked, session: session);
    }
    // Нет сессии или код так и не создали (приложение закрыли посреди) —
    // начинаем вход заново и не оставляем хвостов.
    await _store.wipe();
    return SessionState.signedOut;
  }

  Session? get _session => state.value?.session;

  /// OTP подтверждён. Сессию сохраняем только вместе с кодом доступа.
  void otpVerified(Session session) {
    state = AsyncData(
      SessionState(status: AuthStatus.pinSetup, session: session),
    );
  }

  Future<void> createPin(String pin) async {
    final session = _session;
    if (session == null) return;
    await _pins.save(pin, session.phone);
    await _store.write(session);
    _unlock(session);
  }

  Future<PinCheck> unlock(String pin) async {
    final session = _session;
    if (session == null) return const PinLockedOut();
    final result = await _pins.check(pin, session.phone);
    switch (result) {
      case PinOk():
        _unlock(session);
      case PinLockedOut():
        await _signOut(reason: SignOutReason.pinLockedOut);
      case PinWrong():
        break;
    }
    return result;
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
  void lock() {
    final current = state.value;
    if (current?.status != AuthStatus.unlocked) return;
    ref.read(authCredentialsProvider.notifier).setPhone(null);
    state = AsyncData(current!.copyWith(status: AuthStatus.locked));
  }

  /// Обновлённые данные точки с бэка (название, QR).
  Future<void> updateSession(Session session) async {
    final current = state.value;
    if (current == null || current.session == null) return;
    await _store.write(session);
    state = AsyncData(current.copyWith(session: session));
  }

  /// «Забыли код?» и «Выйти».
  Future<void> signOut() => _signOut();

  Future<void> _signOut({SignOutReason? reason}) async {
    ref.read(authCredentialsProvider.notifier).setPhone(null);
    await _store.wipe();
    state = AsyncData(
      SessionState(status: AuthStatus.signedOut, reason: reason),
    );
  }

  void _unlock(Session session) {
    ref
        .read(authCredentialsProvider.notifier)
        .setPhone(fullPhone(session.phone));
    state = AsyncData(
      SessionState(status: AuthStatus.unlocked, session: session),
    );
  }
}
