import 'package:activbank_qr/core/utils/date_format.dart';
import 'package:activbank_qr/core/utils/money_format.dart';
import 'package:activbank_qr/core/utils/phone_format.dart';
import 'package:activbank_qr/core/utils/plural.dart';
import 'package:flutter_test/flutter_test.dart';

const nbsp = ' ';

void main() {
  group('formatMoney', () {
    test('целые и дробные', () {
      expect(formatMoney(0), '0,00');
      expect(formatMoney(150), '150,00');
      expect(formatMoney(795.5), '795,50');
      expect(formatMoney(0.07), '0,07');
    });

    test('разделитель тысяч — неразрывный пробел', () {
      expect(formatMoney(1000), '1${nbsp}000,00');
      expect(formatMoney(12345.6), '12${nbsp}345,60');
      expect(formatMoney(1234567.89), '1${nbsp}234${nbsp}567,89');
    });

    test('округление до дирамов без «1,100»', () {
      expect(formatMoney(1.999), '2,00');
      expect(formatMoney(0.005), '0,01');
      expect(formatMoney(19.99), '19,99');
    });

    test('отрицательные', () {
      expect(formatMoney(-60), '−60,00');
    });
  });

  group('plural', () {
    test('склонение', () {
      expect(paymentsCount(0), '0 платежей');
      expect(paymentsCount(1), '1 платёж');
      expect(paymentsCount(2), '2 платежа');
      expect(paymentsCount(4), '4 платежа');
      expect(paymentsCount(5), '5 платежей');
      expect(paymentsCount(11), '11 платежей');
      expect(paymentsCount(14), '14 платежей');
      expect(paymentsCount(21), '21 платёж');
      expect(paymentsCount(22), '22 платежа');
      expect(paymentsCount(111), '111 платежей');
      expect(paymentsCount(101), '101 платёж');
    });
  });

  group('даты', () {
    final now = DateTime(2026, 9, 8, 10, 30);

    test('время и дата', () {
      expect(formatTime(DateTime(2026, 9, 8, 4, 5)), '04:05');
      expect(formatDayMonth(DateTime(2026, 1, 3)), '03.01');
      expect(formatFullDate(DateTime(2026, 1, 3)), '03.01.2026');
      expect(formatIsoDate(DateTime(2026, 9, 8, 23, 59)), '2026-09-08');
    });

    test('заголовок дня', () {
      expect(formatDayLabel(DateTime(2026, 9, 8, 0, 1), now), 'Сегодня');
      expect(formatDayLabel(DateTime(2026, 9, 7, 23, 59), now), 'Вчера');
      expect(formatDayLabel(DateTime(2026, 9, 6, 12), now), '6 сентября');
      expect(formatDayLabel(DateTime(2026, 5, 1), now), '1 мая');
    });

    test('переход через год', () {
      expect(
        formatDayLabel(DateTime(2025, 12, 31), DateTime(2026, 1, 1)),
        'Вчера',
      );
    });
  });

  group('телефон', () {
    test('маска', () {
      expect(formatPhoneMask(''), '·· ··· ·· ··');
      expect(formatPhoneMask('9312'), '93 12· ·· ··');
      expect(formatPhoneMask('931234567'), '93 123 45 67');
    });

    test('скрытый и полный номер', () {
      expect(formatPhoneHidden('931234567'), '+992 93 ··· 67');
      expect(fullPhone('931234567'), '+992931234567');
    });
  });
}
