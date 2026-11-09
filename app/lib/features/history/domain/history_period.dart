import 'package:flutter/foundation.dart';

import '../../../core/utils/date_format.dart';

/// Календарные дни с [from] по [to] включительно — как `from`/`to` в API.
@immutable
class DateRange {
  DateRange(DateTime from, DateTime to)
    : from = dayKey(from.isAfter(to) ? to : from),
      to = dayKey(from.isAfter(to) ? from : to);

  final DateTime from;
  final DateTime to;

  bool get isSingleDay => from == to;

  /// Сколько дней в периоде. UTC — чтобы летнее время не съело сутки.
  int get days =>
      DateTime.utc(
        to.year,
        to.month,
        to.day,
      ).difference(DateTime.utc(from.year, from.month, from.day)).inDays +
      1;

  @override
  bool operator ==(Object other) =>
      other is DateRange && other.from == from && other.to == to;

  @override
  int get hashCode => Object.hash(from, to);
}

enum PeriodKind { all, today, yesterday, week, month, lastMonth, custom }

/// Фильтр истории. Хранится вид периода, а не даты: «Сегодня»,
/// выбранное вчера вечером, после полуночи означает уже новый день.
@immutable
class HistoryPeriod {
  const HistoryPeriod(this.kind) : custom = null;

  const HistoryPeriod.custom(DateRange this.custom) : kind = PeriodKind.custom;

  static const all = HistoryPeriod(PeriodKind.all);

  final PeriodKind kind;

  /// Даты своего периода — только для [PeriodKind.custom].
  final DateRange? custom;

  /// Дни периода на момент [now]; `null` — вся история.
  DateRange? range(DateTime now) {
    final today = dayKey(now);
    DateTime day(int shift) => DateTime(now.year, now.month, now.day + shift);
    return switch (kind) {
      PeriodKind.all => null,
      PeriodKind.today => DateRange(today, today),
      PeriodKind.yesterday => DateRange(day(-1), day(-1)),
      PeriodKind.week => DateRange(day(-6), today),
      PeriodKind.month => DateRange(DateTime(now.year, now.month), today),
      // День 0 — последний день предыдущего месяца.
      PeriodKind.lastMonth => DateRange(
        DateTime(now.year, now.month - 1),
        DateTime(now.year, now.month, 0),
      ),
      PeriodKind.custom => custom,
    };
  }

  @override
  bool operator ==(Object other) =>
      other is HistoryPeriod && other.kind == kind && other.custom == custom;

  @override
  int get hashCode => Object.hash(kind, custom);
}

/// Отчёт в PDF — не больше чем за год: иначе тысячи страниц.
const maxReportDays = 366;

/// `08.09.2026` или `10.09.2026 – 10.10.2026`.
String formatRange(DateRange r) => r.isSingleDay
    ? formatFullDate(r.from)
    : '${formatFullDate(r.from)} – ${formatFullDate(r.to)}';

/// Короче для чипа: `10.09 – 10.10`; год — если период не в [now].year.
String formatRangeShort(DateRange r, DateTime now) {
  final sameYear = r.from.year == now.year && r.to.year == now.year;
  if (!sameYear) return formatRange(r);
  return r.isSingleDay
      ? formatDayMonth(r.from)
      : '${formatDayMonth(r.from)} – ${formatDayMonth(r.to)}';
}
