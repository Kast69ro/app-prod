import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:activbank_qr/features/home/presentation/widgets/qr_card.dart';
import 'package:activbank_qr/features/pin/presentation/pin_screen.dart';
import 'package:activbank_qr/features/settings/presentation/settings_screen.dart';

import '../../helpers/test_app.dart';

const phoneSize = Size(390, 844);

Future<void> openSettings(WidgetTester tester) async {
  await tester.tap(
    find.byWidgetPredicate(
      (w) => w is Semantics && w.properties.label == 'Настройки',
    ),
  );
  await tester.pumpAndSettle();
}

/// Ввод 4 цифр и ожидание проверки (хеш считается в изоляте).
Future<void> enterPin(WidgetTester tester, String pin) async {
  await typeDigits(tester, pin);
  await settleWithIsolate(tester);
}

void main() {
  testWidgets('настройки: данные точки, без нижней панели', (tester) async {
    await pumpTestApp(tester, FakeBackend(), size: phoneSize);
    await signIn(tester);
    await openSettings(tester);

    expect(find.text('Настройки'), findsOneWidget);
    expect(find.text('Магазин на Рудаки'), findsOneWidget);
    expect(find.text('ООО Ромашка'), findsOneWidget);
    expect(find.text('12345'), findsOneWidget);
    expect(find.text('+992 93 ··· 67'), findsOneWidget);
    expect(find.text('История'), findsNothing);

    await tester.tap(find.text('← Назад'));
    await tester.pumpAndSettle();
    expect(find.text('Успешные за сегодня'), findsOneWidget);
  });

  testWidgets('смена кода: неверный текущий, затем новый код работает', (
    tester,
  ) async {
    final backend = FakeBackend();
    final store = await pumpTestApp(tester, backend, size: phoneSize);
    await signIn(tester);
    await openSettings(tester);
    await tester.tap(find.text('Сменить код входа'));
    await tester.pumpAndSettle();

    expect(find.text('Текущий код'), findsOneWidget);
    await enterPin(tester, '0000');
    expect(find.text('Неверный код. Осталось попыток: 4'), findsOneWidget);

    await enterPin(tester, '1234');
    expect(find.text('Новый код входа'), findsOneWidget);
    await enterPin(tester, '5678');
    expect(find.text('Повторите код'), findsOneWidget);
    await enterPin(tester, '5678');

    expect(find.text('Код входа изменён'), findsOneWidget);
    expect(find.text('Настройки'), findsOneWidget);

    // После перезапуска подходит только новый код.
    await pumpTestApp(tester, backend, store: store, size: phoneSize);
    await enterPin(tester, '1234');
    expect(find.text('Код входа'), findsOneWidget);
    await enterPin(tester, '5678');
    expect(find.text('Успешные за сегодня'), findsOneWidget);
  });

  testWidgets('«Выйти» в настройках ведёт на вход по номеру', (tester) async {
    final backend = FakeBackend();
    final store = await pumpTestApp(tester, backend, size: phoneSize);
    await signIn(tester);
    await openSettings(tester);

    await tester.tap(find.text('Выйти'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Выйти').last);
    await tester.pumpAndSettle();

    expect(find.text('Вход для мерчантов'), findsOneWidget);
    expect(store.values, isEmpty);
  });

  testWidgets('маленький экран и крупный шрифт — без переполнений', (
    tester,
  ) async {
    await pumpTestApp(tester, FakeBackend());
    await signIn(tester);
    await openSettings(tester);
    await tester.scrollUntilVisible(find.text('Сменить код входа'), 100);
    await tester.ensureVisible(find.text('Сменить код входа'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Сменить код входа'));
    await tester.pumpAndSettle();
    expect(find.text('Текущий код'), findsOneWidget);
  });

  Brightness brightnessOf(WidgetTester tester, Type screen) =>
      Theme.of(tester.element(find.byType(screen))).brightness;

  testWidgets(
    'тема: тёмная сохраняется после перезапуска, лого TJ QR светлое',
    (tester) async {
      final store = await pumpTestApp(tester, FakeBackend(), size: phoneSize);
      await signIn(tester);
      await openSettings(tester);
      expect(brightnessOf(tester, SettingsScreen), Brightness.light);

      await tester.tap(find.text('Тёмная'));
      await tester.pumpAndSettle();
      expect(brightnessOf(tester, SettingsScreen), Brightness.dark);

      await tester.tap(find.text('← Назад'));
      await tester.pumpAndSettle();
      // На тёмной карточке — вариант лого со светлыми буквами «QR».
      final logo = tester.widget<Image>(
        find.descendant(of: find.byType(QrCard), matching: find.byType(Image)),
      );
      expect(
        (logo.image as AssetImage).assetName,
        'assets/images/tjqr-logo-dark.png',
      );

      // Перезапуск: настройки и сессия те же — сразу экран кода, уже тёмный.
      await pumpTestApp(
        tester,
        FakeBackend(),
        store: store,
        size: phoneSize,
        prefs: null,
      );
      expect(brightnessOf(tester, PinScreen), Brightness.dark);
    },
  );

  testWidgets('тема: по умолчанию светлая, «Системная» — за телефоном', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    // Телефон в тёмной теме, но пользователь ещё ничего не выбрал — светлая.
    await pumpTestApp(tester, FakeBackend(), size: phoneSize);
    await signIn(tester);
    await openSettings(tester);
    expect(brightnessOf(tester, SettingsScreen), Brightness.light);

    await tester.tap(find.text('Системная'));
    await tester.pumpAndSettle();
    expect(brightnessOf(tester, SettingsScreen), Brightness.dark);
  });
}
