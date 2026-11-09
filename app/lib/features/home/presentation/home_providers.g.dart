// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Данные точки с бэка. Заодно обновляет сессию: название, точку и QR
/// храним на устройстве, чтобы QR показывался сразу, даже без сети.

@ProviderFor(terminalInfo)
final terminalInfoProvider = TerminalInfoProvider._();

/// Данные точки с бэка. Заодно обновляет сессию: название, точку и QR
/// храним на устройстве, чтобы QR показывался сразу, даже без сети.

final class TerminalInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<TerminalInfo>,
          TerminalInfo,
          FutureOr<TerminalInfo>
        >
    with $FutureModifier<TerminalInfo>, $FutureProvider<TerminalInfo> {
  /// Данные точки с бэка. Заодно обновляет сессию: название, точку и QR
  /// храним на устройстве, чтобы QR показывался сразу, даже без сети.
  TerminalInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'terminalInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$terminalInfoHash();

  @$internal
  @override
  $FutureProviderElement<TerminalInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TerminalInfo> create(Ref ref) {
    return terminalInfo(ref);
  }
}

String _$terminalInfoHash() => r'66996dfe29b34fd71b9911f8ded8cf46d70c4698';

/// Матрица QR, закешированная по строке: строится один раз на обоих экранах.

@ProviderFor(qrBuild)
final qrBuildProvider = QrBuildFamily._();

/// Матрица QR, закешированная по строке: строится один раз на обоих экранах.

final class QrBuildProvider
    extends $FunctionalProvider<QrBuild, QrBuild, QrBuild>
    with $Provider<QrBuild> {
  /// Матрица QR, закешированная по строке: строится один раз на обоих экранах.
  QrBuildProvider._({
    required QrBuildFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'qrBuildProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$qrBuildHash();

  @override
  String toString() {
    return r'qrBuildProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<QrBuild> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QrBuild create(Ref ref) {
    final argument = this.argument as String;
    return qrBuild(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QrBuild value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QrBuild>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QrBuildProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$qrBuildHash() => r'0b5a7ca60a5980fbe6629fbaef6578c0b671c56c';

/// Матрица QR, закешированная по строке: строится один раз на обоих экранах.

final class QrBuildFamily extends $Family
    with $FunctionalFamilyOverride<QrBuild, String> {
  QrBuildFamily._()
    : super(
        retry: null,
        name: r'qrBuildProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Матрица QR, закешированная по строке: строится один раз на обоих экранах.

  QrBuildProvider call(String data) =>
      QrBuildProvider._(argument: data, from: this);

  @override
  String toString() => r'qrBuildProvider';
}

/// Сводка за сегодня.

@ProviderFor(todaySummary)
final todaySummaryProvider = TodaySummaryProvider._();

/// Сводка за сегодня.

final class TodaySummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DaySummary>,
          DaySummary,
          FutureOr<DaySummary>
        >
    with $FutureModifier<DaySummary>, $FutureProvider<DaySummary> {
  /// Сводка за сегодня.
  TodaySummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaySummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaySummaryHash();

  @$internal
  @override
  $FutureProviderElement<DaySummary> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DaySummary> create(Ref ref) {
    return todaySummary(ref);
  }
}

String _$todaySummaryHash() => r'd8a7058371264ffaa1d198bdd3a269153d644716';
