import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_store.g.dart';

/// Ключи в защищённом хранилище. Всё, что связано с сессией, — только здесь.
abstract final class SecureKeys {
  /// JSON сессии: телефон и данные точки.
  static const session = 'abqr.session.v1';

  /// Соль и хеш кода доступа.
  static const pinRecord = 'abqr.pin.v1';

  /// Счётчик неверных вводов кода — переживает перезапуск приложения.
  static const pinFailures = 'abqr.pin.failures.v1';
}

/// Обёртка, чтобы в тестах подменять хранилище на память.
abstract interface class SecureStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

class FlutterSecureStore implements SecureStore {
  FlutterSecureStore()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(),
        // Только на этом устройстве, без переноса в iCloud / бэкап.
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}

/// Хранилище в памяти — для тестов.
class MemorySecureStore implements SecureStore {
  final Map<String, String> values = {};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);

  @override
  Future<void> deleteAll() async => values.clear();
}

@Riverpod(keepAlive: true)
SecureStore secureStore(Ref ref) => FlutterSecureStore();
