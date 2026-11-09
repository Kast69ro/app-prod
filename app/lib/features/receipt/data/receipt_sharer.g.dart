// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_sharer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(receiptSharer)
final receiptSharerProvider = ReceiptSharerProvider._();

final class ReceiptSharerProvider
    extends $FunctionalProvider<ReceiptSharer, ReceiptSharer, ReceiptSharer>
    with $Provider<ReceiptSharer> {
  ReceiptSharerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptSharerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptSharerHash();

  @$internal
  @override
  $ProviderElement<ReceiptSharer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReceiptSharer create(Ref ref) {
    return receiptSharer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptSharer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptSharer>(value),
    );
  }
}

String _$receiptSharerHash() => r'90df75e4b6262d899456b4cdb568350e6ff0001b';
