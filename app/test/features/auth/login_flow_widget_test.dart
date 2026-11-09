import 'package:activbank_qr/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('вход по номеру и создание кода', (tester) async {
    await pumpTestApp(tester, FakeBackend());

    expect(find.text('Вход для мерчантов'), findsOneWidget);
    await typeDigits(tester, '931234567');
    expect(find.text('93 123 45 67'), findsOneWidget);

    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.textContaining('Код из SMS на +992 93 ··· 67'), findsOneWidget);
    expect(find.text('Код снова через 60 с'), findsOneWidget);

    await typeDigits(tester, '123456');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.text('Создайте код входа'), findsOneWidget);
    await typeDigits(tester, '1234');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    expect(find.text('Повторите код'), findsOneWidget);

    await typeDigits(tester, '1234');
    await settleWithIsolate(tester);

    expect(find.text('Магазин на Рудаки'), findsOneWidget);
  });

  testWidgets('код из SMS подставляется и уходит сам', (tester) async {
    final sms = FakeSmsCodeReader();
    final backend = FakeBackend();
    await pumpTestApp(tester, backend, sms: sms);

    await typeDigits(tester, '931234567');
    expect(sms.listening, isFalse);
    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(sms.listening, isTrue);

    sms.deliver('123456');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(backend.requests, contains('/pos/otp/verify'));
    expect(find.text('Создайте код входа'), findsOneWidget);
  });

  testWidgets('«Изменить номер» перестаёт ждать SMS', (tester) async {
    final sms = FakeSmsCodeReader();
    final backend = FakeBackend();
    await pumpTestApp(tester, backend, sms: sms);

    await typeDigits(tester, '931234567');
    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    await tester.tap(find.text('Изменить номер'));
    await tester.pumpAndSettle();
    expect(sms.cancels, 1);
    expect(sms.listening, isFalse);
    expect(backend.requests, isNot(contains('/pos/otp/verify')));
    expect(find.text('Вход для мерчантов'), findsOneWidget);
  });

  testWidgets('неверный SMS-код показывает detail с бэка', (tester) async {
    await pumpTestApp(tester, FakeBackend()..verifyStatus = 400);

    await typeDigits(tester, '931234567');
    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    await typeDigits(tester, '000000');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.text('Осталось попыток: 4'), findsOneWidget);
  });

  testWidgets('«Выйти» на экране кода: отмена и выход', (tester) async {
    final backend = FakeBackend();
    final store = await pumpTestApp(tester, backend);
    await signIn(tester);

    // Перезапуск — спрашивают код, «Забыли код?» больше нет.
    await pumpTestApp(tester, backend, store: store);
    expect(find.text('Код входа'), findsOneWidget);
    expect(find.textContaining('Забыли код'), findsNothing);

    await tester.tap(find.text('Выйти'));
    await tester.pumpAndSettle();
    expect(find.text('Выйти из приложения?'), findsOneWidget);
    await tester.tap(find.text('Отмена'));
    await tester.pumpAndSettle();
    expect(find.text('Код входа'), findsOneWidget);

    await tester.tap(find.text('Выйти'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Выйти').last);
    await tester.pumpAndSettle();

    expect(find.text('Вход для мерчантов'), findsOneWidget);
    expect(store.values, isEmpty);
  });

  testWidgets('несовпадение кодов — начать заново', (tester) async {
    await pumpTestApp(tester, FakeBackend());
    await typeDigits(tester, '931234567');
    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await typeDigits(tester, '123456');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    await typeDigits(tester, '1234');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();
    await typeDigits(tester, '9999');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('Коды не совпали. Задайте код заново.'), findsOneWidget);
    expect(find.text('Создайте код входа'), findsOneWidget);
  });

  /// Поле с фокусом — туда пишет системная клавиатура.
  final focused = find.byWidgetPredicate(
    (w) => w is EditableText && w.focusNode.hasFocus,
  );

  testWidgets('номер вставлен целиком с +992 — берём последние 9 цифр', (
    tester,
  ) async {
    await pumpTestApp(tester, FakeBackend());
    await tester.enterText(focused, '+992 93 123 45 67');
    await tester.pump();
    expect(find.text('93 123 45 67'), findsOneWidget);
  });

  testWidgets('код из SMS автозаполнением — сразу уходит на проверку', (
    tester,
  ) async {
    await pumpTestApp(tester, FakeBackend());
    await typeDigits(tester, '931234567');
    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    // Автозаполнение вставляет все 6 цифр разом.
    await tester.enterText(focused, '123456');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(find.text('Создайте код входа'), findsOneWidget);
  });

  testWidgets('ошибка не сдвигает кнопку над клавиатурой', (tester) async {
    await pumpTestApp(tester, FakeBackend()..verifyStatus = 400);
    await typeDigits(tester, '931234567');
    await tester.tap(find.text('Получить код'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    final before = tester.getRect(find.byType(PrimaryButton));

    await typeDigits(tester, '000000');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(find.text('Осталось попыток: 4'), findsOneWidget);
    expect(tester.getRect(find.byType(PrimaryButton)), before);
  });
}
