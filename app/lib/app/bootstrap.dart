import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/storage/preferences.dart';
import 'app.dart';
import 'env.dart';

/// Riverpod 3 по умолчанию сам повторяет упавшие запросы, и всё это время
/// экран «грузится» — ошибку и «Повторить» мерчант не видит. Отключаем:
/// ошибка показывается сразу, повтор — кнопкой или жестом «потянуть».
Duration? noRetry(int retryCount, Object error) => null;

/// Общий запуск для обоих flavors.
Future<void> bootstrap(Env env) async {
  WidgetsFlutterBinding.ensureInitialized();
  // До первого кадра: тема из настроек применяется сразу.
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      retry: noRetry,
      overrides: [
        envProvider.overrideWithValue(env),
        preferencesProvider.overrideWithValue(prefs),
      ],
      child: const ActivBankApp(),
    ),
  );
}
