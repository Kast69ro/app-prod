import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/money_format.dart';
import '../../../core/utils/pdf_kit.dart';
import '../../../l10n/app_localizations.dart';
import '../../payment/domain/payment.dart';
import '../../payment/presentation/payment_status_style.dart';
import '../domain/history_period.dart';
import '../domain/history_report.dart';

part 'history_report_pdf.g.dart';

/// Отчёт по операциям за период: A4, сколько угодно страниц.
/// Шапка с точкой и итогами, дальше таблица операций.
///
/// За год набегают тысячи строк, поэтому PDF собирается в изоляте
/// (`compute`), а интерфейс в это время не зависает.
class HistoryReportPdf {
  HistoryReportPdf(this._loadAsset, {this.inBackground = true});

  /// Обычно `rootBundle.load`; в тестах — подмена.
  final Future<ByteData> Function(String path) _loadAsset;

  /// `false` — собирать без изолята. Только для виджет-тестов:
  /// там изолят под ненастоящим временем не запускается.
  final bool inBackground;

  PdfFontData? _fonts;

  Future<Uint8List> build(HistoryReport report, AppLocalizations l) async {
    final fonts = _fonts ??= await PdfFontData.load(_loadAsset);
    final args = (report, l, fonts);
    return inBackground ? compute(_render, args) : _render(args);
  }
}

/// Отчёт — документ: всегда светлый, в какой бы теме ни было приложение.
const _colors = AppColors.light;

Future<Uint8List> _render((HistoryReport, AppLocalizations, PdfFontData) args) {
  final (report, l, data) = args;
  final f = data.toFonts();
  final doc = pw.Document(title: l.reportTitle, creator: l.appTitle);
  final columns = _Columns(l);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(32, 32, 32, 24),
      theme: pw.ThemeData.withFont(base: f.regular, bold: f.bold),
      // Год операций — тысячи строк; по умолчанию pdf режет на 20 страницах.
      maxPages: 1000,
      // Шапка колонок — на каждой странице, кроме первой: там она идёт
      // сразу после итогов.
      header: (ctx) => ctx.pageNumber == 1 ? pw.SizedBox() : columns.header(f),
      footer: (ctx) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
        child: pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                '${l.appTitle} · ${l.reportTitle} · ${formatRange(report.range)}',
                style: _small,
              ),
            ),
            pw.Text(
              l.reportPage(ctx.pageNumber, ctx.pagesCount),
              style: _small,
            ),
          ],
        ),
      ),
      build: (_) => [
        pw.Text(
          l.appTitle,
          style: pw.TextStyle(
            font: f.bold,
            fontSize: 16,
            letterSpacing: -0.16,
            color: _c(_colors.textPrimary),
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(l.reportTitle, style: _caption),
        pw.SizedBox(height: 14),
        _details(report, l, f),
        pw.SizedBox(height: 12),
        _totals(report, l, f),
        pw.SizedBox(height: 18),
        if (report.payments.isEmpty)
          pw.Text(l.reportEmpty, style: _caption)
        else ...[
          columns.header(f),
          for (final (i, p) in report.payments.indexed)
            columns.row(i + 1, p, l, f),
        ],
      ],
    ),
  );
  return doc.save();
}

pw.Widget _details(HistoryReport r, AppLocalizations l, PdfFonts f) {
  String orDash(String v) => v.isEmpty ? '—' : v;
  final at = r.generatedAt;
  final rows = [
    (l.reportPeriod, formatRange(r.range)),
    (l.settingsStore, orDash(r.storeName)),
    (l.settingsTerminal, orDash(r.terminalName)),
    (l.settingsTerminalId, orDash(r.terminalId)),
    (l.reportGenerated, '${formatFullDate(at)} ${formatTime(at)}'),
  ];
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: _card,
    child: pw.Column(
      children: [
        for (final (i, (label, value)) in rows.indexed) ...[
          if (i > 0) pw.SizedBox(height: 6),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 120,
                child: pw.Text(
                  label,
                  style: pw.TextStyle(
                    fontSize: 10.5,
                    color: _c(_colors.textSecondary),
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  value,
                  style: pw.TextStyle(
                    font: f.medium,
                    fontSize: 10.5,
                    color: _c(_colors.textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}

pw.Widget _totals(HistoryReport r, AppLocalizations l, PdfFonts f) {
  pw.Widget box(String label, StatusTotal t, Color dot) => pw.Expanded(
    child: pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: _card,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 6,
                height: 6,
                decoration: pw.BoxDecoration(
                  color: _c(dot),
                  shape: pw.BoxShape.circle,
                ),
              ),
              pw.SizedBox(width: 6),
              pw.Text(label, style: _caption),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            formatMoney(t.amount),
            style: pw.TextStyle(
              font: f.semiBold,
              fontSize: 17,
              letterSpacing: -0.2,
              color: _c(_colors.textPrimary),
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Text(l.reportOperations(t.count), style: _small),
        ],
      ),
    ),
  );

  return pw.Row(
    children: [
      box(l.reportPaid, r.success, _colors.successDot),
      pw.SizedBox(width: 10),
      box(l.reportDeclined, r.cancel, _colors.cancelDot),
      // Возвратов в API пока нет — пустую плитку не рисуем.
      if (r.refunded.count > 0) ...[
        pw.SizedBox(width: 10),
        box(l.reportRefunded, r.refunded, _colors.refundDot),
      ],
    ],
  );
}

/// Колонки таблицы: одинаковые ширины у шапки и строк.
class _Columns {
  _Columns(this.l);

  final AppLocalizations l;

  static const _no = 30.0;
  static const _date = 70.0;
  static const _time = 38.0;
  static const _status = 92.0;
  static const _amount = 84.0;

  pw.Widget header(PdfFonts f) {
    final style = pw.TextStyle(
      font: f.medium,
      fontSize: 9,
      color: _c(_colors.textSecondary),
    );
    return _line(
      no: pw.Text(l.reportNumber, style: style),
      date: pw.Text(l.paymentDate, style: style),
      time: pw.Text(l.paymentTime, style: style),
      // Межбанк — банк, клиент ActivBank — имя плательщика.
      bank: pw.Text(l.reportSender, style: style),
      status: pw.Text(l.receiptStatus, style: style),
      amount: pw.Text(l.receiptAmount, style: style),
      borderColor: _colors.border,
    );
  }

  pw.Widget row(int no, Payment p, AppLocalizations l, PdfFonts f) {
    final at = p.createdAt;
    final status = PaymentStatusStyle.of(p.status, l, _colors);
    final text = pw.TextStyle(fontSize: 9.5, color: _c(_colors.textPrimary));
    return _line(
      no: pw.Text('$no', style: text.copyWith(color: _c(_colors.textTertiary))),
      date: pw.Text(at == null ? '—' : formatFullDate(at), style: text),
      time: pw.Text(at == null ? '—' : formatTime(at), style: text),
      bank: pw.Text(p.sender, style: text),
      status: pw.Row(
        children: [
          pw.Container(
            width: 5,
            height: 5,
            decoration: pw.BoxDecoration(
              color: _c(status.dot),
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 5),
          pw.Flexible(
            child: pw.Text(
              status.label,
              style: text.copyWith(color: _c(status.fg)),
            ),
          ),
        ],
      ),
      amount: pw.Text(
        formatMoney(p.amount),
        style: text.copyWith(font: f.medium),
      ),
      borderColor: _colors.borderList,
    );
  }

  pw.Widget _line({
    required pw.Widget no,
    required pw.Widget date,
    required pw.Widget time,
    required pw.Widget bank,
    required pw.Widget status,
    required pw.Widget amount,
    required Color borderColor,
  }) => pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 5),
    decoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(color: _c(borderColor), width: 0.6),
      ),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(width: _no, child: no),
        pw.SizedBox(width: _date, child: date),
        pw.SizedBox(width: _time, child: time),
        pw.Expanded(
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(right: 8),
            child: bank,
          ),
        ),
        pw.SizedBox(width: _status, child: status),
        pw.SizedBox(
          width: _amount,
          child: pw.Align(alignment: pw.Alignment.topRight, child: amount),
        ),
      ],
    ),
  );
}

final _caption = pw.TextStyle(fontSize: 11, color: _c(_colors.textSecondary));

final _small = pw.TextStyle(fontSize: 8.5, color: _c(_colors.textTertiary));

final _card = pw.BoxDecoration(
  border: pw.Border.all(color: _c(_colors.borderList)),
  borderRadius: pw.BorderRadius.circular(AppDimens.radiusRow),
);

PdfColor _c(Color color) => pdfColor(color);

/// keepAlive: шрифты читаются из ассетов один раз за сессию.
@Riverpod(keepAlive: true)
HistoryReportPdf historyReportPdf(Ref ref) => HistoryReportPdf(rootBundle.load);
