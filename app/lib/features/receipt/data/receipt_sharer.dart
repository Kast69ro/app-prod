import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'receipt_sharer.g.dart';

/// Отдаёт PDF чека или отчёта в системное окно «Поделиться».
///
/// Файл пишем в свою папку и чистим её перед каждым файлом: в кеше
/// не копятся старые чеки и отчёты с данными платежей. Удалить файл сразу после
/// отправки нельзя — приложение-получатель может читать его позже.
class ReceiptSharer {
  ReceiptSharer(this._tempDir, this._share);

  final Future<Directory> Function() _tempDir;

  /// Обычно `SharePlus.instance.share`; в тестах — подмена.
  final Future<ShareResult> Function(ShareParams) _share;

  /// [fileName] без расширения. [origin] — откуда открыть окно на iPad.
  Future<void> share(
    Uint8List pdf, {
    required String fileName,
    Rect? origin,
  }) async {
    final XFile file;
    if (kIsWeb) {
      // Только предпросмотр вёрстки — файловой системы нет.
      file = XFile.fromData(
        pdf,
        mimeType: 'application/pdf',
        name: '$fileName.pdf',
      );
    } else {
      final dir = Directory('${(await _tempDir()).path}/receipts');
      if (await dir.exists()) await dir.delete(recursive: true);
      await dir.create(recursive: true);
      final path = '${dir.path}/$fileName.pdf';
      await File(path).writeAsBytes(pdf, flush: true);
      file = XFile(path, mimeType: 'application/pdf');
    }
    await _share(ShareParams(files: [file], sharePositionOrigin: origin));
  }
}

@riverpod
ReceiptSharer receiptSharer(Ref ref) =>
    ReceiptSharer(getTemporaryDirectory, SharePlus.instance.share);
