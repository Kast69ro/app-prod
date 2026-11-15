import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/auth_tokens.dart';
import 'secure_store.dart';

part 'token_store.g.dart';

/// Токены в защищённом хранилище (Keychain / Keystore).
/// Стираются вместе с сессией через `SecureStore.deleteAll`.
class TokenStore {
  TokenStore(this._store);

  final SecureStore _store;

  Future<AuthTokens?> read() async {
    final raw = await _store.read(SecureKeys.tokens);
    if (raw == null) return null;
    try {
      return AuthTokens.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      // Повреждённая запись — токенов нет, вход заново.
      await _store.delete(SecureKeys.tokens);
      return null;
    }
  }

  Future<void> write(AuthTokens tokens) =>
      _store.write(SecureKeys.tokens, jsonEncode(tokens.toJson()));
}

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => TokenStore(ref.watch(secureStoreProvider));
