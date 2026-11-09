const _months = [
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

String _two(int v) => v.toString().padLeft(2, '0');

/// `14:05`
String formatTime(DateTime d) => '${_two(d.hour)}:${_two(d.minute)}';

/// `08.09` — дата в реквизитах операции.
String formatDayMonth(DateTime d) => '${_two(d.day)}.${_two(d.month)}';

/// `08.09.2026` — дата в чеке.
String formatFullDate(DateTime d) =>
    '${formatDayMonth(d)}.${d.year.toString().padLeft(4, '0')}';

/// `2026-09-08` — параметр `date` для API.
String formatIsoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${_two(d.month)}-${_two(d.day)}';

/// Заголовок группы в истории: «Сегодня», «Вчера» или «5 мая».
/// [now] передаётся снаружи, чтобы функцию можно было тестировать.
String formatDayLabel(DateTime d, DateTime now) {
  // UTC, чтобы переход на летнее время не давал 23-часовые сутки.
  final day = DateTime.utc(d.year, d.month, d.day);
  final today = DateTime.utc(now.year, now.month, now.day);
  final diff = today.difference(day).inDays;
  if (diff == 0) return 'Сегодня';
  if (diff == 1) return 'Вчера';
  return '${d.day} ${_months[d.month - 1]}';
}

/// Ключ дня для группировки.
DateTime dayKey(DateTime d) => DateTime(d.year, d.month, d.day);
