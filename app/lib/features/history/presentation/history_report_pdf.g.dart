// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_report_pdf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// keepAlive: шрифты читаются из ассетов один раз за сессию.

@ProviderFor(historyReportPdf)
final historyReportPdfProvider = HistoryReportPdfProvider._();

/// keepAlive: шрифты читаются из ассетов один раз за сессию.

final class HistoryReportPdfProvider
    extends
        $FunctionalProvider<
          HistoryReportPdf,
          HistoryReportPdf,
          HistoryReportPdf
        >
    with $Provider<HistoryReportPdf> {
  /// keepAlive: шрифты читаются из ассетов один раз за сессию.
  HistoryReportPdfProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyReportPdfProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyReportPdfHash();

  @$internal
  @override
  $ProviderElement<HistoryReportPdf> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HistoryReportPdf create(Ref ref) {
    return historyReportPdf(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryReportPdf value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryReportPdf>(value),
    );
  }
}

String _$historyReportPdfHash() => r'e42770fdd0e1138e68f6eb92a4ae673cf2071c65';
