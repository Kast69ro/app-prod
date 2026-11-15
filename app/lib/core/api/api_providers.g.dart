// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Токены, с которыми сейчас идут запросы. `null` — не вошли или
/// приложение заблокировано (ждём код). Заполняет `SessionController`.

@ProviderFor(AuthCredentials)
final authCredentialsProvider = AuthCredentialsProvider._();

/// Токены, с которыми сейчас идут запросы. `null` — не вошли или
/// приложение заблокировано (ждём код). Заполняет `SessionController`.
final class AuthCredentialsProvider
    extends $NotifierProvider<AuthCredentials, AuthTokens?> {
  /// Токены, с которыми сейчас идут запросы. `null` — не вошли или
  /// приложение заблокировано (ждём код). Заполняет `SessionController`.
  AuthCredentialsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authCredentialsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authCredentialsHash();

  @$internal
  @override
  AuthCredentials create() => AuthCredentials();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthTokens? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthTokens?>(value),
    );
  }
}

String _$authCredentialsHash() => r'd41a4a6dbd1ee007bc2c37f1b78849ac5f40dae5';

/// Токены, с которыми сейчас идут запросы. `null` — не вошли или
/// приложение заблокировано (ждём код). Заполняет `SessionController`.

abstract class _$AuthCredentials extends $Notifier<AuthTokens?> {
  AuthTokens? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuthTokens?, AuthTokens?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthTokens?, AuthTokens?>,
              AuthTokens?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Счётчик «refresh отклонён». `SessionController` слушает его и выходит
/// на вход по SMS. Через событие, чтобы `core/` не зависел от `features/`.

@ProviderFor(SessionExpiry)
final sessionExpiryProvider = SessionExpiryProvider._();

/// Счётчик «refresh отклонён». `SessionController` слушает его и выходит
/// на вход по SMS. Через событие, чтобы `core/` не зависел от `features/`.
final class SessionExpiryProvider
    extends $NotifierProvider<SessionExpiry, int> {
  /// Счётчик «refresh отклонён». `SessionController` слушает его и выходит
  /// на вход по SMS. Через событие, чтобы `core/` не зависел от `features/`.
  SessionExpiryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionExpiryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionExpiryHash();

  @$internal
  @override
  SessionExpiry create() => SessionExpiry();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$sessionExpiryHash() => r'75ffe9c24aa730489ad8931556aeb2a4e04854fb';

/// Счётчик «refresh отклонён». `SessionController` слушает его и выходит
/// на вход по SMS. Через событие, чтобы `core/` не зависел от `features/`.

abstract class _$SessionExpiry extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'a9754bb8cf8b8fb1e6ffce223d0433a638f70fe4';

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'8c4443c9c80070ab4a96afd745c581b3de2e615d';
