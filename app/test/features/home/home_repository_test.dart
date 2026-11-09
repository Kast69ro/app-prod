import 'package:activbank_qr/core/api/api_exception.dart';
import 'package:activbank_qr/core/widgets/qr_code_view.dart';
import 'package:activbank_qr/features/home/data/home_repository.dart';
import 'package:activbank_qr/features/home/domain/home_models.dart';
import 'package:activbank_qr/features/payment/data/payment_dto.dart';
import 'package:activbank_qr/features/payment/domain/payment.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http.dart';

void main() {
  group('HomeRepository.getTerminal', () {
    test('данные точки и последний платёж', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'terminal': {
            'terminalName': 'Магазин на Рудаки',
            'terminalPhone': '+992931234567',
            'storeName': 'ООО Ромашка',
            'terminalQR': '00020101021226',
          },
          'last_payment': {
            'sender': 'Душанбе Сити Банк',
            'sender_bank_id': 27,
            'amount': 150.00,
            'status': 'success',
            'creation_datetime': '2026-09-08T14:12:00',
          },
        }),
        phone: '+992931234567',
      );

      final info = await HomeRepository(t.client).getTerminal();

      expect(t.adapter.last!.path, '/pos/terminal');
      expect(t.adapter.last!.queryParameters, {'phone': '+992931234567'});
      expect(info.terminalName, 'Магазин на Рудаки');
      expect(info.terminalQR, '00020101021226');
      expect(
        info.lastPayment,
        Payment(
          sender: 'Душанбе Сити Банк',
          senderBankId: 27,
          amount: 150,
          status: PaymentStatus.success,
          createdAt: DateTime(2026, 9, 8, 14, 12),
        ),
      );
    });

    test('платежей ещё не было', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'terminal': {'terminalName': 'Т', 'terminalQR': 'x'},
          'last_payment': null,
        }),
      );
      final info = await HomeRepository(t.client).getTerminal();
      expect(info.lastPayment, isNull);
      expect(info.storeName, '');
    });

    test('нет блока terminal → badResponse', () async {
      final t = fakeApi((_) async => jsonBody(200, {'last_payment': null}));
      await expectLater(
        HomeRepository(t.client).getTerminal(),
        throwsA(
          isA<ApiException>().having(
            (e) => e.kind,
            'kind',
            ApiErrorKind.badResponse,
          ),
        ),
      );
    });
  });

  group('HomeRepository.getSummary', () {
    test('дата в запросе, блоки success / cancel', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'date': '2026-09-08',
          'success': {'count': 21, 'amount': 795.00},
          'cancel': {'count': 2, 'amount': 60},
          'currency': 'TJS',
        }),
      );

      final s = await HomeRepository(t.client)
          .getSummary(DateTime(2026, 9, 8, 23, 59));

      expect(t.adapter.last!.queryParameters['date'], '2026-09-08');
      expect(s.success, const Totals(count: 21, amount: 795));
      expect(s.cancel, const Totals(count: 2, amount: 60));
      expect(s.refunded, isNull);
    });

    test('блок refunded, когда бэк его добавит', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'success': {'count': 1, 'amount': 10},
          'cancel': {'count': 0, 'amount': 0},
          'refunded': {'count': 3, 'amount': 125.5},
        }),
      );
      final s = await HomeRepository(t.client).getSummary(DateTime(2026));
      expect(s.refunded, const Totals(count: 3, amount: 125.5));
    });
  });

  group('PaymentStatus / PaymentDto', () {
    test('статусы бэка', () {
      expect(PaymentStatus.parse('success'), PaymentStatus.success);
      expect(PaymentStatus.parse('SUCCESS'), PaymentStatus.success);
      expect(PaymentStatus.parse('cancel'), PaymentStatus.cancel);
      expect(PaymentStatus.parse('refunded'), PaymentStatus.refunded);
      expect(
        PaymentStatus.parse('refund_pending'),
        PaymentStatus.refundPending,
      );
    });

    test('незнакомый статус — не «Оплачено»', () {
      expect(PaymentStatus.parse('weird'), PaymentStatus.unknown);
      expect(PaymentStatus.parse(null), PaymentStatus.unknown);
    });

    test('пустой банк и битая дата', () {
      final p = const PaymentDto(
        sender: '  ',
        amount: 5,
        creationDatetime: 'вчера',
      ).toDomain();
      expect(p.sender, '—');
      expect(p.createdAt, isNull);
    });
  });

  group('QrBuild', () {
    test('обычная строка строится', () {
      final b = QrBuild.from('00020101021126360014tj.nbt.qr0114992931234567');
      expect(b.error, isNull);
      expect(b.code!.moduleCount, greaterThan(20));
    });

    test('кириллица (UTF-8) строится', () {
      expect(QrBuild.from('Магазин на Рудаки').code, isNotNull);
    });

    test('слишком длинная строка — ошибка tooLong', () {
      final b = QrBuild.from('x' * 3000);
      expect(b.code, isNull);
      expect(b.error, QrBuildError.tooLong);
    });
  });
}
