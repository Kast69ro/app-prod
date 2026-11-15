import 'package:activbank_qr/core/security/biometric_auth.dart';
import 'package:activbank_qr/core/storage/secure_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import '../settings/settings_widget_test.dart' show openSettings, phoneSize;

const home = 'Успешные за сегодня';

void main() {
  /// Вход и создание кода; на вопрос о биометрии отвечаем [enable].
  Future<MemorySecureStore> signInAnswering(
    WidgetTester tester,
    FakeBiometricAuth bio, {
    required bool enable,
  }) async {
    final store = await pumpTestApp(
      tester,
      FakeBackend(),
      biometrics: bio,
      size: phoneSize,
    );
    await signIn(tester);
    expect(find.text('Входить по Face ID?'), findsOneWidget);
    await tester.tap(find.text(enable ? 'Включить' : 'Не сейчас'));
    await settleWithIsolate(tester);
    return store;
  }

  testWidgets('после создания кода: «Включить» → сканирование → главная', (
    tester,
  ) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.face);
    final store = await signInAnswering(tester, bio, enable: true);

    expect(find.text(home), findsOneWidget);
    expect(bio.prompts, 1);
    expect(bio.lastPrompt!.cancel, 'Отмена');
    expect(store.values[SecureKeys.biometric], '1');
  });

  testWidgets('«Не сейчас» — без сканирования и без биометрии', (tester) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.face);
    final store = await signInAnswering(tester, bio, enable: false);

    expect(find.text(home), findsOneWidget);
    expect(bio.prompts, 0);
    expect(store.values.containsKey(SecureKeys.biometric), isFalse);
  });

  testWidgets('сканирование при включении не прошло — код без биометрии', (
    tester,
  ) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.face, succeeds: false);
    final store = await signInAnswering(tester, bio, enable: true);

    expect(find.text(home), findsOneWidget);
    expect(store.values.containsKey(SecureKeys.biometric), isFalse);
  });

  testWidgets('без биометрии на устройстве — не спрашиваем', (tester) async {
    final bio = FakeBiometricAuth();
    await pumpTestApp(tester, FakeBackend(), biometrics: bio, size: phoneSize);
    await signIn(tester);

    expect(find.text(home), findsOneWidget);
    expect(bio.prompts, 0);
  });

  testWidgets('перезапуск: окно Face ID само, успех → главная', (tester) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.face);
    final store = await signInAnswering(tester, bio, enable: true);

    await pumpTestApp(
      tester,
      FakeBackend(),
      store: store,
      biometrics: bio,
      size: phoneSize,
    );

    expect(find.text(home), findsOneWidget);
    expect(bio.prompts, 2);
    expect(bio.lastPrompt!.cancel, 'Ввести код');
  });

  testWidgets('отменили окно → код или кнопка «Войти по Face ID»', (
    tester,
  ) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.face);
    final store = await signInAnswering(tester, bio, enable: true);

    bio.succeeds = false;
    await pumpTestApp(
      tester,
      FakeBackend(),
      store: store,
      biometrics: bio,
      size: phoneSize,
    );
    expect(find.text('Код входа'), findsOneWidget);
    expect(find.text('Войти по Face ID'), findsOneWidget);

    bio.succeeds = true;
    await tester.tap(find.text('Войти по Face ID'));
    await tester.pumpAndSettle();
    expect(find.text(home), findsOneWidget);
  });

  testWidgets('биометрия выключена — на экране кода её нет', (tester) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.fingerprint);
    final store = await pumpTestApp(
      tester,
      FakeBackend(),
      biometrics: bio,
      size: phoneSize,
    );
    await signIn(tester);
    await tester.tap(find.text('Не сейчас'));
    await settleWithIsolate(tester);

    await pumpTestApp(
      tester,
      FakeBackend(),
      store: store,
      biometrics: bio,
      size: phoneSize,
    );
    expect(find.text('Код входа'), findsOneWidget);
    expect(find.text('Войти по отпечатку'), findsNothing);
    expect(bio.prompts, 0);
  });

  testWidgets('настройки: включение — через сканирование, выключение — сразу', (
    tester,
  ) async {
    final bio = FakeBiometricAuth(kind: BiometricKind.fingerprint);
    final store = await signInAnsweringFingerprint(tester, bio);
    await openSettings(tester);
    expect(find.text('Вход по отпечатку'), findsOneWidget);

    bio.succeeds = false;
    await tester.tap(find.text('Вход по отпечатку'));
    await tester.pumpAndSettle();
    expect(store.values.containsKey(SecureKeys.biometric), isFalse);

    bio.succeeds = true;
    await tester.tap(find.text('Вход по отпечатку'));
    await tester.pumpAndSettle();
    expect(store.values[SecureKeys.biometric], '1');

    final prompts = bio.prompts;
    await tester.tap(find.text('Вход по отпечатку'));
    await tester.pumpAndSettle();
    expect(store.values.containsKey(SecureKeys.biometric), isFalse);
    expect(bio.prompts, prompts);
  });

  testWidgets('настройки: без биометрии на устройстве строки нет', (
    tester,
  ) async {
    await pumpTestApp(tester, FakeBackend(), size: phoneSize);
    await signIn(tester);
    await openSettings(tester);

    expect(find.textContaining('Вход по'), findsNothing);
  });
}

/// Вход с отпечатком на устройстве, на вопрос — «Не сейчас».
Future<MemorySecureStore> signInAnsweringFingerprint(
  WidgetTester tester,
  FakeBiometricAuth bio,
) async {
  final store = await pumpTestApp(
    tester,
    FakeBackend(),
    biometrics: bio,
    size: phoneSize,
  );
  await signIn(tester);
  expect(find.text('Входить по отпечатку?'), findsOneWidget);
  await tester.tap(find.text('Не сейчас'));
  await settleWithIsolate(tester);
  return store;
}
