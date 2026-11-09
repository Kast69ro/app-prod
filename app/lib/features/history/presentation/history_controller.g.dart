// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Выбранный период истории. Сменили — история грузится заново.

@ProviderFor(HistoryPeriodController)
final historyPeriodControllerProvider = HistoryPeriodControllerProvider._();

/// Выбранный период истории. Сменили — история грузится заново.
final class HistoryPeriodControllerProvider
    extends $NotifierProvider<HistoryPeriodController, HistoryPeriod> {
  /// Выбранный период истории. Сменили — история грузится заново.
  HistoryPeriodControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyPeriodControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyPeriodControllerHash();

  @$internal
  @override
  HistoryPeriodController create() => HistoryPeriodController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryPeriod value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryPeriod>(value),
    );
  }
}

String _$historyPeriodControllerHash() =>
    r'710cd14091c4bd5d2ef9d604d55d9083ca163fbb';

/// Выбранный период истории. Сменили — история грузится заново.

abstract class _$HistoryPeriodController extends $Notifier<HistoryPeriod> {
  HistoryPeriod build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HistoryPeriod, HistoryPeriod>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HistoryPeriod, HistoryPeriod>,
              HistoryPeriod,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// История операций: первая страница + «Показать ещё».
///
/// Ошибка обновления не стирает список: Riverpod хранит прошлое значение
/// в `AsyncError`, экран показывает его вместе с плашкой «Повторить».

@ProviderFor(HistoryController)
final historyControllerProvider = HistoryControllerProvider._();

/// История операций: первая страница + «Показать ещё».
///
/// Ошибка обновления не стирает список: Riverpod хранит прошлое значение
/// в `AsyncError`, экран показывает его вместе с плашкой «Повторить».
final class HistoryControllerProvider
    extends $AsyncNotifierProvider<HistoryController, HistoryState> {
  /// История операций: первая страница + «Показать ещё».
  ///
  /// Ошибка обновления не стирает список: Riverpod хранит прошлое значение
  /// в `AsyncError`, экран показывает его вместе с плашкой «Повторить».
  HistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyControllerHash();

  @$internal
  @override
  HistoryController create() => HistoryController();
}

String _$historyControllerHash() => r'ff171c96b1cdd0cdd39f627c0c52c4e149d838a3';

/// История операций: первая страница + «Показать ещё».
///
/// Ошибка обновления не стирает список: Riverpod хранит прошлое значение
/// в `AsyncError`, экран показывает его вместе с плашкой «Повторить».

abstract class _$HistoryController extends $AsyncNotifier<HistoryState> {
  FutureOr<HistoryState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HistoryState>, HistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HistoryState>, HistoryState>,
              AsyncValue<HistoryState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
