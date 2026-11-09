// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TerminalDto _$TerminalDtoFromJson(Map<String, dynamic> json) => _TerminalDto(
  terminalName: json['terminalName'] as String? ?? '',
  terminalPhone: json['terminalPhone'] as String? ?? '',
  storeName: json['storeName'] as String? ?? '',
  terminalQR: json['terminalQR'] as String? ?? '',
);

Map<String, dynamic> _$TerminalDtoToJson(_TerminalDto instance) =>
    <String, dynamic>{
      'terminalName': instance.terminalName,
      'terminalPhone': instance.terminalPhone,
      'storeName': instance.storeName,
      'terminalQR': instance.terminalQR,
    };

_TerminalResponseDto _$TerminalResponseDtoFromJson(Map<String, dynamic> json) =>
    _TerminalResponseDto(
      terminal: TerminalDto.fromJson(json['terminal'] as Map<String, dynamic>),
      lastPayment: json['last_payment'] == null
          ? null
          : PaymentDto.fromJson(json['last_payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminalResponseDtoToJson(
  _TerminalResponseDto instance,
) => <String, dynamic>{
  'terminal': instance.terminal,
  'last_payment': instance.lastPayment,
};

_TotalsDto _$TotalsDtoFromJson(Map<String, dynamic> json) => _TotalsDto(
  count: (json['count'] as num?)?.toInt() ?? 0,
  amount: json['amount'] as num? ?? 0,
);

Map<String, dynamic> _$TotalsDtoToJson(_TotalsDto instance) =>
    <String, dynamic>{'count': instance.count, 'amount': instance.amount};

_SummaryDto _$SummaryDtoFromJson(Map<String, dynamic> json) => _SummaryDto(
  date: json['date'] as String?,
  success: json['success'] == null
      ? const TotalsDto()
      : TotalsDto.fromJson(json['success'] as Map<String, dynamic>),
  cancel: json['cancel'] == null
      ? const TotalsDto()
      : TotalsDto.fromJson(json['cancel'] as Map<String, dynamic>),
  refunded: json['refunded'] == null
      ? null
      : TotalsDto.fromJson(json['refunded'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SummaryDtoToJson(_SummaryDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'success': instance.success,
      'cancel': instance.cancel,
      'refunded': instance.refunded,
    };
