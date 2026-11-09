import 'package:activbank_qr/features/history/domain/history_period.dart';
import 'package:activbank_qr/features/history/domain/history_report.dart';
import 'package:activbank_qr/features/payment/domain/payment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Вечер 23 октября: время суток не должно влиять на дни.
  final now = DateTime(2026, 10, 23, 21, 40);

  DateRange? range(PeriodKind k, [DateTime? at]) =>
      HistoryPeriod(k).range(at ?? now);

  group('HistoryPeriod.range', () {
    test('всё время — без дат', () {
      expect(range(PeriodKind.all), isNull);
    });

    test('сегодня и вчера — один день', () {
      expect(
        range(PeriodKind.today),
        DateRange(DateTime(2026, 10, 23), DateTime(2026, 10, 23)),
      );
      expect(
        range(PeriodKind.yesterday),
        DateRange(DateTime(2026, 10, 22), DateTime(2026, 10, 22)),
      );
      expect(range(PeriodKind.today)!.isSingleDay, isTrue);
    });

    test('7 дней — включая сегодня', () {
      final r = range(PeriodKind.week)!;
      expect(r.from, DateTime(2026, 10, 17));
      expect(r.to, DateTime(2026, 10, 23));
      expect(r.days, 7);
    });

    test('этот месяц — с 1-го по сегодня', () {
      expect(
        range(PeriodKind.month),
        DateRange(DateTime(2026, 10), DateTime(2026, 10, 23)),
      );
    });

    test('прошлый месяц — целиком, и через границу года', () {
      expect(
        range(PeriodKind.lastMonth),
        DateRange(DateTime(2026, 9), DateTime(2026, 9, 30)),
      );
      expect(
        range(PeriodKind.lastMonth, DateTime(2027, 1, 5)),
        DateRange(DateTime(2026, 12), DateTime(2026, 12, 31)),
      );
      // Февраль високосного года.
      expect(range(PeriodKind.lastMonth, DateTime(2028, 3, 1))!.days, 29);
    });

    test('свой период — как выбрали', () {
      final r = DateRange(DateTime(2026, 9, 10), DateTime(2026, 10, 10));
      expect(HistoryPeriod.custom(r).range(now), r);
    });
  });

  group('DateRange', () {
    test('перепутанные концы и время суток выравниваются', () {
      final r = DateRange(DateTime(2026, 10, 10, 15), DateTime(2026, 9, 10));
      expect(r.from, DateTime(2026, 9, 10));
      expect(r.to, DateTime(2026, 10, 10));
      expect(r.days, 31);
    });

    test('год — 365 дней, проходит лимит отчёта', () {
      final r = DateRange(DateTime(2025, 10, 24), DateTime(2026, 10, 23));
      expect(r.days, 365);
      expect(r.days <= maxReportDays, isTrue);
    });
  });

  group('формат периода', () {
    final r = DateRange(DateTime(2026, 9, 10), DateTime(2026, 10, 10));

    test('полный — для PDF', () {
      expect(formatRange(r), '10.09.2026 – 10.10.2026');
      expect(
        formatRange(DateRange(DateTime(2026, 9, 8), DateTime(2026, 9, 8))),
        '08.09.2026',
      );
    });

    test('короткий — для чипа, год только если не текущий', () {
      expect(formatRangeShort(r, now), '10.09 – 10.10');
      final old = DateRange(DateTime(2025, 12, 1), DateTime(2026, 1, 1));
      expect(formatRangeShort(old, now), '01.12.2025 – 01.01.2026');
    });
  });

  test('итоги отчёта по статусам — в дирамах без ошибки double', () {
    Payment p(double amount, PaymentStatus s) =>
        Payment(sender: 'Б', amount: amount, status: s, createdAt: null);
    final report = HistoryReport(
      range: DateRange(now, now),
      payments: [
        p(0.1, PaymentStatus.success),
        p(0.2, PaymentStatus.success),
        p(20, PaymentStatus.cancel),
        p(5, PaymentStatus.refunded),
        p(7, PaymentStatus.refundPending),
        p(99, PaymentStatus.pending),
      ],
      storeName: '',
      terminalName: '',
      terminalId: '',
      generatedAt: now,
    );
    expect(report.success.count, 2);
    expect(report.success.amount, 0.3);
    expect(report.cancel.count, 1);
    expect(report.cancel.amount, 20);
    expect(report.refunded.count, 2);
    expect(report.refunded.amount, 12);
  });
}
