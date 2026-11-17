import 'package:activbank_qr/app/env.dart';
import 'package:activbank_qr/core/api/api_paths.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Полный адрес запроса так, как его соберёт dio.
String url(Env env, String path) =>
    RequestOptions(baseUrl: env.apiBaseUrl, path: path).uri.toString();

void main() {
  test('dev: тестовый сервер', () {
    expect(
      url(Env.dev, ApiPaths.otpRequest),
      'http://10.64.20.101:8888/mobi/otp/request',
    );
    expect(
      url(Env.dev, ApiPaths.history),
      'http://10.64.20.101:8888/mobi/history',
    );
  });

  test('prod: шлюз, только https', () {
    expect(Env.prod.apiBaseUrl, startsWith('https://'));
    expect(
      url(Env.prod, ApiPaths.otpRequest),
      'https://qr.activ24.tj:4477/mobi/otp/request',
    );
    expect(
      url(Env.prod, ApiPaths.otpVerify),
      'https://qr.activ24.tj:4477/mobi/otp/verify',
    );
    expect(
      url(Env.prod, ApiPaths.terminal),
      'https://qr.activ24.tj:4477/mobi/terminal',
    );
    expect(
      url(Env.prod, ApiPaths.summary),
      'https://qr.activ24.tj:4477/mobi/summary',
    );
    expect(
      url(Env.prod, ApiPaths.history),
      'https://qr.activ24.tj:4477/mobi/history',
    );
  });
}
