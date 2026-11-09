import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_format.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import '../../receipt/data/receipt_sharer.dart';
import '../data/history_repository.dart';
import '../domain/history_period.dart';
import '../domain/history_report.dart';
import 'history_report_pdf.dart';

part 'history_export_controller.g.dart';

/// Отчёт в PDF: все операции периода → PDF → окно «Поделиться».
/// Состояние — идёт ли выгрузка (кнопка показывает загрузку).
@riverpod
class HistoryExportController extends _$HistoryExportController {
  @override
  bool build() => false;

  /// Ошибки (нет сети, ответ бэка) пробрасываются — их покажет экран.
  /// [origin] — откуда открыть окно «Поделиться» на iPad.
  Future<void> export(
    DateRange range,
    AppLocalizations l, {
    Rect? origin,
  }) async {
    assert(range.days <= maxReportDays);
    if (state) return;
    state = true;
    try {
      final payments = await ref.read(historyRepositoryProvider).getAll(range);
      final session = ref.read(sessionControllerProvider).value?.session;
      final report = HistoryReport(
        range: range,
        payments: payments,
        storeName: session?.storeName ?? '',
        terminalName: session?.terminalName ?? '',
        terminalId: session?.terminalId ?? '',
        generatedAt: DateTime.now(),
      );
      final pdf = await ref.read(historyReportPdfProvider).build(report, l);
      if (!ref.mounted) return;
      await ref
          .read(receiptSharerProvider)
          .share(pdf, fileName: reportFileName(range), origin: origin);
    } finally {
      if (ref.mounted) state = false;
    }
  }
}

/// `report_2026-09-10_2026-10-10` — без кириллицы и пробелов.
String reportFileName(DateRange r) => r.isSingleDay
    ? 'report_${formatIsoDate(r.from)}'
    : 'report_${formatIsoDate(r.from)}_${formatIsoDate(r.to)}';
