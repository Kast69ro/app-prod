// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PinController)
final pinControllerProvider = PinControllerProvider._();

final class PinControllerProvider
    extends $NotifierProvider<PinController, PinState> {
  PinControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinControllerHash();

  @$internal
  @override
  PinController create() => PinController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PinState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PinState>(value),
    );
  }
}

String _$pinControllerHash() => r'14d2a6c6ac8b846057a10c94223ab989e81de2c9';

abstract class _$PinController extends $Notifier<PinState> {
  PinState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PinState, PinState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PinState, PinState>,
              PinState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
