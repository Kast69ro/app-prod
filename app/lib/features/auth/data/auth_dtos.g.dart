// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtpRequestDto _$OtpRequestDtoFromJson(Map<String, dynamic> json) =>
    _OtpRequestDto(
      ok: json['ok'] as bool? ?? true,
      message: json['message'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 300,
    );

Map<String, dynamic> _$OtpRequestDtoToJson(_OtpRequestDto instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'message': instance.message,
      'expires_in': instance.expiresIn,
    };

_OtpVerifyDto _$OtpVerifyDtoFromJson(Map<String, dynamic> json) =>
    _OtpVerifyDto(
      ok: json['ok'] as bool? ?? true,
      terminalId: _idFromJson(json['terminalId']),
      terminalName: json['terminalName'] as String? ?? '',
      storeName: json['storeName'] as String? ?? '',
    );

Map<String, dynamic> _$OtpVerifyDtoToJson(_OtpVerifyDto instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'terminalId': instance.terminalId,
      'terminalName': instance.terminalName,
      'storeName': instance.storeName,
    };
