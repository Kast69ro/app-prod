import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_paths.dart';
import '../../../core/api/api_providers.dart';
import '../../../core/api/parse.dart';
import '../../../core/utils/phone_format.dart';
import '../domain/session.dart';
import 'auth_dtos.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._api);

  final ApiClient _api;

  /// Отправляет SMS-код. Возвращает срок действия кода в секундах.
  Future<int> requestOtp(String phoneDigits) async {
    final json = await _api.post(
      ApiPaths.otpRequest,
      body: {'phone': fullPhone(phoneDigits)},
    );
    return parseResponse(() => OtpRequestDto.fromJson(json)).expiresIn;
  }

  /// Проверяет код и возвращает данные терминала для сессии.
  Future<Session> verifyOtp(String phoneDigits, String code) async {
    final json = await _api.post(
      ApiPaths.otpVerify,
      body: {'phone': fullPhone(phoneDigits), 'code': code},
    );
    final dto = parseResponse(() => OtpVerifyDto.fromJson(json));
    return Session(
      phone: phoneDigits,
      terminalId: dto.terminalId,
      terminalName: dto.terminalName,
      storeName: dto.storeName,
    );
  }
}

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(apiClientProvider));
