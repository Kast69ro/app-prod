// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Хранилище настроек. Открывается в `bootstrap` до первого кадра,
/// чтобы тема применилась сразу, без мигания светлым экраном.

@ProviderFor(preferences)
final preferencesProvider = PreferencesProvider._();

/// Хранилище настроек. Открывается в `bootstrap` до первого кадра,
/// чтобы тема применилась сразу, без мигания светлым экраном.

final class PreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Хранилище настроек. Открывается в `bootstrap` до первого кадра,
  /// чтобы тема применилась сразу, без мигания светлым экраном.
  PreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return preferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$preferencesHash() => r'c2d9614bce707c4885dded3c579949a2e6f9cb6f';
