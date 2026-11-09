import 'package:freezed_annotation/freezed_annotation.dart';

import '../../payment/data/payment_dto.dart';
import '../domain/home_models.dart';

part 'home_dtos.freezed.dart';
part 'home_dtos.g.dart';

@freezed
abstract class TerminalDto with _$TerminalDto {
  const factory TerminalDto({
    @Default('') String terminalName,
    @Default('') String terminalPhone,
    @Default('') String storeName,
    @Default('') String terminalQR,
  }) = _TerminalDto;

  factory TerminalDto.fromJson(Map<String, dynamic> json) =>
      _$TerminalDtoFromJson(json);
}

/// Ответ `GET /pos/terminal`.
@freezed
abstract class TerminalResponseDto with _$TerminalResponseDto {
  const factory TerminalResponseDto({
    required TerminalDto terminal,
    @JsonKey(name: 'last_payment') PaymentDto? lastPayment,
  }) = _TerminalResponseDto;

  const TerminalResponseDto._();

  factory TerminalResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TerminalResponseDtoFromJson(json);

  TerminalInfo toDomain() => TerminalInfo(
    terminalName: terminal.terminalName,
    terminalPhone: terminal.terminalPhone,
    storeName: terminal.storeName,
    terminalQR: terminal.terminalQR,
    lastPayment: lastPayment?.toDomain(),
  );
}

@freezed
abstract class TotalsDto with _$TotalsDto {
  const factory TotalsDto({@Default(0) int count, @Default(0) num amount}) =
      _TotalsDto;

  const TotalsDto._();

  factory TotalsDto.fromJson(Map<String, dynamic> json) =>
      _$TotalsDtoFromJson(json);

  Totals toDomain() => Totals(count: count, amount: amount.toDouble());
}

/// Ответ `GET /pos/summary`.
@freezed
abstract class SummaryDto with _$SummaryDto {
  const factory SummaryDto({
    String? date,
    @Default(TotalsDto()) TotalsDto success,
    @Default(TotalsDto()) TotalsDto cancel,
    TotalsDto? refunded,
  }) = _SummaryDto;

  const SummaryDto._();

  factory SummaryDto.fromJson(Map<String, dynamic> json) =>
      _$SummaryDtoFromJson(json);

  DaySummary toDomain() => DaySummary(
    success: success.toDomain(),
    cancel: cancel.toDomain(),
    refunded: refunded?.toDomain(),
  );
}
