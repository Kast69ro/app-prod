# ActivQR POS — мобильный API (версия с JWT)

Контракт для мобильного приложения мерчанта. JSON, UTF-8. Базовый адрес —
сообщается отдельно (через WAF, HTTPS). Все суммы — **сомони (TJS), дробные**.
Время — по Душанбе (UTC+5).

## Что изменилось против версии с `?phone=`
- **Эндпоинты данных больше НЕ принимают `?phone=`.** `terminalId` берётся из токена.
- **`/mobi/otp/verify` теперь возвращает токены** (access + refresh), а не плоские поля.
- Новые эндпоинты: `/mobi/auth/refresh`, `/mobi/auth/logout`.
- На всех эндпоинтах данных обязателен заголовок `Authorization: Bearer <access_token>`.

## Флоу
1. `POST /mobi/otp/request` `{phone}` → приходит SMS с кодом.
2. `POST /mobi/otp/verify` `{phone, code}` → `access_token` + `refresh_token`.
3. Все запросы данных — с заголовком `Authorization: Bearer <access_token>`.
4. Пришёл `401` (access истёк) → `POST /mobi/auth/refresh` `{refresh_token}` → новая пара токенов, повтори запрос.
5. Если и refresh вернул `401` → токены мертвы → заново OTP-логин.
6. Выход: `POST /mobi/auth/logout` `{refresh_token}`.

Access живёт ~15 мин, refresh ~30 дней. Токены хранить в защищённом хранилище
(Keychain / Keystore), в логи не писать.

---

## Авторизация

### POST /mobi/otp/request  (без токена)
`{ "phone": "+992970799797" }`

Телефон — с `+`. Это POST/JSON, `+` кодировать не нужно.
Успех `200`: `{ "ok": true, "message": "Код отправлен по SMS", "expires_in": 300 }`

| HTTP | Когда |
|---|---|
| 404 | терминал с таким номером не найден |
| 403 | терминал не наш мерчант |
| 429 | слишком рано/слишком много (в `Retry-After` — секунды) |

### POST /mobi/otp/verify  (без токена)
`{ "phone": "+992970799797", "code": "123456" }`

Успех `200`:
```json
{
  "ok": true,
  "message": "Код подтверждён, вход выполнен",
  "access_token": "eyJ...",
  "access_expires_in": 900,
  "refresh_token": "xzy...",
  "refresh_expires_in": 2592000,
  "terminal": {
    "terminalId": 34958, "terminalName": "...", "terminalPhone": "+992...",
    "storeName": "...", "terminalQR": "..."
  }
}
```
`400` — код не запрашивался/истёк/неверный (в `detail` — остаток попыток).

### POST /mobi/auth/refresh  (без токена, refresh в теле)
`{ "refresh_token": "xzy..." }` →
```json
{ "ok": true, "access_token": "eyJ...", "access_expires_in": 900,
  "refresh_token": "НОВЫЙ...", "refresh_expires_in": 2592000 }
```
`401` — refresh недействителен/истёк → заново OTP-логин.
Важно: **refresh ротируется** — после рефреша старый refresh больше не работает, храни новый.

### POST /mobi/auth/logout
`{ "refresh_token": "xzy..." }` → `{ "ok": true, "message": "Выход выполнен" }`

---

## Данные (все — с `Authorization: Bearer <access_token>`)

### GET /mobi/terminal
```json
{ "terminal": { ... }, "last_payment": { ...объект платежа... } | null }
```

### GET /mobi/summary?date=ГГГГ-ММ-ДД
`date` необязателен (по умолчанию сегодня).
```json
{ "date": "2026-11-09",
  "success": { "count": 21, "amount": 795.00 },
  "cancel":  { "count": 2,  "amount": 60.00 },
  "currency": "TJS" }
```

### GET /mobi/history
Параметры: `date` (один день) ИЛИ `from`/`to` (период, включительно);
`limit` (1..200, по умолч. 50), `offset` (для подгрузки).
```json
{ "terminal": {...}, "total": 137, "limit": 50, "offset": 0, "count": 50,
  "payments": [ ...объекты платежей, от новых к старым... ] }
```
Подгрузка: `offset += limit`.

### GET /mobi/report?date=ГГГГ-ММ-ДД
Ответ — файл `.xlsx` (`Content-Disposition: attachment`). Отдать в системное
«Поделиться».

---

## Объект платежа
| Поле | Тип | Описание |
|---|---|---|
| type | string | `internal` (внутрибанк) / `external` (межбанк) |
| sender | string | имя плательщика (internal) или имя банка (external) |
| sender_bank_id | int \| null | id банка (только external) |
| sender_phone | string \| null | маскированный телефон (только internal) |
| amount | number | сумма, TJS (дробное) |
| status | string | `success` / `pending` / `cancel` / `failed` |
| creation_datetime | string | дата-время, ISO (UTC+5) |

```json
{ "type": "internal", "sender": "КУРБОНОВ Мухаммадшариф", "sender_bank_id": null,
  "sender_phone": "9929*****797", "amount": 44.55, "status": "success",
  "creation_datetime": "2026-10-30T14:12:00" }
```

## Обработка 401 (важно)
На любом запросе данных `401` означает «access истёк/недействителен». Алгоритм:
1. вызвать `/mobi/auth/refresh` с текущим refresh;
2. успех → сохранить новую пару, повторить исходный запрос;
3. `401` на refresh → очистить токены, отправить на экран OTP-логина.
Не зацикливать: один refresh на один `401`.
