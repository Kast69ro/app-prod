import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dtos.freezed.dart';
part 'auth_dtos.g.dart';

/// Ответ `POST /pos/otp/request`.
@freezed
abstract class OtpRequestDto with _$OtpRequestDto {
  const factory OtpRequestDto({
    @Default(true) bool ok,
    String? message,
    @JsonKey(name: 'expires_in') @Default(300) int expiresIn,
  }) = _OtpRequestDto;

  factory OtpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestDtoFromJson(json);
}

/// Терминал из ответа `POST /pos/otp/verify`.
@freezed
abstract class VerifiedTerminalDto with _$VerifiedTerminalDto {
  const factory VerifiedTerminalDto({
    @JsonKey(fromJson: _idFromJson) String? terminalId,
    @Default('') String terminalName,
    @Default('') String storeName,
    String? terminalQR,
  }) = _VerifiedTerminalDto;

  factory VerifiedTerminalDto.fromJson(Map<String, dynamic> json) =>
      _$VerifiedTerminalDtoFromJson(json);
}

/// Ответ `POST /pos/otp/verify` без токенов: их разбирает `AuthTokens`,
/// чтобы токены не попали в сгенерированный `toString`.
@freezed
abstract class OtpVerifyDto with _$OtpVerifyDto {
  const factory OtpVerifyDto({
    @Default(true) bool ok,
    @Default(VerifiedTerminalDto()) VerifiedTerminalDto terminal,
  }) = _OtpVerifyDto;

  factory OtpVerifyDto.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyDtoFromJson(json);
}

String? _idFromJson(Object? v) => v?.toString();
