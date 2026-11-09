import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/secure_store.dart';
import '../domain/session.dart';

part 'session_store.g.dart';

/// Сессия терминала в защищённом хранилище.
class SessionStore {
  SessionStore(this._store);

  final SecureStore _store;

  Future<Session?> read() async {
    final raw = await _store.read(SecureKeys.session);
    if (raw == null) return null;
    try {
      return Session.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      // Повреждённая запись — считаем, что сессии нет.
      await _store.delete(SecureKeys.session);
      return null;
    }
  }

  Future<void> write(Session session) =>
      _store.write(SecureKeys.session, jsonEncode(session.toJson()));

  /// Стирает всё: сессию, код доступа, счётчик попыток.
  Future<void> wipe() => _store.deleteAll();
}

@Riverpod(keepAlive: true)
SessionStore sessionStore(Ref ref) =>
    SessionStore(ref.watch(secureStoreProvider));
