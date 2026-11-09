import 'dart:async';

import 'package:activbank_qr/app/app.dart';
import 'package:activbank_qr/app/bootstrap.dart';
import 'package:activbank_qr/core/api/api_providers.dart';
import 'package:activbank_qr/core/security/pin_hasher.dart';
import 'package:activbank_qr/core/storage/preferences.dart';
import 'package:activbank_qr/core/storage/secure_store.dart';
import 'package:activbank_qr/features/auth/data/sms_code_reader.dart';
import 'package:activbank_qr/features/pin/data/pin_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_http.dart';

/// Ненастоящий бэк для виджет-тестов: ответы по пути запроса.
class FakeBackend {
  int verifyStatus = 200;
  bool terminalFails = false;
  bool historyFails = false;

  /// Платежи для `/pos/history`, от новых к старым. Отдаются постранично.
  List<Map<String, Object?>> history = [];
  final requests = <String>[];

  /// Параметры запросов `/pos/history` — проверять фильтр периода.
  final historyQueries = <Map<String, dynamic>>[];

  Future<ResponseBody> respond(RequestOptions o) async {
    requests.add(o.path);
    if (o.path == '/pos/history') historyQueries.add(o.queryParameters);
    switch (o.path) {
      case '/pos/otp/request':
        return jsonBody(200, {'ok': true, 'expires_in': 300});
      case '/pos/otp/verify':
        if (verifyStatus != 200) {
          return jsonBody(verifyStatus, {'detail': 'Осталось попыток: 4'});
        }
        return jsonBody(200, {
          'ok': true,
          'terminalId': 12345,
          'terminalName': 'Магазин на Рудаки',
          'storeName': 'ООО Ромашка',
        });
      case '/pos/terminal':
        if (terminalFails) {
          throw DioException.connectionError(requestOptions: o, reason: 'x');
        }
        return jsonBody(200, {
          'terminal': {
            'terminalName': 'Магазин на Рудаки',
            'terminalPhone': '+992931234567',
            'storeName': 'ООО Ромашка',
            'terminalQR': '00020101021126360014tj.nbt.qr0114992931234567',
          },
          'last_payment': {
            'sender': 'Душанбе Сити Банк',
            'amount': 150,
            'status': 'success',
            'creation_datetime': '2026-09-08T14:12:00',
          },
        });
      case '/pos/summary':
        return jsonBody(200, {
          'success': {'count': 21, 'amount': 795},
          'cancel': {'count': 2, 'amount': 60},
        });
      case '/pos/history':
        if (historyFails) {
          throw DioException.connectionError(requestOptions: o, reason: 'x');
        }
        final offset = int.parse('${o.queryParameters['offset'] ?? 0}');
        final limit = int.parse('${o.queryParameters['limit'] ?? 50}');
        final page = history.skip(offset).take(limit).toList();
        return jsonBody(200, {
          'total': history.length,
          'limit': limit,
          'offset': offset,
          'count': page.length,
          'payments': page,
        });
    }
    return jsonBody(404, {'detail': 'Not Found'});
  }
}

/// SMS «приходит», когда тест вызовет [deliver].
class FakeSmsCodeReader implements SmsCodeReader {
  Completer<String?>? _pending;
  int listens = 0;
  int cancels = 0;

  bool get listening => _pending != null;

  @override
  Future<String?> listen(int length) {
    listens++;
    return (_pending = Completer<String?>()).future;
  }

  @override
  Future<void> cancel() async {
    cancels++;
    _pending?.complete(null);
    _pending = null;
  }

  void deliver(String? code) {
    _pending?.complete(code);
    _pending = null;
  }
}

/// Приложение с памятью вместо хранилища и ненастоящим бэком.
/// По умолчанию — маленький экран (320×568) и шрифт 1,3×.
/// [prefs] — обычные настройки (тема); `null` — оставить прежние,
/// чтобы повторный вызов имитировал перезапуск приложения.
Future<MemorySecureStore> pumpTestApp(
  WidgetTester tester,
  FakeBackend backend, {
  MemorySecureStore? store,
  Size size = const Size(320, 568),
  double textScale = 1.3,
  FakeSmsCodeReader? sms,
  List<Override> overrides = const [],
  Map<String, Object>? prefs = const {},
}) async {
  if (prefs != null) SharedPreferences.setMockInitialValues(prefs);
  final sharedPrefs = await SharedPreferences.getInstance();
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

  final mem = store ?? MemorySecureStore();
  await tester.pumpWidget(
    ProviderScope(
      // Новый ключ — новый контейнер: имитирует перезапуск приложения.
      key: UniqueKey(),
      retry: noRetry,
      overrides: [
        secureStoreProvider.overrideWithValue(mem),
        preferencesProvider.overrideWithValue(sharedPrefs),
        smsCodeReaderProvider.overrideWithValue(sms ?? FakeSmsCodeReader()),
        pinRepositoryProvider.overrideWithValue(
          PinRepository(mem, hasher: const PinHasher(iterations: 10)),
        ),
        apiClientProvider.overrideWith(
          (ref) => fakeApi(
            backend.respond,
            readPhone: () => ref.read(authCredentialsProvider),
          ).client,
        ),
        ...overrides,
      ],
      child: const ActivBankApp(),
    ),
  );
  await tester.pumpAndSettle();
  return mem;
}

/// Набор цифр по одной с системной клавиатуры — в поле, где сейчас фокус.
Future<void> typeDigits(WidgetTester tester, String digits) async {
  final field = find.byWidgetPredicate(
    (w) => w is EditableText && w.focusNode.hasFocus,
  );
  for (final d in digits.split('')) {
    final text = tester.widget<EditableText>(field).controller.text;
    await tester.enterText(field, text + d);
    await tester.pump();
  }
}

/// Хеширование кода идёт в изоляте — ему нужно настоящее время.
Future<void> settleWithIsolate(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 200));
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 500)),
  );
  await tester.pumpAndSettle();
}

/// Вход по OTP и создание кода 1234 — до главной.
Future<void> signIn(WidgetTester tester) async {
  await typeDigits(tester, '931234567');
  await tester.tap(find.text('Получить код'));
  await tester.pumpAndSettle(const Duration(milliseconds: 100));
  await typeDigits(tester, '123456');
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
  await typeDigits(tester, '1234');
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pumpAndSettle();
  await typeDigits(tester, '1234');
  await settleWithIsolate(tester);
}
