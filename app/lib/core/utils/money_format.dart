/// Сумма в TJS для UI: `12 345,60`. Валюту не пишем (см. CLAUDE.md).
///
/// Тысячи разделяются неразрывным пробелом, чтобы сумма не переносилась.
/// Округляем сразу до дирамов: иначе 1.999 превращается в «1,100».
String formatMoney(num value) {
  final cents = (value * 100).round();
  final sign = cents < 0 ? '−' : '';
  final abs = cents.abs();
  final whole = (abs ~/ 100).toString();
  final fraction = (abs % 100).toString().padLeft(2, '0');

  final grouped = StringBuffer();
  for (var i = 0; i < whole.length; i++) {
    if (i > 0 && (whole.length - i) % 3 == 0) grouped.write(' ');
    grouped.write(whole[i]);
  }
  return '$sign$grouped,$fraction';
}
