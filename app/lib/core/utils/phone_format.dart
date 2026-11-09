/// Номер без кода страны — 9 цифр.
const phoneDigits = 9;
const phoneCountryCode = '+992';

/// Маска поля ввода: `93 123 45 67`, недостающие цифры — точки.
String formatPhoneMask(String digits) {
  final d = digits.padRight(phoneDigits, '·');
  return '${d.substring(0, 2)} ${d.substring(2, 5)} '
      '${d.substring(5, 7)} ${d.substring(7, 9)}';
}

/// Скрытый номер для подписей: `+992 93 ··· 67`.
String formatPhoneHidden(String digits) {
  final d = digits.padRight(phoneDigits, '·');
  return '$phoneCountryCode ${d.substring(0, 2)} ··· ${d.substring(7, 9)}';
}

/// Полный номер для API: `+992931234567`.
String fullPhone(String digits) => '$phoneCountryCode$digits';
