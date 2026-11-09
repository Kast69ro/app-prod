// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Переопределяется в `main_dev.dart` / `main_prod.dart`.

@ProviderFor(env)
final envProvider = EnvProvider._();

/// Переопределяется в `main_dev.dart` / `main_prod.dart`.

final class EnvProvider extends $FunctionalProvider<Env, Env, Env>
    with $Provider<Env> {
  /// Переопределяется в `main_dev.dart` / `main_prod.dart`.
  EnvProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'envProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$envHash();

  @$internal
  @override
  $ProviderElement<Env> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Env create(Ref ref) {
    return env(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Env value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Env>(value),
    );
  }
}

String _$envHash() => r'51112ed430b23a5bb22fadbdaacd122d520d8cd3';
