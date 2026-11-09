// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_pdf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// keepAlive: шрифты разбираются один раз за сессию, а не на каждый чек.

@ProviderFor(receiptPdf)
final receiptPdfProvider = ReceiptPdfProvider._();

/// keepAlive: шрифты разбираются один раз за сессию, а не на каждый чек.

final class ReceiptPdfProvider
    extends $FunctionalProvider<ReceiptPdf, ReceiptPdf, ReceiptPdf>
    with $Provider<ReceiptPdf> {
  /// keepAlive: шрифты разбираются один раз за сессию, а не на каждый чек.
  ReceiptPdfProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptPdfProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptPdfHash();

  @$internal
  @override
  $ProviderElement<ReceiptPdf> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReceiptPdf create(Ref ref) {
    return receiptPdf(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptPdf value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptPdf>(value),
    );
  }
}

String _$receiptPdfHash() => r'2b12c2520ec7cc7f525a3a8dd13d60cde4a7971d';
