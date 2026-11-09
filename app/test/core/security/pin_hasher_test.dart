import 'dart:convert';

import 'package:activbank_qr/core/security/pin_hasher.dart';
import 'package:flutter_test/flutter_test.dart';

String hex(List<int> b) =>
    b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

void main() {
  group('PBKDF2-HMAC-SHA256 — эталонные векторы', () {
    final p = utf8.encode('password');
    final s = utf8.encode('salt');

    test('c = 1', () {
      expect(
        hex(pbkdf2ForTest(p, s, 1)),
        '120fb6cffcf8b32c43e7225256c4f837a86548c92ccc35480805987cb70be17b',
      );
    });

    test('c = 2', () {
      expect(
        hex(pbkdf2ForTest(p, s, 2)),
        'ae4d0c95af6b46d32d0adff928f06dd02a303f8ef3c251dfd6e2d85a95474c43',
      );
    });

    test('c = 4096', () {
      expect(
        hex(pbkdf2ForTest(p, s, 4096)),
        'c5e478d59288c841aa530db6845c4c8d962893a001ce4e11a4963873aa98134a',
      );
    });
  });

  group('PinHasher', () {
    const hasher = PinHasher(iterations: 10);

    test('верный код проходит, неверный — нет', () async {
      final r = await hasher.create('1234', '931234567');
      expect(await hasher.verify('1234', '931234567', r), isTrue);
      expect(await hasher.verify('1235', '931234567', r), isFalse);
    });

    test('код привязан к номеру', () async {
      final r = await hasher.create('1234', '931234567');
      expect(await hasher.verify('1234', '939999999', r), isFalse);
    });

    test('соль случайная: одинаковые коды дают разные хеши', () async {
      final a = await hasher.create('1234', '931234567');
      final b = await hasher.create('1234', '931234567');
      expect(hex(a.hash), isNot(hex(b.hash)));
    });

    test('запись переживает JSON', () async {
      final r = await hasher.create('0000', '931234567');
      final back = PinRecord.fromJson(
        jsonDecode(jsonEncode(r.toJson())) as Map<String, dynamic>,
      );
      expect(back.iterations, 10);
      expect(await hasher.verify('0000', '931234567', back), isTrue);
    });

    test('сам код в записи не хранится', () async {
      final r = await hasher.create('4826', '931234567');
      expect(jsonEncode(r.toJson()), isNot(contains('4826')));
    });
  });
}
