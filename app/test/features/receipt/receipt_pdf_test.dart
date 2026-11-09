import 'dart:io';
import 'dart:typed_data';

import 'package:activbank_qr/features/payment/domain/payment.dart';
import 'package:activbank_qr/features/receipt/domain/receipt.dart';
import 'package:activbank_qr/features/receipt/presentation/receipt_pdf.dart';
import 'package:activbank_qr/l10n/app_localizations_ru.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l = AppLocalizationsRu();
  late List<String> loaded;
  late ReceiptPdf builder;

  setUp(() {
    loaded = [];
    // Шрифты — прямо из assets/, как их отдал бы rootBundle.
    builder = ReceiptPdf((path) async {
      loaded.add(path);
      return ByteData.sublistView(await File(path).readAsBytes());
    });
  });

  Receipt receipt({DateTime? at, String storeName = 'ООО Ромашка'}) => Receipt(
    payment: Payment(
      sender: 'Душанбе Сити Банк',
      amount: 1234567.89,
      status: PaymentStatus.success,
      createdAt: at,
    ),
    storeName: storeName,
    terminalName: 'Касса 1',
    terminalId: '12345',
  );

  test('собирает лёгкий PDF', () async {
    final pdf = await builder.build(receipt(at: DateTime(2026, 9, 8)), l);

    expect(String.fromCharCodes(pdf.sublist(0, 5)), '%PDF-');
    // В файл попадают только нужные глифы, а не шрифты целиком.
    expect(pdf.length, lessThan(100 * 1024));
  });

  test('без даты и названия точки — тоже собирается', () async {
    final pdf = await builder.build(receipt(storeName: ''), l);
    expect(String.fromCharCodes(pdf.sublist(0, 5)), '%PDF-');
  });

  test('шрифты загружаются один раз', () async {
    await builder.build(receipt(), l);
    await builder.build(receipt(), l);
    expect(loaded, hasLength(4));
  });
}
