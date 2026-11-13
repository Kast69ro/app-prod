import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/money_format.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../payment/domain/payment.dart';
import '../../../payment/presentation/payment_status_style.dart';
import '../../../payment/presentation/widgets/status_chip.dart';

/// Строка операции в истории. Прототип: стр. 94–103.
///
/// Слева полоса 3 px цвета статуса. В Flutter рамку разной толщины
/// со скруглением нарисовать нельзя, поэтому собираем из слоёв:
/// серая подложка (рамка 1 px) → полоса слева → белая карточка.
class HistoryRow extends StatelessWidget {
  const HistoryRow({super.key, required this.payment, this.onTap});

  final Payment payment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = payment;
    final status = PaymentStatusStyle.of(p.status, l, context.colors);
    final success = p.status == PaymentStatus.success;
    final time = p.createdAt == null ? '' : formatTime(p.createdAt!);

    return MergeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radiusRow),
        child: ColoredBox(
          color: context.colors.borderList,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 3, child: ColoredBox(color: status.dot)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 1, 1),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(AppDimens.radiusRow - 1),
                      ),
                      child: Material(
                        color: context.colors.surface,
                        child: InkWell(
                          onTap: onTap,
                          highlightColor: context.colors.surfacePressed,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: _Content(
                              amount: formatMoney(p.amount),
                              amountColor: success
                                  ? context.colors.textPrimary
                                  : context.colors.textSecondary,
                              status: status,
                              sender: p.sender,
                              time: time,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.amount,
    required this.amountColor,
    required this.status,
    required this.sender,
    required this.time,
  });

  final String amount;
  final Color amountColor;
  final PaymentStatusStyle status;
  final String sender;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Wrap: на узком экране с крупным шрифтом чип уходит на новую строку.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 6,
          children: [
            Text(
              amount,
              style: AppTextStyles.amountRow.copyWith(color: amountColor),
            ),
            StatusChip(style: status),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                sender,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.monoCaption.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              time,
              style: AppTextStyles.monoCaption.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
