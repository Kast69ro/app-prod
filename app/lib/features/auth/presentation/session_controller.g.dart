// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Состояние входа на всё приложение. По нему роутер выбирает экран.

@ProviderFor(SessionController)
final sessionControllerProvider = SessionControllerProvider._();

/// Состояние входа на всё приложение. По нему роутер выбирает экран.
final class SessionControllerProvider
    extends $AsyncNotifierProvider<SessionController, SessionState> {
  /// Состояние входа на всё приложение. По нему роутер выбирает экран.
  SessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionControllerHash();

  @$internal
  @override
  SessionController create() => SessionController();
}

String _$sessionControllerHash() => r'7b3e9722a9a54cb787d9c3356ede5f99ff51c790';

/// Состояние входа на всё приложение. По нему роутер выбирает экран.

abstract class _$SessionController extends $AsyncNotifier<SessionState> {
  FutureOr<SessionState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SessionState>, SessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SessionState>, SessionState>,
              AsyncValue<SessionState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
