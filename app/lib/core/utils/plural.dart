/// Русское склонение: `plural(5, 'платёж', 'платежа', 'платежей')` → «5 платежей».
String plural(int n, String one, String few, String many) {
  final v = n.abs();
  final d10 = v % 10;
  final d100 = v % 100;
  final String word;
  if (d100 >= 11 && d100 <= 14) {
    word = many;
  } else if (d10 == 1) {
    word = one;
  } else if (d10 >= 2 && d10 <= 4) {
    word = few;
  } else {
    word = many;
  }
  return '$n $word';
}

String paymentsCount(int n) => plural(n, 'платёж', 'платежа', 'платежей');
