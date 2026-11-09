// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pinRepository)
final pinRepositoryProvider = PinRepositoryProvider._();

final class PinRepositoryProvider
    extends $FunctionalProvider<PinRepository, PinRepository, PinRepository>
    with $Provider<PinRepository> {
  PinRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinRepositoryHash();

  @$internal
  @override
  $ProviderElement<PinRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PinRepository create(Ref ref) {
    return pinRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PinRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PinRepository>(value),
    );
  }
}

String _$pinRepositoryHash() => r'099d803ea3c10066c405b28e9d0a87f85128df52';
