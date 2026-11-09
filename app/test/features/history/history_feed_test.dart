import 'package:activbank_qr/features/history/domain/history_feed.dart';
import 'package:activbank_qr/features/payment/domain/payment.dart';
import 'package:flutter_test/flutter_test.dart';

Payment pay(
  double amount, {
  DateTime? at,
  PaymentStatus status = PaymentStatus.success,
}) => Payment(sender: 'Банк', amount: amount, status: status, createdAt: at);

/// Серверный список от новых к старым: платёж с номером n стоит n-м с конца.
List<Payment> server(int total) => [
  for (var i = total; i >= 1; i--) pay(i.toDouble()),
];

HistoryPage pageOf(List<Payment> all, int offset, [int limit = 3]) =>
    HistoryPage(
      total: all.length,
      offset: offset,
      payments: all.skip(offset).take(limit).toList(),
    );

List<double> amounts(HistoryFeed f) => [for (final p in f.payments) p.amount];

void main() {
  group('HistoryFeed', () {
    test('страницы склеиваются по offset += limit', () {
      final all = server(7);
      var feed = HistoryFeed.first(pageOf(all, 0));
      expect(feed.nextOffset, 3);
      expect(feed.remaining, 4);

      feed = feed.append(pageOf(all, feed.nextOffset));
      feed = feed.append(pageOf(all, feed.nextOffset));

      expect(amounts(feed), [7, 6, 5, 4, 3, 2, 1]);
      expect(feed.hasMore, isFalse);
      expect(feed.remaining, 0);
    });

    test('новые платежи между страницами не дают дублей', () {
      var all = server(7);
      var feed = HistoryFeed.first(pageOf(all, 0)); // 7, 6, 5

      // Пришли два новых платежа — старые сдвинулись на 2 вниз.
      all = [pay(9), pay(8), ...all];
      feed = feed.append(pageOf(all, feed.nextOffset)); // сервер: 6, 5, 4
      expect(amounts(feed), [7, 6, 5, 4]);
      expect(feed.remaining, 3);

      feed = feed.append(pageOf(all, feed.nextOffset)); // 3, 2, 1
      expect(amounts(feed), [7, 6, 5, 4, 3, 2, 1]);
      expect(feed.hasMore, isFalse);
    });

    test('пустая история', () {
      final feed = HistoryFeed.first(
        const HistoryPage(total: 0, offset: 0, payments: []),
      );
      expect(feed.payments, isEmpty);
      expect(feed.hasMore, isFalse);
    });
  });

  group('groupByDay', () {
    test('группы по дням, сумма только оплаченных', () {
      final groups = groupByDay([
        pay(100, at: DateTime(2026, 9, 8, 14, 12)),
        pay(50, at: DateTime(2026, 9, 8, 13), status: PaymentStatus.cancel),
        pay(0.1, at: DateTime(2026, 9, 8, 12)),
        pay(0.2, at: DateTime(2026, 9, 8, 11)),
        pay(30, at: DateTime(2026, 9, 7, 23, 59)),
      ]);

      expect(groups.map((g) => g.day), [
        DateTime(2026, 9, 8),
        DateTime(2026, 9, 7),
      ]);
      expect(groups[0].payments, hasLength(4));
      // 100 + 0,1 + 0,2 без хвостов double; отклонённые не считаются.
      expect(groups[0].successAmount, 100.3);
      expect(groups[1].successAmount, 30);
    });

    test('битая дата — отдельная группа в конце', () {
      final groups = groupByDay([pay(1), pay(2, at: DateTime(2026, 9, 8))]);
      expect(groups.map((g) => g.day), [DateTime(2026, 9, 8), null]);
      expect(groups.last.payments.single.amount, 1);
    });
  });
}
