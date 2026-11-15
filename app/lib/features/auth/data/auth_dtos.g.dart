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

_VerifiedTerminalDto _$VerifiedTerminalDtoFromJson(Map<String, dynamic> json) =>
    _VerifiedTerminalDto(
      terminalId: _idFromJson(json['terminalId']),
      terminalName: json['terminalName'] as String? ?? '',
      storeName: json['storeName'] as String? ?? '',
      terminalQR: json['terminalQR'] as String?,
    );

Map<String, dynamic> _$VerifiedTerminalDtoToJson(
  _VerifiedTerminalDto instance,
) => <String, dynamic>{
  'terminalId': instance.terminalId,
  'terminalName': instance.terminalName,
  'storeName': instance.storeName,
  'terminalQR': instance.terminalQR,
};

_OtpVerifyDto _$OtpVerifyDtoFromJson(Map<String, dynamic> json) =>
    _OtpVerifyDto(
      ok: json['ok'] as bool? ?? true,
      terminal: json['terminal'] == null
          ? const VerifiedTerminalDto()
          : VerifiedTerminalDto.fromJson(
              json['terminal'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$OtpVerifyDtoToJson(_OtpVerifyDto instance) =>
    <String, dynamic>{'ok': instance.ok, 'terminal': instance.terminal};
