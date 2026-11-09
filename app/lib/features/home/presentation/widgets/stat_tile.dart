import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Плитка «Успешные за сегодня» / «Возврат за сегодня».
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.amount,
    required this.count,
    this.amountColor,
  });

  final String label;
  final String amount;
  final String count;

  /// По умолчанию — `textPrimary` из темы.
  final Color? amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.border),
        borderRadius: BorderRadius.circular(AppDimens.radiusTile),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: context.colors.textSecondary),
          ),
          const SizedBox(height: 8),
          // Длинная сумма уменьшается, а не переносится.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              amount,
              style: AppTextStyles.amountTile.copyWith(
                color: amountColor ?? context.colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: AppTextStyles.monoCaption.copyWith(
              color: context.colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
