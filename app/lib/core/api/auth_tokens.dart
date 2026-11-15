/// Пара токенов из `otp/verify` и `auth/refresh`.
///
/// Обычный класс, а не freezed: сгенерированный `toString` вывел бы токены
/// в лог при случайном `print`. Здесь `toString` их скрывает.
class AuthTokens {
  const AuthTokens({required this.access, required this.refresh});

  /// Разбирает ответ бэка (и запись в хранилище — те же ключи).
  /// Нет токена или пустой — [FormatException]: войти без токенов нельзя.
  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    final access = json['access_token'];
    final refresh = json['refresh_token'];
    if (access is! String || access.isEmpty) {
      throw const FormatException('access_token');
    }
    if (refresh is! String || refresh.isEmpty) {
      throw const FormatException('refresh_token');
    }
    return AuthTokens(access: access, refresh: refresh);
  }

  /// Живёт ~15 мин, идёт в `Authorization: Bearer`.
  final String access;

  /// Живёт ~30 дней. Ротируется: после refresh старый уже не работает.
  final String refresh;

  Map<String, dynamic> toJson() => {
    'access_token': access,
    'refresh_token': refresh,
  };

  @override
  bool operator ==(Object other) =>
      other is AuthTokens && other.access == access && other.refresh == refresh;

  @override
  int get hashCode => Object.hash(access, refresh);

  @override
  String toString() => 'AuthTokens(***)';
}
