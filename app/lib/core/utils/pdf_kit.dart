import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../theme/app_text_styles.dart';

/// Файлы Montserrat из ассетов — тот же шрифт, что в интерфейсе.
///
/// Байты, а не `pw.Font`: их можно передать в изолят и собрать
/// большой PDF там, не подвешивая интерфейс.
class PdfFontData {
  const PdfFontData(this.regular, this.medium, this.semiBold, this.bold);

  final ByteData regular;
  final ByteData medium;
  final ByteData semiBold;
  final ByteData bold;

  /// [loadAsset] — обычно `rootBundle.load`; в тестах — подмена.
  static Future<PdfFontData> load(
    Future<ByteData> Function(String path) loadAsset,
  ) async {
    Future<ByteData> font(String weight) =>
        loadAsset('assets/fonts/${AppFonts.brand}-$weight.ttf');
    return PdfFontData(
      await font('Regular'),
      await font('Medium'),
      await font('SemiBold'),
      await font('Bold'),
    );
  }

  PdfFonts toFonts() => PdfFonts(
    pw.Font.ttf(regular),
    pw.Font.ttf(medium),
    pw.Font.ttf(semiBold),
    pw.Font.ttf(bold),
  );
}

/// Начертания Montserrat для `pdf`. В файл попадают только
/// использованные глифы.
class PdfFonts {
  const PdfFonts(this.regular, this.medium, this.semiBold, this.bold);

  final pw.Font regular;
  final pw.Font medium;
  final pw.Font semiBold;
  final pw.Font bold;
}

/// Цвета берём из темы приложения, чтобы не дублировать их в PDF.
PdfColor pdfColor(Color color) => PdfColor.fromInt(color.toARGB32());
