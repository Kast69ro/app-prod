import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  // Собираем один раз: светлая тема нужна ещё и карточке QR на каждой перерисовке.
  static final light = _build(AppColors.light, Brightness.light);
  static final dark = _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: c.accent,
      brightness: brightness,
      primary: c.accent,
      surface: c.background,
      onSurface: c.textPrimary,
      error: c.error,
    );
    final base = brightness == Brightness.dark
        ? ThemeData.dark()
        : ThemeData.light();
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppFonts.brand,
      colorScheme: scheme,
      extensions: [c],
      scaffoldBackgroundColor: c.background,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      // Цвет текста по умолчанию: стили из AppTextStyles его не задают.
      textTheme: base.textTheme.apply(
        bodyColor: c.textPrimary,
        displayColor: c.textPrimary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.accent),
      dialogTheme: DialogThemeData(backgroundColor: c.surface),
      // Календарь периода в истории. В шапке «Дата начала» у Flutter
      // не сжимается — со стандартными 24 px и крупным шрифтом вылезает.
      datePickerTheme: const DatePickerThemeData(
        rangePickerHeaderHeadlineStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Значки статус-бара: тёмные на светлом фоне, светлые на тёмном.
  static SystemUiOverlayStyle overlayFor(Brightness brightness) =>
      brightness == Brightness.dark
      ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
      : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
}
