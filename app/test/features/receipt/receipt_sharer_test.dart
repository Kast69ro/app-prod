import 'dart:io';
import 'dart:typed_data';

import 'package:activbank_qr/features/receipt/data/receipt_sharer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  late Directory temp;
  late List<ShareParams> shared;
  late ReceiptSharer sharer;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('receipt_test');
    shared = [];
    // Вместо системного окна «Поделиться» — запоминаем, что ему отдали.
    sharer = ReceiptSharer(() async => temp, (params) async {
      shared.add(params);
      return const ShareResult('ok', ShareResultStatus.success);
    });
  });

  tearDown(() => temp.delete(recursive: true));

  test('PDF пишется в папку receipts и уходит в «Поделиться»', () async {
    final pdf = Uint8List.fromList('%PDF-'.codeUnits);
    await sharer.share(pdf, fileName: 'receipt_2026-09-08_1412');

    final file = shared.single.files!.single;
    expect(file.path, endsWith('receipts/receipt_2026-09-08_1412.pdf'));
    expect(file.mimeType, 'application/pdf');
    expect(await File(file.path).readAsBytes(), pdf);
  });

  test('старые чеки удаляются перед новым', () async {
    await sharer.share(Uint8List(1), fileName: 'old');
    await sharer.share(Uint8List(2), fileName: 'new');

    final names = Directory('${temp.path}/receipts')
        .listSync()
        .map((f) => f.uri.pathSegments.last);
    expect(names, ['new.pdf']);
  });
}
