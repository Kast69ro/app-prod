import 'package:flutter/foundation.dart';

import '../../../core/utils/date_format.dart';
import '../../payment/domain/payment.dart';

/// Одна страница `GET /pos/history`.
@immutable
class HistoryPage {
  const HistoryPage({
    required this.total,
    required this.offset,
    required this.payments,
  });

  /// Всего записей на сервере в момент запроса.
  final int total;
  final int offset;
  final List<Payment> payments;
}

/// Загруженная часть истории.
///
/// Новые платежи приходят в начало списка на сервере и сдвигают старые
/// вниз. Без поправки следующая страница начиналась бы с уже показанных
/// строк. Поэтому следим, насколько вырос `total`, и сдвигаем `offset`.
@immutable
class HistoryFeed {
  const HistoryFeed._(this.payments, this._total, this._shift);

  factory HistoryFeed.first(HistoryPage page) =>
      HistoryFeed._(List.unmodifiable(page.payments), page.total, 0);

  final List<Payment> payments;

  /// `total` из последнего ответа.
  final int _total;

  /// Сколько новых платежей пришло с первой страницы (они не показаны).
  final int _shift;

  /// `offset` для следующей страницы.
  int get nextOffset => payments.length + _shift;

  /// Сколько старых платежей ещё не загружено.
  int get remaining => (_total - nextOffset).clamp(0, _total);

  bool get hasMore => remaining > 0;

  /// Добавляет следующую страницу, запрошенную с [nextOffset].
  HistoryFeed append(HistoryPage page) {
    final grown = page.total > _total ? page.total - _total : 0;
    // Первые `grown` строк ответа — те, что мы уже показали.
    final fresh = page.payments.skip(grown);
    return HistoryFeed._(
      List.unmodifiable([...payments, ...fresh]),
      page.total,
      _shift + grown,
    );
  }
}

/// Платежи одного дня. [day] == `null` — бэк прислал битую дату.
@immutable
class DayGroup {
  const DayGroup({
    required this.day,
    required this.payments,
    required this.successAmount,
  });

  final DateTime? day;
  final List<Payment> payments;

  /// Сумма оплаченных среди загруженных — как в прототипе.
  final double successAmount;
}

/// Группы по календарным дням в порядке списка; без даты — в конце.
List<DayGroup> groupByDay(List<Payment> payments) {
  // Map хранит ключи в порядке добавления — порядок дней как в списке.
  final byDay = <DateTime, List<Payment>>{};
  final noDate = <Payment>[];
  for (final p in payments) {
    final d = p.createdAt;
    if (d == null) {
      noDate.add(p);
    } else {
      (byDay[dayKey(d)] ??= []).add(p);
    }
  }
  return [
    for (final e in byDay.entries) _group(e.key, e.value),
    if (noDate.isNotEmpty) _group(null, noDate),
  ];
}

DayGroup _group(DateTime? day, List<Payment> list) {
  // Суммируем в дирамах, чтобы не копить ошибку double.
  var cents = 0;
  for (final p in list) {
    if (p.status == PaymentStatus.success) cents += (p.amount * 100).round();
  }
  return DayGroup(
    day: day,
    payments: List.unmodifiable(list),
    successAmount: cents / 100,
  );
}
