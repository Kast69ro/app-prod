# ActivBank QR — Flutter-приложение мерчанта (iOS + Android)

Прочитай этот файл перед любой работой. Подробный план: `docs/plan.md`.

## Что это
Банковское приложение для мерчантов ActivBank (Таджикистан). Две задачи:
1. Показать статический QR банка мерчанта («QR рамзи ягона», стандарт НБТ).
2. Показать историю поступлений и сводку за день.
Плюс «Поделиться чеком» по операции. Печати чека НЕТ и не добавлять.
Публикуем в Google Play и App Store, поэтому всё делаем по требованиям сторов.

Язык интерфейса — русский. Суммы в TJS, валюту в UI не пишем.
Демо-режима НЕТ и не добавлять: без сервера вход невозможен (fail-closed, требование банка).

## Стек
Flutter stable, Dart 3, null safety.
- Состояние: `flutter_riverpod` (+ `riverpod_annotation`, codegen).
- Навигация: `go_router` с редиректами по состоянию сессии.
- Сеть: `dio` + интерсепторы (токен, ошибки, refresh по 401).
- Модели: `freezed` + `json_serializable`.
- QR: `qr_flutter` (из строки `terminalQR`, сканер не нужен).
- Чек: `share_plus` + `path_provider` (PNG через `RepaintBoundary`).
- Хранилище: `flutter_secure_storage` для токенов/сессии/счётчика PIN. SharedPreferences — только для неважных настроек.
- `screen_brightness`, `wakelock_plus` — полноэкранный QR.
- `intl`, `flutter_localizations` — форматирование, `l10n/app_ru.arb`.

Новый пакет добавляй только после того, как объяснишь, зачем он нужен, и я соглашусь.

## Структура
Flutter-проект лежит в папке `app/` (рядом — прототип и `docs/`). Все команды запускать из `app/`.
Flutter SDK: `D:\dev\flutter`. Запуск на Android: `flutter run --flavor dev -t lib/main_dev.dart`; в браузере (только вёрстка): `flutter run -d chrome -t lib/main_dev.dart`.
После правок провайдеров/моделей: `dart run build_runner build`. CI — `.github/workflows/flutter.yml`.
```
lib/
  main_dev.dart, main_prod.dart
  app/        app.dart, router.dart, env.dart
  core/       api/ storage/ security/ theme/ utils/ widgets/
  features/<feature>/{data,domain,presentation}/
    auth, pin, home, history, payment, receipt, settings
```
Правила:
- Экран не вызывает `dio` напрямую: экран → контроллер (Riverpod) → репозиторий → `ApiClient`.
- DTO живут в `data/`, модели для UI — в `domain/`.
- Общие виджеты — в `core/widgets`, цвета и шрифты — только из `core/theme`, без хардкода в экранах.
- Один виджет — один файл, если он больше ~150 строк.

## Flavors
- `dev`: `http://10.64.20.101:8888` (тестовый, внутренняя сеть банка). http разрешён ТОЛЬКО в dev:
  Android `src/dev/res/xml/network_security_config.xml`, iOS — исключение ATS только в dev-конфигурации.
- `prod`: HTTPS-домен шлюза в DMZ (уточнить). Без исключений ATS / cleartext, включён certificate pinning.
- Адрес берётся из `env.dart`, нигде не хардкодится.

## API (база `/pos`)
- `POST /pos/otp/request` `{phone}` → `{ok, message, expires_in}`. Ошибки: 404 не найден, 403 не наш мерчант, 429 повтор позже (`detail`).
- `POST /pos/otp/verify` `{phone, code}` → `{ok, terminalId, terminalName, storeName}` (+ токены, когда бэк добавит). Ошибки: 400 (в `detail` «Осталось попыток: N»), 429.
- `GET /pos/terminal` → `{terminal: {terminalName, terminalPhone, storeName, terminalQR}, last_payment | null}`.
- `GET /pos/summary?date=YYYY-MM-DD` → `{date, success: {count, amount}, cancel: {count, amount}, currency}`; позже блок `refunded`.
- `GET /pos/history?date=|from=&to=&limit=50&offset=0` → `{total, limit, offset, count, payments: [{sender, sender_bank_id, amount, status, creation_datetime}]}`, от новых к старым.
- Статусы: `success` «Оплачено», `cancel` «Отклонён»; позже `refunded` «Возврат», `refund_pending` «Возврат в обработке».
- Сейчас GET-ручки принимают `?phone=`. План: после `otp/verify` бэк выдаёт access + refresh токен, запросы идут с `Authorization: Bearer`, refresh через `POST /pos/auth/refresh` по 401, выход `POST /pos/auth/logout`. Пиши `ApiClient` так, чтобы переход на токены менял только интерсептор.
- Ошибки показываем по тексту `detail` с бэка; нет сети / таймаут → понятный экран с кнопкой «Повторить».

## Экраны
1. Вход: телефон +992 → OTP 6 цифр, «Отправить повторно» через 60 с.
2. Код доступа 4 цифры: создать после первого входа, при запуске — ввести. 5 ошибок → стереть сессию, снова OTP. Опционально Face ID / отпечаток (`local_auth`).
3. Главная: название точки, мерчант, лого; карточка QR (лого TJ QR | разделитель | QR); тап → QR на весь экран (чёрный на белом, 4 модуля тишины, яркость на максимум). Плитки «За сегодня» и «Возврат за сегодня».
4. История: группировка по дням, pull-to-refresh, подгрузка `offset += limit`.
5. Карточка операции: реквизиты, статус, «Поделиться чеком» (только для `success`), «Возврат платежа» — пока disabled.
6. Настройки (тап по логотипу на главной): данные точки, сменить код, политика конфиденциальности (ссылка), версия, «Выйти».
   На экране кода вместо «Забыли код?» — «Выйти» (вход всё равно по SMS).

## Безопасность (банк — не экономим)
- Токены и сессия — только `flutter_secure_storage`. Не хранить PIN или его простой хеш.
- Не логировать телефон, коды, токены, ответы API. В релизе логов запросов нет.
- Автоблокировка при сворачивании/бездействии → снова код.
- Скрывать содержимое в списке недавних (Android `FLAG_SECURE`, iOS — заглушка).
- Релиз: `--obfuscate --split-debug-info`.
- Никаких ключей, паролей, keystore в репозитории.

## Дизайн
UI остаётся тем же, что в старой версии: эталон — `POS Terminal.dc.html` (HTML-прототип, его не удалять).
Экраны, тексты, отступы и размеры переносим из него один в один. Отличия только там,
где этого требует этот файл: нет печати (вместо неё «Поделиться чеком»), есть экран «Настройки»,
акцент и шрифт — по бренд-буку банка (не из прототипа), иконки вкладок — Material.
Логотип и иконку приложения не менять.
Фон `#F4F4F1`, карточки `#FFFFFF`, бордер `#E7E7E2`, текст `#16181A` / вторичный `#6B7075`, акцент — фирменный красный `#E31E24`.
Зелёный `#0E8F6F` — только статус «Оплачено» (бренд-бук разрешает свои цвета для статусов).
Шрифты: Montserrat (фирменный) — весь текст, цифры и суммы с `tabularFigures`; Lato — только блок TJ QR.
Минимальная зона нажатия 44 px. Поддержать маленькие экраны и системный размер шрифта.

## Как работать со мной
- Я junior/mid frontend-разработчик. Объясняй решения коротко и по-русски, особенно Flutter-специфику.
- Перед большой правкой — короткий план, потом код.
- После изменений: `dart format .`, `flutter analyze` без ошибок, тесты для репозиториев и форматтеров.
- Не трогай `android/`, `ios/` и подпись без моего согласия.
