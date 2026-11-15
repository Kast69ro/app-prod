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

/// Маскированный номер с бэка (`9929*****797`) для показа: `+992 9*****797`.
/// Маску не трогаем — бэк сам решает, какие цифры скрыть.
String formatMaskedPhone(String masked) {
  final v = masked.trim().replaceFirst(RegExp(r'^\+'), '');
  final code = phoneCountryCode.substring(1);
  if (v.startsWith(code) && v.length > code.length) {
    return '$phoneCountryCode ${v.substring(code.length)}';
  }
  return v;
}

/// Полный номер для API: `+992931234567`.
String fullPhone(String digits) => '$phoneCountryCode$digits';
