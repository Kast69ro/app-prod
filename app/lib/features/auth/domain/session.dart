import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

/// Вошедший терминал. Хранится в защищённом хранилище после создания кода.
@freezed
abstract class Session with _$Session {
  const factory Session({
    /// 9 цифр без +992.
    required String phone,
    @JsonKey(fromJson: _idFromJson) String? terminalId,
    @Default('') String terminalName,
    @Default('') String storeName,
    String? terminalQR,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}

/// Бэк отдаёт `terminalId` числом, но храним строкой — так надёжнее.
String? _idFromJson(Object? v) => v?.toString();

enum AuthStatus {
  /// Нет сессии — вход по телефону.
  signedOut,

  /// OTP подтверждён, нужно создать код доступа.
  pinSetup,

  /// Сессия есть, нужно ввести код.
  locked,

  /// Можно работать.
  unlocked,
}

/// Почему сессию стёрли — показываем на экране входа.
enum SignOutReason { pinLockedOut }

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState({
    required AuthStatus status,
    Session? session,
    SignOutReason? reason,
  }) = _SessionState;

  static const signedOut = SessionState(status: AuthStatus.signedOut);
}
