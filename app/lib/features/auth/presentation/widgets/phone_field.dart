import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/phone_format.dart';

/// Поле «+992 ·· ··· ·· ··». Ввод — с клавиатуры приложения, не системной.
class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.digits, required this.label});

  final String digits;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ready = digits.length == phoneDigits;
    return Semantics(
      label: label,
      value: '$phoneCountryCode $digits',
      excludeSemantics: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 60),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(
            color: ready ? context.colors.accent : context.colors.borderList,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusField),
        ),
        child: Row(
          children: [
            Text(
              phoneCountryCode,
              style: AppTextStyles.monoCaption.copyWith(
                color: context.colors.textSecondary,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  formatPhoneMask(digits),
                  style: TextStyle(
                    fontFeatures: AppFonts.tabular,
                    fontSize: 18,
                    letterSpacing: 2.16,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
