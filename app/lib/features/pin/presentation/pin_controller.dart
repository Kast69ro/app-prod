import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/domain/session.dart';
import '../../auth/presentation/session_controller.dart';
import '../data/pin_repository.dart';

part 'pin_controller.freezed.dart';
part 'pin_controller.g.dart';

enum PinStage { create, confirm, unlock }

sealed class PinError {
  const PinError();
}

class PinMismatch extends PinError {
  const PinMismatch();
}

class PinWrongCode extends PinError {
  const PinWrongCode(this.attemptsLeft);
  final int attemptsLeft;
}

@freezed
abstract class PinState with _$PinState {
  const factory PinState({
    required PinStage stage,
    @Default('') String pin,

    /// Код с первого ввода — до подтверждения, только в памяти.
    @Default('') String first,
    @Default(false) bool busy,
    PinError? error,
  }) = _PinState;
}

@riverpod
class PinController extends _$PinController {
  @override
  PinState build() {
    final status = ref.read(sessionControllerProvider).value?.status;
    return PinState(
      stage: status == AuthStatus.pinSetup ? PinStage.create : PinStage.unlock,
    );
  }

  /// Нажатие цифры или «стереть» (`null`).
  void key(String? digit) {
    if (state.busy) return;
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
      // Пауза, чтобы четвёртая точка успела закраситься.
      state = state.copyWith(busy: true);
      Future.delayed(const Duration(milliseconds: 120), () {
        if (ref.mounted) _complete(next);
      });
    }
  }

  Future<void> _complete(String pin) async {
    final session = ref.read(sessionControllerProvider.notifier);
    switch (state.stage) {
      case PinStage.create:
        state = state.copyWith(
          stage: PinStage.confirm,
          first: pin,
          pin: '',
          busy: false,
        );
      case PinStage.confirm:
        if (pin != state.first) {
          state = const PinState(stage: PinStage.create, error: PinMismatch());
          return;
        }
        // Роутер уведёт на главную, экран закроется.
        await session.createPin(pin);
      case PinStage.unlock:
        final result = await session.unlock(pin);
        if (!ref.mounted) return;
        if (result is PinWrong) {
          state = state.copyWith(
            pin: '',
            busy: false,
            error: PinWrongCode(result.attemptsLeft),
          );
        }
    }
  }

  /// «Выйти»: стереть сессию, дальше — вход по SMS.
  Future<void> signOut() =>
      ref.read(sessionControllerProvider.notifier).signOut();
}
