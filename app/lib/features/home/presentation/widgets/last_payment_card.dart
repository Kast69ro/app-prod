import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/money_format.dart';
import '../../../../core/widgets/pressable_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../payment/domain/payment.dart';

/// «Последний платёж» — тап открывает историю.
class LastPaymentCard extends StatelessWidget {
  const LastPaymentCard({
    super.key,
    required this.payment,
    required this.onTap,
  });

  final Payment? payment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = payment;
    final success = p?.status == PaymentStatus.success;

    final String subtitle;
    if (p == null) {
      subtitle = l.homeNoPayments;
    } else {
      final time = p.createdAt == null ? '' : ' · ${formatTime(p.createdAt!)}';
      subtitle = '${p.sender}$time';
    }

    return PressableCard(
      radius: AppDimens.radiusTile,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      pressedColor: context.colors.background,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.homeLastPayment,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.monoCaption.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            // «+» только у зачисленного платежа.
            p == null
                ? '—'
                : success
                ? '+${formatMoney(p.amount)}'
                : formatMoney(p.amount),
            style: TextStyle(
              fontFeatures: AppFonts.tabular,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: success
                  ? context.colors.successDot
                  : context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
