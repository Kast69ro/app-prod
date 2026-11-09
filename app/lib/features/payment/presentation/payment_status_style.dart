import 'package:flutter/painting.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/payment.dart';

/// Подпись и цвета статуса: фон чипа, текст, точка / полоса слева.
class PaymentStatusStyle {
  const PaymentStatusStyle(this.label, this.bg, this.fg, this.dot);

  final String label;
  final Color bg;
  final Color fg;
  final Color dot;

  factory PaymentStatusStyle.of(
    PaymentStatus s,
    AppLocalizations l,
    AppColors c,
  ) => switch (s) {
    PaymentStatus.success => PaymentStatusStyle(
      l.statusSuccess,
      c.successBg,
      c.successFg,
      c.successDot,
    ),
    PaymentStatus.cancel => PaymentStatusStyle(
      l.statusCancel,
      c.cancelBg,
      c.cancelFg,
      c.cancelDot,
    ),
    PaymentStatus.pending => PaymentStatusStyle(
      l.statusPending,
      c.pendingBg,
      c.pendingFg,
      c.pendingDot,
    ),
    PaymentStatus.refunded => PaymentStatusStyle(
      l.statusRefunded,
      c.refundBg,
      c.refundFg,
      c.refundDot,
    ),
    PaymentStatus.refundPending => PaymentStatusStyle(
      l.statusRefundPending,
      c.pendingBg,
      c.pendingFg,
      c.pendingDot,
    ),
    PaymentStatus.unknown => PaymentStatusStyle(
      l.statusUnknown,
      c.unknownBg,
      c.unknownFg,
      c.unknownDot,
    ),
  };
}
