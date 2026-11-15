import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_paths.dart';
import '../../../core/api/api_providers.dart';
import '../../../core/api/auth_tokens.dart';
import '../../../core/api/parse.dart';
import '../../../core/utils/phone_format.dart';
import '../domain/session.dart';
import 'auth_dtos.dart';

part 'auth_repository.g.dart';

/// Результат входа: данные точки и токены.
typedef SignIn = ({Session session, AuthTokens tokens});

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

  /// Проверяет код и возвращает данные терминала и токены.
  /// Без токенов в ответе входа нет — `badResponse`.
  Future<SignIn> verifyOtp(String phoneDigits, String code) async {
    final json = await _api.post(
      ApiPaths.otpVerify,
      body: {'phone': fullPhone(phoneDigits), 'code': code},
    );
    final tokens = parseResponse(() => AuthTokens.fromJson(json));
    final t = parseResponse(() => OtpVerifyDto.fromJson(json)).terminal;
    return (
      session: Session(
        phone: phoneDigits,
        terminalId: t.terminalId,
        terminalName: t.terminalName,
        storeName: t.storeName,
        terminalQR: (t.terminalQR?.isEmpty ?? true) ? null : t.terminalQR,
      ),
      tokens: tokens,
    );
  }

  /// Отзывает refresh на бэке. Ошибки — у вызывающего.
  Future<void> logout(String refreshToken) =>
      _api.post(ApiPaths.authLogout, body: {'refresh_token': refreshToken});
}

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(apiClientProvider));
