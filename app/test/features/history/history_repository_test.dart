import 'package:activbank_qr/core/api/api_exception.dart';
import 'package:activbank_qr/features/history/data/history_repository.dart';
import 'package:activbank_qr/features/history/domain/history_period.dart';
import 'package:activbank_qr/features/payment/domain/payment.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http.dart';

void main() {
  group('HistoryRepository.getPage', () {
    test('limit и offset в запросе, платежи и total', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'terminal': {'terminalName': 'Т'},
          'total': 137,
          'limit': 50,
          'offset': 50,
          'count': 2,
          'payments': [
            {
              'sender': 'Душанбе Сити Банк',
              'sender_bank_id': 27,
              'amount': 150.00,
              'status': 'success',
              'creation_datetime': '2026-09-08T14:12:00',
            },
            {
              'sender': 'Алиф',
              'amount': 20,
              'status': 'cancel',
              'creation_datetime': '2026-09-08T13:00:00',
            },
          ],
        }),
        phone: '+992931234567',
      );

      final page = await HistoryRepository(t.client).getPage(offset: 50);

      expect(t.adapter.last!.path, '/pos/history');
      expect(t.adapter.last!.queryParameters, {
        'limit': 50,
        'offset': 50,
        'phone': '+992931234567',
      });
      expect(page.total, 137);
      expect(page.offset, 50);
      expect(page.payments, [
        Payment(
          sender: 'Душанбе Сити Банк',
          senderBankId: 27,
          amount: 150,
          status: PaymentStatus.success,
          createdAt: DateTime(2026, 9, 8, 14, 12),
        ),
        Payment(
          sender: 'Алиф',
          amount: 20,
          status: PaymentStatus.cancel,
          createdAt: DateTime(2026, 9, 8, 13),
        ),
      ]);
    });

    test('type: internal — клиент ActivBank, без type — межбанк', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {
          'total': 3,
          'payments': [
            {
              'type': 'internal',
              'sender': 'КУРБОНОВ Мухаммадшариф',
              'sender_bank_id': null,
              'amount': 44.55,
              'status': 'success',
              'creation_datetime': '2026-10-30T14:12:00',
            },
            {
              'type': 'external',
              'sender': 'Душанбе Сити Банк',
              'sender_bank_id': 27,
              'amount': 150,
              'status': 'success',
              'creation_datetime': '2026-10-30T14:10:00',
            },
            {
              'sender': 'Алиф',
              'amount': 20,
              'status': 'success',
              'creation_datetime': '2026-10-30T14:00:00',
            },
          ],
        }),
      );

      final page = await HistoryRepository(t.client).getPage(offset: 0);

      expect(page.payments.map((p) => p.type), [
        PaymentType.internal,
        PaymentType.external,
        PaymentType.external,
      ]);
      expect(page.payments.first.isInternal, isTrue);
      expect(page.payments.first.sender, 'КУРБОНОВ Мухаммадшариф');
    });

    test('пустая история', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {'total': 0, 'count': 0, 'payments': []}),
      );
      final page = await HistoryRepository(t.client).getPage(offset: 0);
      expect(page.total, 0);
      expect(page.payments, isEmpty);
    });

    test('payments не список → badResponse', () async {
      final t = fakeApi(
        (_) async => jsonBody(200, {'total': 1, 'payments': 'нет'}),
      );
      await expectLater(
        HistoryRepository(t.client).getPage(offset: 0),
        throwsA(
          isA<ApiException>().having(
            (e) => e.kind,
            'kind',
            ApiErrorKind.badResponse,
          ),
        ),
      );
    });

    test('ошибка бэка с detail', () async {
      final t = fakeApi(
        (_) async => jsonBody(404, {'detail': 'Терминал не найден'}),
      );
      await expectLater(
        HistoryRepository(t.client).getPage(offset: 0),
        throwsA(
          isA<ApiException>().having(
            (e) => e.detail,
            'detail',
            'Терминал не найден',
          ),
        ),
      );
    });
  });

  group('HistoryRepository: период', () {
    Map<String, Object?> empty(_) => {'total': 0, 'payments': []};

    test('один день — параметр date', () async {
      final t = fakeApi((o) async => jsonBody(200, empty(o)));
      final day = DateTime(2026, 10, 23);
      await HistoryRepository(t.client)
          .getPage(offset: 0, range: DateRange(day, day));
      expect(t.adapter.last!.queryParameters, {
        'date': '2026-10-23',
        'limit': 50,
        'offset': 0,
      });
    });

    test('период — from и to, без date', () async {
      final t = fakeApi((o) async => jsonBody(200, empty(o)));
      await HistoryRepository(t.client).getPage(
        offset: 50,
        range: DateRange(DateTime(2026, 9, 10), DateTime(2026, 10, 10)),
      );
      expect(t.adapter.last!.queryParameters, {
        'from': '2026-09-10',
        'to': '2026-10-10',
        'limit': 50,
        'offset': 50,
      });
    });
  });

  group('HistoryRepository.getAll', () {
    final range = DateRange(DateTime(2026, 9, 1), DateTime(2026, 9, 30));

    Map<String, Object?> pay(int i) => {
      'sender': 'Банк $i',
      'amount': i,
      'status': 'success',
      'creation_datetime': '2026-09-08T14:12:00',
    };

    test('выкачивает все страницы по 200', () async {
      final all = [for (var i = 0; i < 450; i++) pay(i)];
      final queries = <Map<String, dynamic>>[];
      final t = fakeApi((o) async {
        queries.add(o.queryParameters);
        final offset = o.queryParameters['offset'] as int;
        final limit = o.queryParameters['limit'] as int;
        return jsonBody(200, {
          'total': all.length,
          'payments': all.skip(offset).take(limit).toList(),
        });
      });

      final payments = await HistoryRepository(t.client).getAll(range);

      expect(payments, hasLength(450));
      expect(payments.last.sender, 'Банк 449');
      expect([for (final q in queries) q['offset']], [0, 200, 400]);
      expect(queries.every((q) => q['limit'] == 200), isTrue);
      expect(queries.first['from'], '2026-09-01');
      expect(queries.first['to'], '2026-09-30');
    });

    test('новый платёж во время выгрузки — без дублей', () async {
      var all = [for (var i = 1; i <= 300; i++) pay(i)];
      var calls = 0;
      final t = fakeApi((o) async {
        // После первой страницы в начало пришёл новый платёж.
        if (calls++ == 1) all = [pay(0), ...all];
        final offset = o.queryParameters['offset'] as int;
        return jsonBody(200, {
          'total': all.length,
          'payments': all.skip(offset).take(200).toList(),
        });
      });

      final payments = await HistoryRepository(t.client).getAll(range);

      expect(payments, hasLength(300));
      expect(payments.map((p) => p.sender).toSet(), hasLength(300));
    });

    test('бэк обещал ещё, но прислал пусто — не зацикливается', () async {
      var calls = 0;
      final t = fakeApi((o) async {
        calls++;
        final first = o.queryParameters['offset'] == 0;
        return jsonBody(200, {
          'total': 500,
          'payments': first ? [pay(1)] : [],
        });
      });

      final payments = await HistoryRepository(t.client).getAll(range);

      expect(payments, hasLength(1));
      expect(calls, 2);
    });
  });
}
