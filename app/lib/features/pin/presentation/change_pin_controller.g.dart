// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_pin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Смена кода в настройках: текущий → новый → повторить.

@ProviderFor(ChangePinController)
final changePinControllerProvider = ChangePinControllerProvider._();

/// Смена кода в настройках: текущий → новый → повторить.
final class ChangePinControllerProvider
    extends $NotifierProvider<ChangePinController, ChangePinState> {
  /// Смена кода в настройках: текущий → новый → повторить.
  ChangePinControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changePinControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changePinControllerHash();

  @$internal
  @override
  ChangePinController create() => ChangePinController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangePinState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangePinState>(value),
    );
  }
}

String _$changePinControllerHash() =>
    r'40f5e6037ea8a7e503f8782e7feb9f5bef24bbae';

/// Смена кода в настройках: текущий → новый → повторить.

abstract class _$ChangePinController extends $Notifier<ChangePinState> {
  ChangePinState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ChangePinState, ChangePinState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChangePinState, ChangePinState>,
              ChangePinState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
