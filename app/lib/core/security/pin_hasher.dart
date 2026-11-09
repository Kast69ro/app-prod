import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

/// Запись о коде доступа: соль + PBKDF2-HMAC-SHA256. Сам код нигде не хранится.
///
/// 4 цифры — это всего 10 000 вариантов, поэтому главная защита — защищённое
/// хранилище и лимит попыток. PBKDF2 с солью делает перебор украденной записи
/// медленным и не даёт сравнить записи разных телефонов.
@immutable
class PinRecord {
  const PinRecord({
    required this.salt,
    required this.iterations,
    required this.hash,
  });

  factory PinRecord.fromJson(Map<String, dynamic> json) => PinRecord(
    salt: base64Decode(json['salt'] as String),
    iterations: json['iter'] as int,
    hash: base64Decode(json['hash'] as String),
  );

  final Uint8List salt;
  final int iterations;
  final Uint8List hash;

  Map<String, dynamic> toJson() => {
    'v': 1,
    'salt': base64Encode(salt),
    'iter': iterations,
    'hash': base64Encode(hash),
  };
}

class PinHasher {
  const PinHasher({this.iterations = defaultIterations});

  /// ~0,5–1 с на слабом телефоне. Число хранится в записи — можно менять.
  static const defaultIterations = 25000;

  final int iterations;

  /// Новая запись со случайной солью. [context] — номер телефона, привязывает код к сессии.
  Future<PinRecord> create(String pin, String context) async {
    final rnd = Random.secure();
    final salt = Uint8List.fromList(List.generate(16, (_) => rnd.nextInt(256)));
    final hash = await _derive(pin, context, salt, iterations);
    return PinRecord(salt: salt, iterations: iterations, hash: hash);
  }

  Future<bool> verify(String pin, String context, PinRecord record) async {
    final hash = await _derive(pin, context, record.salt, record.iterations);
    return _constantTimeEquals(hash, record.hash);
  }

  /// Считаем в отдельном изоляте, чтобы не подвисал интерфейс.
  static Future<Uint8List> _derive(
    String pin,
    String context,
    Uint8List salt,
    int iterations,
  ) => compute(_pbkdf2, (
    password: utf8.encode('abqr:$context:$pin'),
    salt: salt,
    iter: iterations,
  ));
}

/// PBKDF2-HMAC-SHA256, один блок (32 байта).
Uint8List _pbkdf2(({List<int> password, Uint8List salt, int iter}) a) {
  final hmac = Hmac(sha256, a.password);
  var u = hmac.convert([...a.salt, 0, 0, 0, 1]).bytes;
  final out = Uint8List.fromList(u);
  for (var i = 1; i < a.iter; i++) {
    u = hmac.convert(u).bytes;
    for (var j = 0; j < out.length; j++) {
      out[j] ^= u[j];
    }
  }
  return out;
}

bool _constantTimeEquals(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a[i] ^ b[i];
  }
  return diff == 0;
}

/// Только для тестов: PBKDF2 без изолята.
@visibleForTesting
Uint8List pbkdf2ForTest(List<int> password, List<int> salt, int iterations) =>
    _pbkdf2((
      password: password,
      salt: Uint8List.fromList(salt),
      iter: iterations,
    ));
