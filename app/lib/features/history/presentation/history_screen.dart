import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/money_format.dart';
import '../../../core/widgets/api_error_text.dart';
import '../../../core/widgets/pressable_card.dart';
import '../../../core/widgets/retry_banner.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/history_feed.dart';
import '../domain/history_period.dart';
import 'history_controller.dart';
import 'history_export_controller.dart';
import 'widgets/history_row.dart';
import 'widgets/period_chips.dart';
import 'widgets/report_button.dart';

/// История операций. Прототип: `POS Terminal.dc.html`, стр. 77–111.
/// Сверх прототипа — фильтр по периоду и отчёт в PDF.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _reportKey = GlobalKey();

  HistoryPeriodController get _period =>
      ref.read(historyPeriodControllerProvider.notifier);

  /// Системный календарь «с — по». `null` — закрыли без выбора.
  ///
  /// Открываем всегда с готовым периодом (по умолчанию — этот месяц):
  /// в шапке тогда короткие даты, а не длинное «Дата начала – Дата
  /// окончания», которое с крупным шрифтом не влезает.
  Future<DateRange?> _pickRange(String title, DateRange? initial) async {
    final now = DateTime.now();
    final start = initial ?? const HistoryPeriod(PeriodKind.month).range(now)!;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: dayKey(now),
      initialDateRange: DateTimeRange(start: start.from, end: start.to),
      helpText: title,
      // Шапка календаря не рассчитана на очень крупный шрифт.
      builder: (context, child) =>
          MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3, child: child!),
    );
    return picked == null ? null : DateRange(picked.start, picked.end);
  }

  Future<void> _pickCustom() async {
    final l = AppLocalizations.of(context);
    final current = ref
        .read(historyPeriodControllerProvider)
        .range(DateTime.now());
    final range = await _pickRange(l.periodPickTitle, current);
    if (range != null && mounted) _period.select(HistoryPeriod.custom(range));
  }

  /// За «Всё время» отчёт не делаем — сначала спросим период.
  Future<void> _exportReport() async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    var range = ref.read(historyPeriodControllerProvider).range(DateTime.now());
    if (range == null) {
      range = await _pickRange(l.reportPickTitle, null);
      if (range == null || !mounted) return;
      _period.select(HistoryPeriod.custom(range));
    }
    if (range.days > maxReportDays) {
      messenger.showSnackBar(SnackBar(content: Text(l.reportTooLong)));
      return;
    }

    // iPad открывает окно «Поделиться» стрелкой от кнопки.
    final button = _reportKey.currentContext?.findRenderObject() as RenderBox?;
    final origin = button == null
        ? null
        : button.localToGlobal(Offset.zero) & button.size;
    try {
      await ref
          .read(historyExportControllerProvider.notifier)
          .export(range, l, origin: origin);
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(apiErrorText(e, l))));
    }
  }

  Future<void> _refresh() async {
    ref.invalidate(historyControllerProvider);
    try {
      await ref.read(historyControllerProvider.future);
    } catch (_) {
      // Ошибку покажет плашка.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final period = ref.watch(historyPeriodControllerProvider);
    final exporting = ref.watch(historyExportControllerProvider);
    final history = ref.watch(historyControllerProvider);
    final data = history.value;
    final error = history.hasError && !history.isLoading ? history.error : null;
    final groups = data == null
        ? const <DayGroup>[]
        : groupByDay(data.feed.payments);
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              // Справа меньше: у кнопки своя зона нажатия 48 px.
              padding: const EdgeInsets.fromLTRB(
                AppDimens.screenPadding,
                10,
                AppDimens.screenPadding - 12,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(l.tabHistory, style: AppTextStyles.tabTitle),
                  ),
                  ReportButton(
                    key: _reportKey,
                    busy: exporting,
                    onTap: _exportReport,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            PeriodChips(
              selected: period.kind,
              customLabel: period.custom == null
                  ? null
                  : formatRangeShort(period.custom!, now),
              onSelect: (kind) => _period.select(HistoryPeriod(kind)),
              onCustom: _pickCustom,
            ),
            const SizedBox(height: 6),
            Expanded(
              child: RefreshIndicator(
                color: context.colors.accent,
                onRefresh: _refresh,
                child: ListView(
                  // Тянуть вниз можно и при пустом списке.
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.screenPadding,
                    6,
                    AppDimens.screenPadding,
                    20,
                  ),
                  children: [
                    if (error != null) ...[
                      RetryBanner(
                        text: apiErrorText(error, l),
                        retryLabel: l.retry,
                        onRetry: _refresh,
                      ),
                      const SizedBox(height: 14),
                    ],
                    if (data == null && history.isLoading)
                      // Цвет — акцент из темы (progressIndicatorTheme).
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (data != null && groups.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 40,
                        ),
                        child: Text(
                          period.kind == PeriodKind.all
                              ? l.historyEmpty
                              : l.historyEmptyPeriod,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: context.colors.textTertiary,
                          ),
                        ),
                      ),
                    for (final g in groups)
                      _DayGroupView(
                        label: g.day == null
                            ? l.historyNoDate
                            : formatDayLabel(g.day!, now),
                        total: formatMoney(g.successAmount),
                        group: g,
                      ),
                    if (data != null && data.moreError != null) ...[
                      RetryBanner(
                        text: apiErrorText(data.moreError!, l),
                        retryLabel: l.retry,
                        onRetry: () => ref
                            .read(historyControllerProvider.notifier)
                            .loadMore(),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (data != null && data.feed.hasMore)
                      _LoadMoreButton(
                        label: data.loadingMore
                            ? l.historyLoadingMore
                            : l.historyLoadMore(data.feed.remaining),
                        onTap: data.loadingMore
                            ? null
                            : () => ref
                                  .read(historyControllerProvider.notifier)
                                  .loadMore(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayGroupView extends StatelessWidget {
  const _DayGroupView({
    required this.label,
    required this.total,
    required this.group,
  });

  final String label;
  final String total;
  final DayGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 6, 2, 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  total,
                  style: AppTextStyles.monoCaption.copyWith(
                    color: context.colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          for (final p in group.payments) ...[
            const SizedBox(height: 8),
            HistoryRow(
              payment: p,
              onTap: () => context.push(Routes.payment, extra: p),
            ),
          ],
        ],
      ),
    );
  }
}

class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      radius: AppDimens.radiusRow,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderColor: context.colors.borderList,
      pressedColor: context.colors.disabledBg,
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: context.colors.textPrimary),
          ),
        ),
      ),
    );
  }
}
