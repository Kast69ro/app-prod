import 'dart:io';
import 'dart:typed_data';

import 'package:activbank_qr/core/utils/date_format.dart';
import 'package:activbank_qr/features/history/presentation/history_report_pdf.dart';
import 'package:activbank_qr/features/history/presentation/history_screen.dart';
import 'package:activbank_qr/features/history/presentation/widgets/period_chips.dart';
import 'package:activbank_qr/features/receipt/data/receipt_sharer.dart';
import 'package:activbank_qr/features/history/presentation/widgets/history_row.dart';
import 'package:activbank_qr/features/payment/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import '../payment/payment_widget_test.dart' show FakeSharer;

String iso(DateTime d) => d.toIso8601String().substring(0, 19);

Map<String, Object?> payment(
  num amount,
  DateTime at, {
  String status = 'success',
  String sender = 'Душанбе Сити Банк',
  String? type,
}) => {
  'type': ?type,
  'sender': sender,
  'amount': amount,
  'status': status,
  'creation_datetime': iso(at),
};

Future<void> openHistory(WidgetTester tester) async {
  await tester.tap(find.text('История'));
  await tester.pumpAndSettle();
}

/// Список операций (не ряд чипов периода — он тоже листается).
Finder get historyList => find.descendant(
  of: find.descendant(
    of: find.byType(HistoryScreen),
    matching: find.byType(RefreshIndicator),
  ),
  matching: find.byType(Scrollable),
);

Finder inList(Finder f) => find.descendant(of: historyList, matching: f);

Finder chip(String label) =>
    find.descendant(of: find.byType(PeriodChips), matching: find.text(label));

void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day, 12);
  final yesterday = DateTime(now.year, now.month, now.day - 1, 10);

  testWidgets('группы по дням, статусы, сумма за день', (tester) async {
    final backend = FakeBackend()
      ..history = [
        payment(150, today.add(const Duration(minutes: 5))),
        payment(20, today, status: 'cancel', sender: 'Алиф'),
        payment(1234.5, yesterday),
      ];
    // Маленький экран и крупный шрифт — ничего не должно вылезать.
    await pumpTestApp(tester, backend);
    await signIn(tester);
    await openHistory(tester);

    // Заголовки групп; такие же слова есть на чипах периода.
    expect(inList(find.text('Сегодня')), findsOneWidget);
    expect(inList(find.text('Вчера')), findsOneWidget);
    expect(find.byType(HistoryRow), findsNWidgets(3));
    expect(find.text('Оплачено'), findsNWidgets(2));
    expect(find.text('Отклонён'), findsOneWidget);
    // За сегодня — только оплаченный: 150, а не 170.
    expect(find.text('150,00'), findsNWidgets(2));
    expect(find.text('12:05'), findsOneWidget);
    // Всё загружено — кнопки нет.
    expect(find.textContaining('Показать ещё'), findsNothing);
  });

  testWidgets('клиент ActivBank — имя плательщика и метка банка', (
    tester,
  ) async {
    final backend = FakeBackend()
      ..history = [
        payment(
          44.55,
          today.add(const Duration(minutes: 5)),
          type: 'internal',
          sender: 'КУРБОНОВ Мухаммадшариф',
        ),
        payment(150, today, type: 'external'),
      ];
    // Маленький экран и крупный шрифт — третья строка не вылезает.
    await pumpTestApp(tester, backend);
    await signIn(tester);
    await openHistory(tester);

    expect(find.text('КУРБОНОВ Мухаммадшариф'), findsOneWidget);
    // Метка только у внутрибанковского, у межбанка — название банка.
    expect(find.text('ActivBank · внутри банка'), findsOneWidget);
    expect(find.text('Душанбе Сити Банк'), findsOneWidget);
  });

  testWidgets('чип статуса по ширине текста, рядом с суммой', (tester) async {
    final backend = FakeBackend()..history = [payment(150, today)];
    await pumpTestApp(
      tester,
      backend,
      size: const Size(390, 844),
      textScale: 1,
    );
    await signIn(tester);
    await openHistory(tester);

    final chip = tester.getRect(find.byType(StatusChip));
    final amount = tester.getRect(find.text('150,00').last);
    expect(chip.width, lessThan(150));
    expect((chip.center.dy - amount.center.dy).abs(), lessThan(10));
  });

  testWidgets('«Показать ещё» подгружает следующую страницу', (tester) async {
    final backend = FakeBackend()
      ..history = [
        for (var i = 0; i < 60; i++)
          payment(i + 1, today.subtract(Duration(minutes: i))),
      ];
    await pumpTestApp(tester, backend, size: const Size(390, 844));
    await signIn(tester);
    await openHistory(tester);

    final more = find.text('Показать ещё (10)');
    await tester.scrollUntilVisible(more, 500, scrollable: historyList);
    await tester.tap(more);
    await tester.pumpAndSettle();

    expect(find.textContaining('Показать ещё'), findsNothing);
    final history = backend.requests.where((r) => r == '/pos/history');
    expect(history, hasLength(2));
  });

  testWidgets('пустая история', (tester) async {
    await pumpTestApp(tester, FakeBackend());
    await signIn(tester);
    await openHistory(tester);

    expect(find.textContaining('Пока нет операций'), findsOneWidget);
  });

  testWidgets('нет сети → «Повторить» загружает список', (tester) async {
    final backend = FakeBackend()
      ..historyFails = true
      ..history = [payment(150, today)];
    await pumpTestApp(tester, backend);
    await signIn(tester);
    await openHistory(tester);

    expect(find.text('Нет связи с сервером. Проверьте интернет.'), findsOne);
    expect(find.byType(HistoryRow), findsNothing);

    backend.historyFails = false;
    await tester.tap(find.text('Повторить'));
    await tester.pumpAndSettle();

    expect(
      find.text('Нет связи с сервером. Проверьте интернет.'),
      findsNothing,
    );
    expect(find.byType(HistoryRow), findsOneWidget);
  });

  testWidgets('чип периода перезагружает историю с датами', (tester) async {
    final backend = FakeBackend();
    await pumpTestApp(tester, backend);
    await signIn(tester);
    await openHistory(tester);

    expect(backend.historyQueries.last.containsKey('date'), isFalse);
    expect(backend.historyQueries.last.containsKey('from'), isFalse);

    await tester.tap(chip('Сегодня'));
    await tester.pumpAndSettle();
    expect(backend.historyQueries.last['date'], formatIsoDate(now));
    expect(find.text('За этот период операций нет.'), findsOneWidget);

    await tester.ensureVisible(chip('7 дней'));
    await tester.tap(chip('7 дней'));
    await tester.pumpAndSettle();
    final q = backend.historyQueries.last;
    expect(q['to'], formatIsoDate(now));
    expect(q['from'], formatIsoDate(today.subtract(const Duration(days: 6))));
    expect(q['offset'], 0);
  });

  testWidgets('«Период…» — календарь, даты на чипе и в запросе', (
    tester,
  ) async {
    final backend = FakeBackend();
    await pumpTestApp(tester, backend);
    await signIn(tester);
    await openHistory(tester);

    await tester.ensureVisible(chip('Период…'));
    await tester.tap(chip('Период…'));
    await tester.pumpAndSettle();
    expect(find.text('Период истории'), findsOneWidget);

    // Календарь открыт на «этом месяце» — сохраняем как есть.
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    final from = DateTime(now.year, now.month);
    final q = backend.historyQueries.last;
    if (now.day == 1) {
      expect(q['date'], formatIsoDate(from));
    } else {
      expect(q['from'], formatIsoDate(from));
      expect(q['to'], formatIsoDate(now));
    }
    expect(find.text('Период…'), findsNothing);
  });

  testWidgets('отчёт в PDF за выбранный период уходит в «Поделиться»', (
    tester,
  ) async {
    final sharer = FakeSharer();
    final backend = FakeBackend()..history = [payment(150, today)];
    await pumpTestApp(
      tester,
      backend,
      overrides: [
        receiptSharerProvider.overrideWithValue(sharer),
        historyReportPdfProvider.overrideWithValue(
          HistoryReportPdf(
            (path) async => ByteData.sublistView(File(path).readAsBytesSync()),
            inBackground: false,
          ),
        ),
      ],
    );
    await signIn(tester);
    await openHistory(tester);
    await tester.tap(chip('Сегодня'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Отчёт в PDF'));
    await tester.pump();
    expect(find.byTooltip('Готовим отчёт…'), findsOneWidget);

    await tester.pumpAndSettle();

    final file = sharer.shared.single;
    expect(file.fileName, 'report_${formatIsoDate(now)}');
    expect(String.fromCharCodes(file.pdf.sublist(0, 5)), '%PDF-');
    expect(backend.historyQueries.last['limit'], 200);
    expect(find.byTooltip('Отчёт в PDF'), findsOneWidget);
  });

  testWidgets('отчёт за «Всё время» сначала спрашивает период', (tester) async {
    final sharer = FakeSharer();
    // По умолчанию — маленький экран и шрифт 1,3×: календарь влезает.
    await pumpTestApp(
      tester,
      FakeBackend(),
      overrides: [receiptSharerProvider.overrideWithValue(sharer)],
    );
    await signIn(tester);
    await openHistory(tester);

    await tester.tap(find.byTooltip('Отчёт в PDF'));
    await tester.pumpAndSettle();

    expect(find.text('Период отчёта'), findsOneWidget);
    expect(sharer.shared, isEmpty);
  });
}
