import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env.g.dart';

enum Flavor { dev, prod }

/// Настройки сборки. Адрес сервера берётся только отсюда.
class Env {
  const Env({
    required this.flavor,
    required this.apiBaseUrl,
    this.connectTimeout = const Duration(seconds: 8),
    this.receiveTimeout = const Duration(seconds: 15),
  });

  final Flavor flavor;
  final String apiBaseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  bool get isDev => flavor == Flavor.dev;

  /// Тестовый сервер во внутренней сети банка. http — только в dev.
  static const dev = Env(
    flavor: Flavor.dev,
    apiBaseUrl: 'http://10.64.20.101:8888',
  );

  /// TODO(prod): HTTPS-домен шлюза в DMZ — уточнить у банка.
  /// Пока пусто: ApiClient отказывает во всех запросах (fail-closed).
  static const prod = Env(flavor: Flavor.prod, apiBaseUrl: '');
}

/// Переопределяется в `main_dev.dart` / `main_prod.dart`.
@Riverpod(keepAlive: true)
Env env(Ref ref) => throw UnimplementedError('envProvider не переопределён');
