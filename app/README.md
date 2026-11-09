# Activ QR

Flutter-приложение мерчанта ActivBank (iOS + Android): статический QR, история поступлений, чек.
Подробности — `../CLAUDE.md` и `../docs/plan.md`.

## Требования

- Flutter **3.47.7 stable** (Dart 3.13). На старых версиях `flutter pub get` не пройдёт.
- iOS: Xcode 16+, iOS 15.0+. CocoaPods не нужен — плагины подключены через Swift Package Manager.
- Android: JDK 17.

## Запуск

Все команды — из папки `app/`. Сгенерированные файлы (`*.g.dart`, `*.freezed.dart`) уже в репозитории.

```sh
flutter pub get

# dev — тестовый сервер
flutter run --flavor dev -t lib/main_dev.dart

# prod — боевой сервер
flutter run --flavor prod -t lib/main_prod.dart
```

Команда одинаковая для iOS и Android. Без `--flavor` сборка не запустится — это нормально.

| Flavor | Bundle ID (iOS)                | Application ID (Android)          | Название         |
|--------|--------------------------------|-----------------------------------|------------------|
| dev    | `tj.activbank.activbankQr.dev` | `tj.activbank.activbank_qr.dev`   | Activ QR Dev |
| prod   | `tj.activbank.activbankQr`     | `tj.activbank.activbank_qr`       | Activ QR         |

dev и prod можно поставить на одно устройство одновременно.

### Из Xcode

Сначала один раз `flutter pub get` (создаёт `ios/Flutter/Generated.xcconfig`), потом открыть
`ios/Runner.xcworkspace`, выбрать схему `dev` или `prod` и нажать Run.

### На реальном iPhone

Подпись в репозитории не настроена. В Xcode: Runner → Signing & Capabilities → выбрать свою команду
(Team). Для симулятора подпись не нужна.

## Важно для тестирования

- **Тестовый сервер (`dev`) — во внутренней сети банка.** Без VPN / Wi-Fi банка будет экран
  «нет сети». Демо-режима нет специально (требование банка): без сервера войти нельзя.
- Для входа нужен номер телефона, зарегистрированный как мерчант на тестовом сервере, — код придёт по SMS.
- Код доступа: 4 цифры, 5 ошибок — сессия стирается, снова вход по SMS.

## CI

`.github/workflows/flutter.yml`: формат, анализ, тесты, dev APK и сборка iOS
(dev под симулятор + prod release без подписи). Готовые сборки — в артефактах прогона:
`activbank-qr-dev-apk` и `activbank-qr-dev-simulator` (распаковать и перетащить `Runner.app` в симулятор).

## Проверки перед коммитом

```sh
dart format .
flutter analyze
flutter test
```
