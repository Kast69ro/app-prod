// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Session _$SessionFromJson(Map<String, dynamic> json) => _Session(
  phone: json['phone'] as String,
  terminalId: _idFromJson(json['terminalId']),
  terminalName: json['terminalName'] as String? ?? '',
  storeName: json['storeName'] as String? ?? '',
  terminalQR: json['terminalQR'] as String?,
);

Map<String, dynamic> _$SessionToJson(_Session instance) => <String, dynamic>{
  'phone': instance.phone,
  'terminalId': instance.terminalId,
  'terminalName': instance.terminalName,
  'storeName': instance.storeName,
  'terminalQR': instance.terminalQR,
};
