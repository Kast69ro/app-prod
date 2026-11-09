import 'package:activbank_qr/core/widgets/qr_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

const nbsp = ' ';

void main() {
  testWidgets('главная: шапка, QR, сводка, последний платёж', (tester) async {
    final backend = FakeBackend();
    await pumpTestApp(tester, backend, size: const Size(390, 844));
    await signIn(tester);

    expect(find.text('Магазин на Рудаки'), findsOneWidget);
    expect(find.text('ID 12345'), findsOneWidget);
    expect(find.byType(QrCodeView), findsOneWidget);

    expect(find.text('795,00'), findsOneWidget);
    expect(find.text('21 платёж'), findsOneWidget);
    // Возвратов бэк пока не отдаёт — прочерк, а не сумма отклонённых.
    expect(find.text('60,00'), findsNothing);

    await tester.scrollUntilVisible(find.text('Последний платёж'), 100);
    expect(find.text('+150,00'), findsOneWidget);
    expect(find.text('Душанбе Сити Банк · 14:12'), findsOneWidget);

    // Телефон уходит в GET-запросы после входа.
    expect(backend.requests, containsAll(['/pos/terminal', '/pos/summary']));
  });

  testWidgets('QR на весь экран и обратно', (tester) async {
    await pumpTestApp(tester, FakeBackend(), size: const Size(390, 844));
    await signIn(tester);

    await tester.tap(find.byType(QrCodeView));
    await tester.pumpAndSettle();
    expect(find.text('Нажмите, чтобы закрыть'), findsOneWidget);
    expect(find.text('История'), findsNothing); // без нижней панели

    await tester.tap(find.text('Нажмите, чтобы закрыть'));
    await tester.pumpAndSettle();
    expect(find.text('Нажмите, чтобы закрыть'), findsNothing);
    expect(find.text('Успешные за сегодня'), findsOneWidget);
  });

  testWidgets('нет сети: QR из сессии виден, есть «Повторить»', (tester) async {
    final backend = FakeBackend();
    final store = await pumpTestApp(
      tester,
      backend,
      size: const Size(390, 844),
    );
    await signIn(tester);

    // «Перезапуск» с той же памятью, но без сети.
    backend.terminalFails = true;
    await pumpTestApp(
      tester,
      backend,
      store: store,
      size: const Size(390, 844),
    );
    expect(find.text('Код входа'), findsOneWidget);
    await typeDigits(tester, '1234');
    await settleWithIsolate(tester);

    expect(find.byType(QrCodeView), findsOneWidget);
    expect(find.text('Магазин на Рудаки'), findsOneWidget);
    expect(
      find.text('Нет связи с сервером. Проверьте интернет.'),
      findsOneWidget,
    );
    expect(find.text('Повторить'), findsOneWidget);
  });

  testWidgets('маленький экран и крупный шрифт — без переполнений', (
    tester,
  ) async {
    await pumpTestApp(tester, FakeBackend());
    await signIn(tester);
    expect(find.byType(QrCodeView), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Последний платёж'), 100);
    await tester.tap(find.text('История'));
    await tester.pumpAndSettle();
    expect(find.text('История'), findsNWidgets(2));
  });
}
