import 'dart:io';
import 'dart:typed_data';

import 'package:activbank_qr/features/history/domain/history_period.dart';
import 'package:activbank_qr/features/history/domain/history_report.dart';
import 'package:activbank_qr/features/history/presentation/history_export_controller.dart';
import 'package:activbank_qr/features/history/presentation/history_report_pdf.dart';
import 'package:activbank_qr/features/payment/domain/payment.dart';
import 'package:activbank_qr/l10n/app_localizations_ru.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l = AppLocalizationsRu();
  final range = DateRange(DateTime(2026, 9, 10), DateTime(2026, 10, 10));
  late List<String> loaded;
  late HistoryReportPdf builder;

  setUp(() {
    loaded = [];
    // Шрифты — прямо из assets/, как их отдал бы rootBundle.
    builder = HistoryReportPdf((path) async {
      loaded.add(path);
      return ByteData.sublistView(await File(path).readAsBytes());
    });
  });

  HistoryReport report(int count) => HistoryReport(
    range: range,
    payments: [
      for (var i = 0; i < count; i++)
        Payment(
          sender: i.isEven ? 'Душанбе Сити Банк' : 'Алиф',
          amount: 100.5 + i,
          status: i % 5 == 0 ? PaymentStatus.cancel : PaymentStatus.success,
          createdAt: i == 3 ? null : DateTime(2026, 10, 10, 14, 12),
        ),
    ],
    storeName: 'ООО Ромашка',
    terminalName: 'Касса 1',
    terminalId: '12345',
    generatedAt: DateTime(2026, 10, 23, 9, 5),
  );

  /// Число страниц — по объектам `/Type /Page` в несжатом каталоге.
  int pages(Uint8List pdf) =>
      RegExp(r'/Type\s*/Page\b').allMatches(String.fromCharCodes(pdf)).length;

  test('пустой период — одна страница', () async {
    final pdf = await builder.build(report(0), l);
    expect(String.fromCharCodes(pdf.sublist(0, 5)), '%PDF-');
    expect(pages(pdf), 1);
  });

  test('много операций — несколько страниц, шрифты один раз', () async {
    final small = await builder.build(report(10), l);
    final big = await builder.build(report(600), l);

    expect(pages(small), 1);
    expect(pages(big), greaterThan(10));
    // В файл попадают только нужные глифы, а не шрифты целиком.
    expect(big.length, lessThan(1024 * 1024));
    expect(loaded, hasLength(4));
  });

  test('имя файла — без кириллицы', () {
    expect(reportFileName(range), 'report_2026-09-10_2026-10-10');
    final day = DateRange(DateTime(2026, 9, 8), DateTime(2026, 9, 8));
    expect(reportFileName(day), 'report_2026-09-08');
  });
}
