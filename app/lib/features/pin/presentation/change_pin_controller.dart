import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/presentation/session_controller.dart';
import '../data/pin_repository.dart';
import 'pin_controller.dart';

part 'change_pin_controller.freezed.dart';
part 'change_pin_controller.g.dart';

enum ChangePinStage { current, create, confirm, done }

@freezed
abstract class ChangePinState with _$ChangePinState {
  const factory ChangePinState({
    @Default(ChangePinStage.current) ChangePinStage stage,
    @Default('') String pin,
    @Default('') String first,
    @Default(false) bool busy,
    PinError? error,
  }) = _ChangePinState;
}

/// Смена кода в настройках: текущий → новый → повторить.
@riverpod
class ChangePinController extends _$ChangePinController {
  @override
  ChangePinState build() => const ChangePinState();

  void key(String? digit) {
    if (state.busy || state.stage == ChangePinStage.done) return;
    if (digit == null) {
      if (state.pin.isEmpty) return;
      state = state.copyWith(
        pin: state.pin.substring(0, state.pin.length - 1),
        error: null,
      );
      return;
    }
    if (state.pin.length >= pinLength) return;
    final next = state.pin + digit;
    state = state.copyWith(pin: next, error: null);
    if (next.length == pinLength) {
      state = state.copyWith(busy: true);
      Future.delayed(const Duration(milliseconds: 120), () {
        if (ref.mounted) _complete(next);
      });
    }
  }

  Future<void> _complete(String pin) async {
    final session = ref.read(sessionControllerProvider.notifier);
    switch (state.stage) {
      case ChangePinStage.current:
        final result = await session.verifyPin(pin);
        if (!ref.mounted) return;
        state = switch (result) {
          PinOk() => const ChangePinState(stage: ChangePinStage.create),
          PinWrong(:final attemptsLeft) => state.copyWith(
            pin: '',
            busy: false,
            error: PinWrongCode(attemptsLeft),
          ),
          // Сессию уже стёрли — роутер уведёт на вход.
          PinLockedOut() => state.copyWith(pin: '', busy: false),
        };
      case ChangePinStage.create:
        state = state.copyWith(
          stage: ChangePinStage.confirm,
          first: pin,
          pin: '',
          busy: false,
        );
      case ChangePinStage.confirm:
        if (pin != state.first) {
          state = const ChangePinState(
            stage: ChangePinStage.create,
            error: PinMismatch(),
          );
          return;
        }
        await session.changePin(pin);
        if (!ref.mounted) return;
        state = const ChangePinState(stage: ChangePinStage.done);
      case ChangePinStage.done:
        break;
    }
  }
}
