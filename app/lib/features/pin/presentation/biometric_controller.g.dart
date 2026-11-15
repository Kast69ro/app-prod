// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Вход по Face ID / отпечатку для экрана кода и настроек.
/// Не keepAlive: при каждом открытии экрана заново смотрим, что есть
/// на устройстве (биометрию могли удалить в настройках телефона).

@ProviderFor(BiometricController)
final biometricControllerProvider = BiometricControllerProvider._();

/// Вход по Face ID / отпечатку для экрана кода и настроек.
/// Не keepAlive: при каждом открытии экрана заново смотрим, что есть
/// на устройстве (биометрию могли удалить в настройках телефона).
final class BiometricControllerProvider
    extends $AsyncNotifierProvider<BiometricController, BiometricState> {
  /// Вход по Face ID / отпечатку для экрана кода и настроек.
  /// Не keepAlive: при каждом открытии экрана заново смотрим, что есть
  /// на устройстве (биометрию могли удалить в настройках телефона).
  BiometricControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricControllerHash();

  @$internal
  @override
  BiometricController create() => BiometricController();
}

String _$biometricControllerHash() =>
    r'a54d1b1ad3bc27308ff97347b7727393a50e84d1';

/// Вход по Face ID / отпечатку для экрана кода и настроек.
/// Не keepAlive: при каждом открытии экрана заново смотрим, что есть
/// на устройстве (биометрию могли удалить в настройках телефона).

abstract class _$BiometricController extends $AsyncNotifier<BiometricState> {
  FutureOr<BiometricState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BiometricState>, BiometricState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BiometricState>, BiometricState>,
              AsyncValue<BiometricState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
