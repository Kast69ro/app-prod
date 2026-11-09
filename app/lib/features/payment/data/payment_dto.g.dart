// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => _PaymentDto(
  type: json['type'] as String?,
  sender: json['sender'] as String?,
  senderBankId: (json['sender_bank_id'] as num?)?.toInt(),
  amount: json['amount'] as num? ?? 0,
  status: json['status'] as String?,
  creationDatetime: json['creation_datetime'] as String?,
);

Map<String, dynamic> _$PaymentDtoToJson(_PaymentDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sender': instance.sender,
      'sender_bank_id': instance.senderBankId,
      'amount': instance.amount,
      'status': instance.status,
      'creation_datetime': instance.creationDatetime,
    };
