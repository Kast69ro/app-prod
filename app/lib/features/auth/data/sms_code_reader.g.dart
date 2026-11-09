// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_code_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(smsCodeReader)
final smsCodeReaderProvider = SmsCodeReaderProvider._();

final class SmsCodeReaderProvider
    extends $FunctionalProvider<SmsCodeReader, SmsCodeReader, SmsCodeReader>
    with $Provider<SmsCodeReader> {
  SmsCodeReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsCodeReaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsCodeReaderHash();

  @$internal
  @override
  $ProviderElement<SmsCodeReader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SmsCodeReader create(Ref ref) {
    return smsCodeReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsCodeReader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsCodeReader>(value),
    );
  }
}

String _$smsCodeReaderHash() => r'e85a6b0f0b37f1bc0b4548157fc26e72bffda68c';
