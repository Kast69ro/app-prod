// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_export_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Отчёт в PDF: все операции периода → PDF → окно «Поделиться».
/// Состояние — идёт ли выгрузка (кнопка показывает загрузку).

@ProviderFor(HistoryExportController)
final historyExportControllerProvider = HistoryExportControllerProvider._();

/// Отчёт в PDF: все операции периода → PDF → окно «Поделиться».
/// Состояние — идёт ли выгрузка (кнопка показывает загрузку).
final class HistoryExportControllerProvider
    extends $NotifierProvider<HistoryExportController, bool> {
  /// Отчёт в PDF: все операции периода → PDF → окно «Поделиться».
  /// Состояние — идёт ли выгрузка (кнопка показывает загрузку).
  HistoryExportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyExportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyExportControllerHash();

  @$internal
  @override
  HistoryExportController create() => HistoryExportController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$historyExportControllerHash() =>
    r'c5cda98f1d82f9f5ab3b46dff07ebf0f1a453a2c';

/// Отчёт в PDF: все операции периода → PDF → окно «Поделиться».
/// Состояние — идёт ли выгрузка (кнопка показывает загрузку).

abstract class _$HistoryExportController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
