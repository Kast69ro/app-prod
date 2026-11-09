// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryPageDto _$HistoryPageDtoFromJson(Map<String, dynamic> json) =>
    _HistoryPageDto(
      total: (json['total'] as num?)?.toInt() ?? 0,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      payments:
          (json['payments'] as List<dynamic>?)
              ?.map((e) => PaymentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PaymentDto>[],
    );

Map<String, dynamic> _$HistoryPageDtoToJson(_HistoryPageDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'offset': instance.offset,
      'payments': instance.payments,
    };
