import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';

part 'theme_mode_repository.g.dart';

/// Выбранная тема: системная, светлая или тёмная.
/// По умолчанию — светлая; тёмная или системная — только по выбору в настройках.
/// Не стирается при выходе — это настройка устройства, а не сессии.
class ThemeModeRepository {
  ThemeModeRepository(this._prefs);

  final SharedPreferences _prefs;

  /// Ничего не выбрано или неизвестное значение (например, от будущей
  /// версии) — светлая тема.
  ThemeMode read() => switch (_prefs.getString(PrefKeys.themeMode)) {
    'system' => ThemeMode.system,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.light,
  };

  Future<void> write(ThemeMode mode) =>
      _prefs.setString(PrefKeys.themeMode, mode.name);
}

@Riverpod(keepAlive: true)
ThemeModeRepository themeModeRepository(Ref ref) =>
    ThemeModeRepository(ref.watch(preferencesProvider));
