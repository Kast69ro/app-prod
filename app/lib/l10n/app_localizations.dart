import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Activ QR'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'кабинет мерчанта'**
  String get appSubtitle;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из приложения?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmText.
  ///
  /// In ru, this message translates to:
  /// **'Чтобы войти снова, понадобится код из SMS.'**
  String get logoutConfirmText;

  /// No description provided for @errorNoConnection.
  ///
  /// In ru, this message translates to:
  /// **'Нет связи с сервером. Проверьте интернет.'**
  String get errorNoConnection;

  /// No description provided for @errorTimeout.
  ///
  /// In ru, this message translates to:
  /// **'Сервер не ответил вовремя. Попробуйте ещё раз.'**
  String get errorTimeout;

  /// No description provided for @errorUnknown.
  ///
  /// In ru, this message translates to:
  /// **'Что-то пошло не так. Попробуйте ещё раз.'**
  String get errorUnknown;

  /// No description provided for @errorNotConfigured.
  ///
  /// In ru, this message translates to:
  /// **'В этой сборке не задан адрес сервера.'**
  String get errorNotConfigured;

  /// No description provided for @tabHome.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get tabHome;

  /// No description provided for @tabHistory.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get tabHistory;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вход для мерчантов'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Укажите номер, привязанный к вашей точке. Проверим его в базе банка.'**
  String get loginSubtitle;

  /// No description provided for @loginPhoneLabel.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get loginPhoneLabel;

  /// No description provided for @loginCodeHint.
  ///
  /// In ru, this message translates to:
  /// **'Код из SMS на {phone} · действует {minutes} мин'**
  String loginCodeHint(String phone, int minutes);

  /// No description provided for @loginCodeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Код из SMS'**
  String get loginCodeLabel;

  /// No description provided for @loginChangePhone.
  ///
  /// In ru, this message translates to:
  /// **'Изменить номер'**
  String get loginChangePhone;

  /// No description provided for @loginResendIn.
  ///
  /// In ru, this message translates to:
  /// **'Код снова через {seconds} с'**
  String loginResendIn(int seconds);

  /// No description provided for @loginResend.
  ///
  /// In ru, this message translates to:
  /// **'Отправить код снова'**
  String get loginResend;

  /// No description provided for @loginGetCode.
  ///
  /// In ru, this message translates to:
  /// **'Получить код'**
  String get loginGetCode;

  /// No description provided for @loginSendingCode.
  ///
  /// In ru, this message translates to:
  /// **'Отправляем код…'**
  String get loginSendingCode;

  /// No description provided for @loginSubmit.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginSubmit;

  /// No description provided for @loginVerifying.
  ///
  /// In ru, this message translates to:
  /// **'Проверяем код…'**
  String get loginVerifying;

  /// No description provided for @errTerminalNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Терминал с таким номером не найден.'**
  String get errTerminalNotFound;

  /// No description provided for @errNotOurMerchant.
  ///
  /// In ru, this message translates to:
  /// **'Терминал не подключён к Activ QR.'**
  String get errNotOurMerchant;

  /// No description provided for @errOtpTooSoon.
  ///
  /// In ru, this message translates to:
  /// **'Код уже отправляли. Подождите немного.'**
  String get errOtpTooSoon;

  /// No description provided for @errOtpWrong.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код или истёк срок действия.'**
  String get errOtpWrong;

  /// No description provided for @errOtpTooMany.
  ///
  /// In ru, this message translates to:
  /// **'Слишком много попыток. Запросите новый код.'**
  String get errOtpTooMany;

  /// No description provided for @pinTitleCreate.
  ///
  /// In ru, this message translates to:
  /// **'Создайте код входа'**
  String get pinTitleCreate;

  /// No description provided for @pinTitleConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Повторите код'**
  String get pinTitleConfirm;

  /// No description provided for @pinTitleUnlock.
  ///
  /// In ru, this message translates to:
  /// **'Код входа'**
  String get pinTitleUnlock;

  /// No description provided for @pinSubCreate.
  ///
  /// In ru, this message translates to:
  /// **'4 цифры — их будем спрашивать при каждом запуске вместо SMS'**
  String get pinSubCreate;

  /// No description provided for @pinSubConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Введите те же 4 цифры ещё раз'**
  String get pinSubConfirm;

  /// No description provided for @pinMismatch.
  ///
  /// In ru, this message translates to:
  /// **'Коды не совпали. Задайте код заново.'**
  String get pinMismatch;

  /// No description provided for @pinWrong.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код. Осталось попыток: {left}'**
  String pinWrong(int left);

  /// No description provided for @pinLockedOut.
  ///
  /// In ru, this message translates to:
  /// **'Код входа введён неверно {count} раз. Войдите по номеру телефона.'**
  String pinLockedOut(int count);

  /// No description provided for @pinEntered.
  ///
  /// In ru, this message translates to:
  /// **'Введено цифр: {count} из {total}'**
  String pinEntered(int count, int total);

  /// No description provided for @terminalFallback.
  ///
  /// In ru, this message translates to:
  /// **'терминал'**
  String get terminalFallback;

  /// No description provided for @homeTodaySuccess.
  ///
  /// In ru, this message translates to:
  /// **'Успешные за сегодня'**
  String get homeTodaySuccess;

  /// No description provided for @homeTodayRefund.
  ///
  /// In ru, this message translates to:
  /// **'Возврат за сегодня'**
  String get homeTodayRefund;

  /// No description provided for @homeLastPayment.
  ///
  /// In ru, this message translates to:
  /// **'Последний платёж'**
  String get homeLastPayment;

  /// No description provided for @homeNoPayments.
  ///
  /// In ru, this message translates to:
  /// **'платежей ещё нет'**
  String get homeNoPayments;

  /// No description provided for @qrSemantic.
  ///
  /// In ru, this message translates to:
  /// **'QR-код для оплаты'**
  String get qrSemantic;

  /// No description provided for @qrOpenFullscreen.
  ///
  /// In ru, this message translates to:
  /// **'Открыть QR на весь экран'**
  String get qrOpenFullscreen;

  /// No description provided for @qrTapToClose.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите, чтобы закрыть'**
  String get qrTapToClose;

  /// No description provided for @qrTooLong.
  ///
  /// In ru, this message translates to:
  /// **'QR не построен: строка terminalQR слишком длинная ({length} симв.). Сообщите в банк.'**
  String qrTooLong(int length);

  /// No description provided for @qrInvalid.
  ///
  /// In ru, this message translates to:
  /// **'QR не удалось построить. Сообщите в банк.'**
  String get qrInvalid;

  /// No description provided for @statusSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Оплачено'**
  String get statusSuccess;

  /// No description provided for @statusCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отклонён'**
  String get statusCancel;

  /// No description provided for @statusPending.
  ///
  /// In ru, this message translates to:
  /// **'Ожидание'**
  String get statusPending;

  /// No description provided for @statusRefunded.
  ///
  /// In ru, this message translates to:
  /// **'Возврат'**
  String get statusRefunded;

  /// No description provided for @statusRefundPending.
  ///
  /// In ru, this message translates to:
  /// **'Возврат в обработке'**
  String get statusRefundPending;

  /// No description provided for @statusUnknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестно'**
  String get statusUnknown;

  /// No description provided for @historyEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пока нет операций. Потяните список вниз, чтобы обновить.'**
  String get historyEmpty;

  /// No description provided for @historyLoadMore.
  ///
  /// In ru, this message translates to:
  /// **'Показать ещё ({count})'**
  String historyLoadMore(int count);

  /// No description provided for @historyLoadingMore.
  ///
  /// In ru, this message translates to:
  /// **'Загружаем…'**
  String get historyLoadingMore;

  /// No description provided for @historyNoDate.
  ///
  /// In ru, this message translates to:
  /// **'Без даты'**
  String get historyNoDate;

  /// No description provided for @historyEmptyPeriod.
  ///
  /// In ru, this message translates to:
  /// **'За этот период операций нет.'**
  String get historyEmptyPeriod;

  /// No description provided for @periodAll.
  ///
  /// In ru, this message translates to:
  /// **'Всё время'**
  String get periodAll;

  /// No description provided for @periodToday.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get periodToday;

  /// No description provided for @periodYesterday.
  ///
  /// In ru, this message translates to:
  /// **'Вчера'**
  String get periodYesterday;

  /// No description provided for @periodWeek.
  ///
  /// In ru, this message translates to:
  /// **'7 дней'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In ru, this message translates to:
  /// **'Этот месяц'**
  String get periodMonth;

  /// No description provided for @periodLastMonth.
  ///
  /// In ru, this message translates to:
  /// **'Прошлый месяц'**
  String get periodLastMonth;

  /// No description provided for @periodCustom.
  ///
  /// In ru, this message translates to:
  /// **'Период…'**
  String get periodCustom;

  /// No description provided for @periodPickTitle.
  ///
  /// In ru, this message translates to:
  /// **'Период истории'**
  String get periodPickTitle;

  /// No description provided for @reportExport.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт в PDF'**
  String get reportExport;

  /// No description provided for @reportPreparing.
  ///
  /// In ru, this message translates to:
  /// **'Готовим отчёт…'**
  String get reportPreparing;

  /// No description provided for @reportPickTitle.
  ///
  /// In ru, this message translates to:
  /// **'Период отчёта'**
  String get reportPickTitle;

  /// No description provided for @reportTooLong.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт — не больше чем за год. Выберите период короче.'**
  String get reportTooLong;

  /// No description provided for @reportTitle.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт по операциям'**
  String get reportTitle;

  /// No description provided for @reportPeriod.
  ///
  /// In ru, this message translates to:
  /// **'Период'**
  String get reportPeriod;

  /// No description provided for @reportGenerated.
  ///
  /// In ru, this message translates to:
  /// **'Сформирован'**
  String get reportGenerated;

  /// No description provided for @reportPaid.
  ///
  /// In ru, this message translates to:
  /// **'Оплачено'**
  String get reportPaid;

  /// No description provided for @reportDeclined.
  ///
  /// In ru, this message translates to:
  /// **'Отклонено'**
  String get reportDeclined;

  /// No description provided for @reportRefunded.
  ///
  /// In ru, this message translates to:
  /// **'Возвраты'**
  String get reportRefunded;

  /// No description provided for @reportOperations.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{{count} операция} few{{count} операции} other{{count} операций}}'**
  String reportOperations(int count);

  /// No description provided for @reportEmpty.
  ///
  /// In ru, this message translates to:
  /// **'За этот период операций нет.'**
  String get reportEmpty;

  /// No description provided for @reportNumber.
  ///
  /// In ru, this message translates to:
  /// **'№'**
  String get reportNumber;

  /// No description provided for @reportPage.
  ///
  /// In ru, this message translates to:
  /// **'Стр. {page} из {total}'**
  String reportPage(int page, int total);

  /// No description provided for @paymentDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get paymentDate;

  /// No description provided for @paymentTime.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get paymentTime;

  /// No description provided for @paymentBank.
  ///
  /// In ru, this message translates to:
  /// **'Банк-отправитель'**
  String get paymentBank;

  /// No description provided for @paymentPayer.
  ///
  /// In ru, this message translates to:
  /// **'Плательщик'**
  String get paymentPayer;

  /// No description provided for @paymentOurBank.
  ///
  /// In ru, this message translates to:
  /// **'ActivBank'**
  String get paymentOurBank;

  /// No description provided for @reportSender.
  ///
  /// In ru, this message translates to:
  /// **'Банк / Плательщик'**
  String get reportSender;

  /// No description provided for @paymentTrail.
  ///
  /// In ru, this message translates to:
  /// **'Ход операции'**
  String get paymentTrail;

  /// No description provided for @paymentTrailCreated.
  ///
  /// In ru, this message translates to:
  /// **'QR создан'**
  String get paymentTrailCreated;

  /// No description provided for @paymentTrailScanned.
  ///
  /// In ru, this message translates to:
  /// **'Клиент отсканировал'**
  String get paymentTrailScanned;

  /// No description provided for @paymentShare.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться чеком'**
  String get paymentShare;

  /// No description provided for @paymentSharing.
  ///
  /// In ru, this message translates to:
  /// **'Готовим чек…'**
  String get paymentSharing;

  /// No description provided for @paymentShareError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось — повторить'**
  String get paymentShareError;

  /// No description provided for @receiptTitle.
  ///
  /// In ru, this message translates to:
  /// **'Чек об операции'**
  String get receiptTitle;

  /// No description provided for @receiptAmount.
  ///
  /// In ru, this message translates to:
  /// **'Сумма'**
  String get receiptAmount;

  /// No description provided for @receiptStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get receiptStatus;

  /// No description provided for @receiptBank.
  ///
  /// In ru, this message translates to:
  /// **'Банк'**
  String get receiptBank;

  /// No description provided for @receiptFooter.
  ///
  /// In ru, this message translates to:
  /// **'Сохраните чек для обращения в банк'**
  String get receiptFooter;

  /// No description provided for @back.
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get back;

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @settingsTerminal.
  ///
  /// In ru, this message translates to:
  /// **'Терминал'**
  String get settingsTerminal;

  /// No description provided for @settingsStore.
  ///
  /// In ru, this message translates to:
  /// **'Точка'**
  String get settingsStore;

  /// No description provided for @settingsTerminalId.
  ///
  /// In ru, this message translates to:
  /// **'ID терминала'**
  String get settingsTerminalId;

  /// No description provided for @settingsPhone.
  ///
  /// In ru, this message translates to:
  /// **'Телефон'**
  String get settingsPhone;

  /// No description provided for @settingsChangePin.
  ///
  /// In ru, this message translates to:
  /// **'Сменить код входа'**
  String get settingsChangePin;

  /// No description provided for @settingsTheme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @pinTitleCurrent.
  ///
  /// In ru, this message translates to:
  /// **'Текущий код'**
  String get pinTitleCurrent;

  /// No description provided for @pinSubCurrent.
  ///
  /// In ru, this message translates to:
  /// **'Введите код, которым входите сейчас'**
  String get pinSubCurrent;

  /// No description provided for @pinTitleNew.
  ///
  /// In ru, this message translates to:
  /// **'Новый код входа'**
  String get pinTitleNew;

  /// No description provided for @pinChanged.
  ///
  /// In ru, this message translates to:
  /// **'Код входа изменён'**
  String get pinChanged;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
