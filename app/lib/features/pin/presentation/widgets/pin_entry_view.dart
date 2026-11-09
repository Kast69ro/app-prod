import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/error_box.dart';
import '../../../../core/widgets/digit_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/pin_repository.dart';

/// Раскладка экрана кода: шапка, заголовок, точки, ошибка.
/// Ввод — с системной цифровой клавиатуры (см. [DigitInput]).
/// Общая для входа по коду и для смены кода в настройках.
class PinEntryView extends StatelessWidget {
  const PinEntryView({
    super.key,
    required this.header,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.error,
    required this.onKey,
    this.footer,
  });

  final Widget header;
  final String title;
  final String subtitle;

  /// Введённые цифры (на экране — закрашенные точки).
  final String value;
  final String? error;
  final ValueChanged<String?> onKey;

  /// Внизу, над клавиатурой, например «Выйти».
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            28,
            AppDimens.screenPadding,
            26,
          ),
          // Как в прототипе: текст сверху, клавиатура прижата к низу.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      header,
                      const SizedBox(height: 22),
                      Text(title, style: AppTextStyles.screenTitle),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: AppTextStyles.body.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Тап по точкам снова открывает клавиатуру,
                      // если её закрыли.
                      DigitInput(
                        value: value,
                        maxLength: pinLength,
                        onKey: onKey,
                        obscure: true,
                        child: SizedBox(
                          height: 48,
                          child: Center(
                            child: _PinDots(
                              filled: value.length,
                              hasError: error != null,
                              label: l.pinEntered(value.length, pinLength),
                            ),
                          ),
                        ),
                      ),
                      if (error != null) ...[
                        const SizedBox(height: 22),
                        ErrorBox(error!),
                      ],
                    ],
                  ),
                ),
              ),
              if (footer != null) ...[const SizedBox(height: 14), footer!],
            ],
          ),
        ),
      ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({
    required this.filled,
    required this.hasError,
    required this.label,
  });

  final int filled;
  final bool hasError;
  final String label;

  @override
  Widget build(BuildContext context) {
    final dots = <Widget>[];
    for (var i = 0; i < pinLength; i++) {
      if (i > 0) dots.add(const SizedBox(width: 14));
      final border = hasError
          ? context.colors.errorBorder
          : i == filled
          ? context.colors.accent
          : context.colors.cellIdle;
      dots.add(
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i < filled ? context.colors.textPrimary : Colors.transparent,
            border: Border.all(color: border, width: 1.5),
          ),
        ),
      );
    }
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: dots),
    );
  }
}
