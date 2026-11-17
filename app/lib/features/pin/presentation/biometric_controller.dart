import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/security/biometric_auth.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import '../data/pin_repository.dart';

part 'biometric_controller.g.dart';

@immutable
class BiometricState {
  const BiometricState({required this.kind, required this.enabled});

  /// Что настроено на устройстве; `null` — биометрии нет.
  final BiometricKind? kind;

  /// Человек включил вход по биометрии.
  final bool enabled;

  /// Показывать кнопку и спрашивать на экране кода.
  bool get canUnlock => kind != null && enabled;
}

/// Вход по Face ID / отпечатку для экрана кода и настроек.
/// Не keepAlive: при каждом открытии экрана заново смотрим, что есть
/// на устройстве (биометрию могли удалить в настройках телефона).
@riverpod
class BiometricController extends _$BiometricController {
  BiometricAuth get _auth => ref.read(biometricAuthProvider);
  PinRepository get _pins => ref.read(pinRepositoryProvider);

  /// Системное окно уже открыто — второй запрос плагин отклонит.
  bool _prompting = false;

  @override
  Future<BiometricState> build() async {
    final kind = await _auth.available();
    final enabled = await _pins.biometricEnabled();
    return BiometricState(kind: kind, enabled: enabled);
  }

  /// Переключатель в настройках. Включение — только после сканирования:
  /// так проверяем, что биометрия работает и что это владелец.
  Future<void> setEnabled(bool enabled, BiometricPrompt prompt) async {
    final current = await future;
    if (current.kind == null || current.enabled == enabled) return;
    if (enabled && !await _scan(prompt)) return;
    await _pins.setBiometric(enabled: enabled);
    if (!ref.mounted) return;
    state = AsyncData(BiometricState(kind: current.kind, enabled: enabled));
  }

  /// Вход на экране кода. `false` — отказались или не прошло,
  /// человек вводит код.
  Future<bool> unlock(BiometricPrompt prompt) async {
    final current = await future;
    if (!current.canUnlock || !await _scan(prompt)) return false;
    await ref.read(sessionControllerProvider.notifier).unlockWithBiometrics();
    return true;
  }

  Future<bool> _scan(BiometricPrompt prompt) async {
    if (_prompting) return false;
    _prompting = true;
    try {
      return await _auth.authenticate(prompt);
    } finally {
      _prompting = false;
    }
  }
}

/// Тексты системного окна. [cancel] — «Ввести код» на входе,
/// «Отмена» при включении. [fallback] — см. [BiometricPrompt.fallback].
BiometricPrompt biometricPrompt(
  AppLocalizations l, {
  required String cancel,
  String? fallback,
}) => BiometricPrompt(
  reason: l.biometricReason,
  title: l.appTitle,
  cancel: cancel,
  fallback: fallback,
);

/// «Face ID» / «отпечатку» — в подписи кнопки и настроек.
extension BiometricLabels on AppLocalizations {
  String biometricUnlockLabel(BiometricKind kind) => switch (kind) {
    BiometricKind.face => pinBiometricFace,
    BiometricKind.fingerprint => pinBiometricFingerprint,
  };

  String biometricSettingLabel(BiometricKind kind) => switch (kind) {
    BiometricKind.face => settingsBiometricFace,
    BiometricKind.fingerprint => settingsBiometricFingerprint,
  };

  String biometricOfferTitle(BiometricKind kind) => switch (kind) {
    BiometricKind.face => biometricOfferFace,
    BiometricKind.fingerprint => biometricOfferFingerprint,
  };
}
