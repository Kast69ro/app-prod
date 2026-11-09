import 'package:activbank_qr/core/security/pin_hasher.dart';
import 'package:activbank_qr/core/storage/secure_store.dart';
import 'package:activbank_qr/features/pin/data/pin_repository.dart';
import 'package:flutter_test/flutter_test.dart';

const phone = '931234567';

void main() {
  late MemorySecureStore store;
  late PinRepository repo;

  PinRepository newRepo() =>
      PinRepository(store, hasher: const PinHasher(iterations: 10));

  setUp(() {
    store = MemorySecureStore();
    repo = newRepo();
  });

  test('без кода hasPin = false, после save — true', () async {
    expect(await repo.hasPin(), isFalse);
    await repo.save('1234', phone);
    expect(await repo.hasPin(), isTrue);
  });

  test('верный код', () async {
    await repo.save('1234', phone);
    expect(await repo.check('1234', phone), isA<PinOk>());
  });

  test('неверный код уменьшает число попыток', () async {
    await repo.save('1234', phone);
    final r1 = await repo.check('0000', phone);
    final r2 = await repo.check('0000', phone);
    expect((r1 as PinWrong).attemptsLeft, 4);
    expect((r2 as PinWrong).attemptsLeft, 3);
  });

  test('5 ошибок — блокировка', () async {
    await repo.save('1234', phone);
    for (var i = 0; i < pinMaxAttempts - 1; i++) {
      expect(await repo.check('0000', phone), isA<PinWrong>());
    }
    expect(await repo.check('0000', phone), isA<PinLockedOut>());
  });

  test('верный код сбрасывает счётчик', () async {
    await repo.save('1234', phone);
    await repo.check('0000', phone);
    await repo.check('0000', phone);
    await repo.check('1234', phone);
    final r = await repo.check('0000', phone);
    expect((r as PinWrong).attemptsLeft, 4);
  });

  test('счётчик переживает перезапуск приложения', () async {
    await repo.save('1234', phone);
    await repo.check('0000', phone);
    await repo.check('0000', phone);

    final afterRestart = newRepo();
    final r = await afterRestart.check('0000', phone);
    expect((r as PinWrong).attemptsLeft, 2);
  });

  test('без записи кода — блокировка', () async {
    expect(await repo.check('1234', phone), isA<PinLockedOut>());
  });

  test('повреждённая запись — блокировка', () async {
    store.values[SecureKeys.pinRecord] = 'не json';
    expect(await repo.check('1234', phone), isA<PinLockedOut>());
  });
}
