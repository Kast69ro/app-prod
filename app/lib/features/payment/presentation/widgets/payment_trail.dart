import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/payment.dart';
import '../payment_status_style.dart';

/// «Ход операции» — как в прототипе (стр. 155–163): три шага с одним временем.
/// Отдельных времён шагов бэк не отдаёт (вопрос 5 в `docs/plan.md`).
class PaymentTrail extends StatelessWidget {
  const PaymentTrail({super.key, required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final status = PaymentStatusStyle.of(payment.status, l, context.colors);
    final time = payment.createdAt == null
        ? ''
        : formatTime(payment.createdAt!);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.borderList),
        borderRadius: BorderRadius.circular(AppDimens.radiusRow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              l.paymentTrail,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _Step(l.paymentTrailCreated, time, context.colors.unknownDot),
          const SizedBox(height: 12),
          _Step(l.paymentTrailScanned, time, context.colors.unknownDot),
          const SizedBox(height: 12),
          _Step(status.label, time, status.dot),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.name, this.time, this.dot);

  final String name;
  final String time;
  final Color dot;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dot,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 14, color: context.colors.textPrimary),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: AppTextStyles.monoCaption.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
