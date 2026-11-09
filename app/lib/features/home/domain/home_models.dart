import 'package:flutter/foundation.dart';

import '../../payment/domain/payment.dart';

/// Данные точки из `GET /pos/terminal`.
@immutable
class TerminalInfo {
  const TerminalInfo({
    required this.terminalName,
    required this.terminalPhone,
    required this.storeName,
    required this.terminalQR,
    required this.lastPayment,
  });

  final String terminalName;
  final String terminalPhone;
  final String storeName;

  /// Строка для статического QR («QR рамзи ягона»).
  final String terminalQR;
  final Payment? lastPayment;
}

@immutable
class Totals {
  const Totals({required this.count, required this.amount});

  final int count;
  final double amount;

  @override
  bool operator ==(Object other) =>
      other is Totals && other.count == count && other.amount == amount;

  @override
  int get hashCode => Object.hash(count, amount);
}

/// Сводка за день из `GET /pos/summary`. Считает бэк, фронт не суммирует.
@immutable
class DaySummary {
  const DaySummary({
    required this.success,
    required this.cancel,
    required this.refunded,
  });

  final Totals success;
  final Totals cancel;

  /// Появится, когда бэк добавит возвраты (`docs/refund_api_spec.md`).
  final Totals? refunded;
}
