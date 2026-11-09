import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/security/pin_hasher.dart';
import '../../../core/storage/secure_store.dart';

part 'pin_repository.g.dart';

const pinLength = 4;
const pinMaxAttempts = 5;

sealed class PinCheck {
  const PinCheck();
}

class PinOk extends PinCheck {
  const PinOk();
}

class PinWrong extends PinCheck {
  const PinWrong(this.attemptsLeft);
  final int attemptsLeft;
}

/// Попытки кончились — сессию нужно стереть.
class PinLockedOut extends PinCheck {
  const PinLockedOut();
}

/// Код доступа и счётчик неверных попыток (переживает перезапуск).
class PinRepository {
  PinRepository(this._store, {this.hasher = const PinHasher()});

  final SecureStore _store;
  final PinHasher hasher;

  Future<bool> hasPin() async =>
      await _store.read(SecureKeys.pinRecord) != null;

  Future<void> save(String pin, String phone) async {
    final record = await hasher.create(pin, phone);
    await _store.write(SecureKeys.pinRecord, jsonEncode(record.toJson()));
    await _store.delete(SecureKeys.pinFailures);
  }

  Future<PinCheck> check(String pin, String phone) async {
    final raw = await _store.read(SecureKeys.pinRecord);
    if (raw == null) return const PinLockedOut();

    final PinRecord record;
    try {
      record = PinRecord.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return const PinLockedOut();
    }

    // Сначала увеличиваем счётчик, потом проверяем: если приложение убьют
    // посреди проверки, попытка всё равно засчитается.
    final failures = await _failures() + 1;
    await _store.write(SecureKeys.pinFailures, '$failures');

    if (await hasher.verify(pin, phone, record)) {
      await _store.delete(SecureKeys.pinFailures);
      return const PinOk();
    }
    if (failures >= pinMaxAttempts) return const PinLockedOut();
    return PinWrong(pinMaxAttempts - failures);
  }

  Future<int> _failures() async =>
      int.tryParse(await _store.read(SecureKeys.pinFailures) ?? '') ?? 0;
}

@Riverpod(keepAlive: true)
PinRepository pinRepository(Ref ref) =>
    PinRepository(ref.watch(secureStoreProvider));
