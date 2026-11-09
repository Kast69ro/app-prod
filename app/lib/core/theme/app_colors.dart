import 'package:flutter/material.dart';

/// Цвета приложения — светлая и тёмная палитра.
/// Светлая — из прототипа `POS Terminal.dc.html`, акцент — по бренд-буку банка.
/// В экранах — только отсюда: `context.colors.surface`.
///
/// `ThemeExtension` — способ Flutter положить свои поля в `ThemeData`:
/// при смене темы виджеты сами перерисуются с новыми цветами.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfacePressed,
    required this.border,
    required this.borderList,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.error,
    required this.errorBg,
    required this.errorBorder,
    required this.key,
    required this.keyPressed,
    required this.cellIdle,
    required this.buttonPrimary,
    required this.buttonPrimaryText,
    required this.buttonLoading,
    required this.buttonDisabled,
    required this.disabledBg,
    required this.disabledText,
    required this.tabActiveBg,
    required this.segmentSelected,
    required this.tjqrText,
    required this.qrBackdrop,
    required this.successBg,
    required this.successFg,
    required this.successDot,
    required this.cancelBg,
    required this.cancelFg,
    required this.cancelDot,
    required this.pendingBg,
    required this.pendingFg,
    required this.pendingDot,
    required this.refundBg,
    required this.refundFg,
    required this.refundDot,
    required this.unknownBg,
    required this.unknownFg,
    required this.unknownDot,
  });

  final Color background;
  final Color surface;
  final Color surfacePressed;
  final Color border;

  /// Бордер строк истории и карточки операции.
  final Color borderList;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  /// «Актив — Ориент Красный» из бренд-бука (RGB 227-30-36).
  final Color accent;

  final Color error;
  final Color errorBg;
  final Color errorBorder;

  final Color key;
  final Color keyPressed;
  final Color cellIdle;

  /// Основная кнопка: тёмная в светлой теме, светлая — в тёмной.
  final Color buttonPrimary;
  final Color buttonPrimaryText;
  final Color buttonLoading;
  final Color buttonDisabled;
  final Color disabledBg;
  final Color disabledText;

  final Color tabActiveBg;

  /// Выбранный сегмент переключателя (тема в настройках) поверх [key].
  final Color segmentSelected;

  /// Блок «TJ QR | QR рамзи ягона» и подложка вокруг QR на главной.
  final Color tjqrText;
  final Color qrBackdrop;

  // Статусы операций: фон чипа / текст / точка и полоса слева.
  final Color successBg;
  final Color successFg;
  final Color successDot;
  final Color cancelBg;
  final Color cancelFg;
  final Color cancelDot;
  final Color pendingBg;
  final Color pendingFg;
  final Color pendingDot;
  final Color refundBg;
  final Color refundFg;
  final Color refundDot;
  final Color unknownBg;
  final Color unknownFg;
  final Color unknownDot;

  static const light = AppColors(
    background: Color(0xFFF4F4F2),
    surface: Color(0xFFFFFFFF),
    surfacePressed: Color(0xFFFAFAF8),
    border: Color(0xFFE7E7E2),
    borderList: Color(0xFFE2E2DE),
    textPrimary: Color(0xFF16181A),
    textSecondary: Color(0xFF6B7075),
    textTertiary: Color(0xFF9AA0A6),
    accent: Color(0xFFE31E24),
    error: Color(0xFFB3352F),
    errorBg: Color(0xFFFDECEA),
    errorBorder: Color(0xFFE3A9A5),
    key: Color(0xFFEAEAE5),
    keyPressed: Color(0xFFE4E4DF),
    cellIdle: Color(0xFFD7D7D2),
    buttonPrimary: Color(0xFF16181A),
    buttonPrimaryText: Color(0xFFFFFFFF),
    buttonLoading: Color(0xFF2E3237),
    buttonDisabled: Color(0xFFE2E2DE),
    disabledBg: Color(0xFFF0F0EC),
    disabledText: Color(0xFFA6ABB0),
    tabActiveBg: Color(0xFFFDECEC),
    segmentSelected: Color(0xFFFFFFFF),
    tjqrText: Color(0xFF4F4F4F),
    qrBackdrop: Color(0x29898383),
    successBg: Color(0xFFE8F5F0),
    successFg: Color(0xFF0B7259),
    successDot: Color(0xFF0E8F6F),
    cancelBg: Color(0xFFFDECEA),
    cancelFg: Color(0xFFB3352F),
    cancelDot: Color(0xFFC9403A),
    pendingBg: Color(0xFFFFF6E5),
    pendingFg: Color(0xFF8A5A00),
    pendingDot: Color(0xFFD89A1F),
    refundBg: Color(0xFFEEF1FB),
    refundFg: Color(0xFF3B4E8F),
    refundDot: Color(0xFF5A6FB5),
    unknownBg: Color(0xFFF0F0EC),
    unknownFg: Color(0xFF6B7075),
    unknownDot: Color(0xFF9AA0A6),
  );

  /// Тёмная — по системным цветам Apple (HIG, Dark Mode): чёрный фон,
  /// карточки на ступень светлее, текст белый / systemGray, статусы —
  /// тёмные варианты systemGreen / systemRed / systemOrange / systemBlue.
  /// Фон чипа статуса — цвет статуса 18 % поверх карточки. Акцент — бренд.
  static const dark = AppColors(
    background: Color(0xFF000000),
    surface: Color(0xFF1C1C1E),
    surfacePressed: Color(0xFF2C2C2E),
    border: Color(0xFF2C2C2E),
    borderList: Color(0xFF2C2C2E),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF8E8E93),
    textTertiary: Color(0xFF636366),
    accent: Color(0xFFE31E24),
    error: Color(0xFFFF453A),
    errorBg: Color(0xFF452323),
    errorBorder: Color(0xFF8C2F29),
    key: Color(0xFF2C2C2E),
    keyPressed: Color(0xFF3A3A3C),
    cellIdle: Color(0xFF48484A),
    buttonPrimary: Color(0xFFFFFFFF),
    buttonPrimaryText: Color(0xFF000000),
    buttonLoading: Color(0xFFD1D1D6),
    buttonDisabled: Color(0xFF2C2C2E),
    disabledBg: Color(0xFF2C2C2E),
    disabledText: Color(0xFF636366),
    tabActiveBg: Color(0xFF441C1F),
    segmentSelected: Color(0xFF636366),
    tjqrText: Color(0xFFE5E5EA),
    qrBackdrop: Color(0xFF2C2C2E),
    successBg: Color(0xFF203D28),
    successFg: Color(0xFF30D158),
    successDot: Color(0xFF30D158),
    cancelBg: Color(0xFF452323),
    cancelFg: Color(0xFFFF6961),
    cancelDot: Color(0xFFFF453A),
    pendingBg: Color(0xFF453419),
    pendingFg: Color(0xFFFFB340),
    pendingDot: Color(0xFFFF9F0A),
    refundBg: Color(0xFF192F46),
    refundFg: Color(0xFF64A8FF),
    refundDot: Color(0xFF0A84FF),
    unknownBg: Color(0xFF2C2C2E),
    unknownFg: Color(0xFF8E8E93),
    unknownDot: Color(0xFF636366),
  );

  @override
  AppColors copyWith() => this;

  /// Плавный переход цветов при смене темы.
  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: c(background, other.background),
      surface: c(surface, other.surface),
      surfacePressed: c(surfacePressed, other.surfacePressed),
      border: c(border, other.border),
      borderList: c(borderList, other.borderList),
      textPrimary: c(textPrimary, other.textPrimary),
      textSecondary: c(textSecondary, other.textSecondary),
      textTertiary: c(textTertiary, other.textTertiary),
      accent: c(accent, other.accent),
      error: c(error, other.error),
      errorBg: c(errorBg, other.errorBg),
      errorBorder: c(errorBorder, other.errorBorder),
      key: c(key, other.key),
      keyPressed: c(keyPressed, other.keyPressed),
      cellIdle: c(cellIdle, other.cellIdle),
      buttonPrimary: c(buttonPrimary, other.buttonPrimary),
      buttonPrimaryText: c(buttonPrimaryText, other.buttonPrimaryText),
      buttonLoading: c(buttonLoading, other.buttonLoading),
      buttonDisabled: c(buttonDisabled, other.buttonDisabled),
      disabledBg: c(disabledBg, other.disabledBg),
      disabledText: c(disabledText, other.disabledText),
      tabActiveBg: c(tabActiveBg, other.tabActiveBg),
      segmentSelected: c(segmentSelected, other.segmentSelected),
      tjqrText: c(tjqrText, other.tjqrText),
      qrBackdrop: c(qrBackdrop, other.qrBackdrop),
      successBg: c(successBg, other.successBg),
      successFg: c(successFg, other.successFg),
      successDot: c(successDot, other.successDot),
      cancelBg: c(cancelBg, other.cancelBg),
      cancelFg: c(cancelFg, other.cancelFg),
      cancelDot: c(cancelDot, other.cancelDot),
      pendingBg: c(pendingBg, other.pendingBg),
      pendingFg: c(pendingFg, other.pendingFg),
      pendingDot: c(pendingDot, other.pendingDot),
      refundBg: c(refundBg, other.refundBg),
      refundFg: c(refundFg, other.refundFg),
      refundDot: c(refundDot, other.refundDot),
      unknownBg: c(unknownBg, other.unknownBg),
      unknownFg: c(unknownFg, other.unknownFg),
      unknownDot: c(unknownDot, other.unknownDot),
    );
  }
}

/// `context.colors.surface` — цвет из текущей темы.
extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
