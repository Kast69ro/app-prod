import 'package:activbank_qr/core/storage/preferences.dart';
import 'package:activbank_qr/features/settings/data/theme_mode_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<ThemeModeRepository> repo([
    Map<String, Object> values = const {},
  ]) async {
    SharedPreferences.setMockInitialValues(values);
    return ThemeModeRepository(await SharedPreferences.getInstance());
  }

  test('по умолчанию — светлая тема', () async {
    expect((await repo()).read(), ThemeMode.light);
  });

  test('выбор сохраняется', () async {
    final r = await repo();
    await r.write(ThemeMode.dark);
    expect(r.read(), ThemeMode.dark);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(PrefKeys.themeMode), 'dark');
  });

  test('неизвестное значение — светлая тема', () async {
    final r = await repo({PrefKeys.themeMode: 'sepia'});
    expect(r.read(), ThemeMode.light);
  });

  test('системная сохраняется', () async {
    final r = await repo();
    await r.write(ThemeMode.system);
    expect(r.read(), ThemeMode.system);
  });
}
