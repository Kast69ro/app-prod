// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Activ QR';

  @override
  String get appSubtitle => 'кабинет мерчанта';

  @override
  String get retry => 'Повторить';

  @override
  String get logout => 'Выйти';

  @override
  String get cancel => 'Отмена';

  @override
  String get logoutConfirmTitle => 'Выйти из приложения?';

  @override
  String get logoutConfirmText => 'Чтобы войти снова, понадобится код из SMS.';

  @override
  String get errorNoConnection => 'Нет связи с сервером. Проверьте интернет.';

  @override
  String get errorTimeout => 'Сервер не ответил вовремя. Попробуйте ещё раз.';

  @override
  String get errorUnknown => 'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get errorNotConfigured => 'В этой сборке не задан адрес сервера.';

  @override
  String get tabHome => 'Главная';

  @override
  String get tabHistory => 'История';

  @override
  String get loginTitle => 'Вход для мерчантов';

  @override
  String get loginSubtitle =>
      'Укажите номер, привязанный к вашей точке. Проверим его в базе банка.';

  @override
  String get loginPhoneLabel => 'Номер телефона';

  @override
  String loginCodeHint(String phone, int minutes) {
    return 'Код из SMS на $phone · действует $minutes мин';
  }

  @override
  String get loginCodeLabel => 'Код из SMS';

  @override
  String get loginChangePhone => 'Изменить номер';

  @override
  String loginResendIn(int seconds) {
    return 'Код снова через $seconds с';
  }

  @override
  String get loginResend => 'Отправить код снова';

  @override
  String get loginGetCode => 'Получить код';

  @override
  String get loginSendingCode => 'Отправляем код…';

  @override
  String get loginSubmit => 'Войти';

  @override
  String get loginVerifying => 'Проверяем код…';

  @override
  String get errTerminalNotFound => 'Терминал с таким номером не найден.';

  @override
  String get errNotOurMerchant => 'Терминал не подключён к Activ QR.';

  @override
  String get errOtpTooSoon => 'Код уже отправляли. Подождите немного.';

  @override
  String get errOtpWrong => 'Неверный код или истёк срок действия.';

  @override
  String get errOtpTooMany => 'Слишком много попыток. Запросите новый код.';

  @override
  String get pinTitleCreate => 'Создайте код входа';

  @override
  String get pinTitleConfirm => 'Повторите код';

  @override
  String get pinTitleUnlock => 'Код входа';

  @override
  String get pinSubCreate =>
      '4 цифры — их будем спрашивать при каждом запуске вместо SMS';

  @override
  String get pinSubConfirm => 'Введите те же 4 цифры ещё раз';

  @override
  String get pinMismatch => 'Коды не совпали. Задайте код заново.';

  @override
  String pinWrong(int left) {
    return 'Неверный код. Осталось попыток: $left';
  }

  @override
  String pinLockedOut(int count) {
    return 'Код входа введён неверно $count раз. Войдите по номеру телефона.';
  }

  @override
  String pinEntered(int count, int total) {
    return 'Введено цифр: $count из $total';
  }

  @override
  String get terminalFallback => 'терминал';

  @override
  String get homeTodaySuccess => 'Успешные за сегодня';

  @override
  String get homeTodayRefund => 'Возврат за сегодня';

  @override
  String get homeLastPayment => 'Последний платёж';

  @override
  String get homeNoPayments => 'платежей ещё нет';

  @override
  String get qrSemantic => 'QR-код для оплаты';

  @override
  String get qrOpenFullscreen => 'Открыть QR на весь экран';

  @override
  String get qrTapToClose => 'Нажмите, чтобы закрыть';

  @override
  String qrTooLong(int length) {
    return 'QR не построен: строка terminalQR слишком длинная ($length симв.). Сообщите в банк.';
  }

  @override
  String get qrInvalid => 'QR не удалось построить. Сообщите в банк.';

  @override
  String get statusSuccess => 'Оплачено';

  @override
  String get statusCancel => 'Отклонён';

  @override
  String get statusPending => 'Ожидание';

  @override
  String get statusRefunded => 'Возврат';

  @override
  String get statusRefundPending => 'Возврат в обработке';

  @override
  String get statusUnknown => 'Неизвестно';

  @override
  String get historyEmpty =>
      'Пока нет операций. Потяните список вниз, чтобы обновить.';

  @override
  String historyLoadMore(int count) {
    return 'Показать ещё ($count)';
  }

  @override
  String get historyLoadingMore => 'Загружаем…';

  @override
  String get historyNoDate => 'Без даты';

  @override
  String get historyEmptyPeriod => 'За этот период операций нет.';

  @override
  String get periodAll => 'Всё время';

  @override
  String get periodToday => 'Сегодня';

  @override
  String get periodYesterday => 'Вчера';

  @override
  String get periodWeek => '7 дней';

  @override
  String get periodMonth => 'Этот месяц';

  @override
  String get periodLastMonth => 'Прошлый месяц';

  @override
  String get periodCustom => 'Период…';

  @override
  String get periodPickTitle => 'Период истории';

  @override
  String get reportExport => 'Отчёт в PDF';

  @override
  String get reportPreparing => 'Готовим отчёт…';

  @override
  String get reportPickTitle => 'Период отчёта';

  @override
  String get reportTooLong =>
      'Отчёт — не больше чем за год. Выберите период короче.';

  @override
  String get reportTitle => 'Отчёт по операциям';

  @override
  String get reportPeriod => 'Период';

  @override
  String get reportGenerated => 'Сформирован';

  @override
  String get reportPaid => 'Оплачено';

  @override
  String get reportDeclined => 'Отклонено';

  @override
  String get reportRefunded => 'Возвраты';

  @override
  String reportOperations(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count операций',
      few: '$count операции',
      one: '$count операция',
    );
    return '$_temp0';
  }

  @override
  String get reportEmpty => 'За этот период операций нет.';

  @override
  String get reportNumber => '№';

  @override
  String reportPage(int page, int total) {
    return 'Стр. $page из $total';
  }

  @override
  String get paymentDate => 'Дата';

  @override
  String get paymentTime => 'Время';

  @override
  String get paymentBank => 'Банк-отправитель';

  @override
  String get paymentPayer => 'Плательщик';

  @override
  String get paymentOurBank => 'ActivBank';

  @override
  String get paymentTransfer => 'Перевод';

  @override
  String get paymentTransferInternal => 'Внутри банка';

  @override
  String get historyInternalTag => 'ActivBank · внутри банка';

  @override
  String get reportSender => 'Банк / Плательщик';

  @override
  String get paymentTrail => 'Ход операции';

  @override
  String get paymentTrailCreated => 'QR создан';

  @override
  String get paymentTrailScanned => 'Клиент отсканировал';

  @override
  String get paymentRefund => 'Возврат платежа';

  @override
  String get paymentShare => 'Поделиться чеком';

  @override
  String get paymentSharing => 'Готовим чек…';

  @override
  String get paymentShareError => 'Не удалось — повторить';

  @override
  String get receiptTitle => 'Чек об операции';

  @override
  String get receiptAmount => 'Сумма';

  @override
  String get receiptStatus => 'Статус';

  @override
  String get receiptBank => 'Банк';

  @override
  String get receiptFooter => 'Сохраните чек для обращения в банк';

  @override
  String get back => 'Назад';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsTerminal => 'Терминал';

  @override
  String get settingsStore => 'Точка';

  @override
  String get settingsTerminalId => 'ID терминала';

  @override
  String get settingsPhone => 'Телефон';

  @override
  String get settingsChangePin => 'Сменить код входа';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get pinTitleCurrent => 'Текущий код';

  @override
  String get pinSubCurrent => 'Введите код, которым входите сейчас';

  @override
  String get pinTitleNew => 'Новый код входа';

  @override
  String get pinChanged => 'Код входа изменён';
}
