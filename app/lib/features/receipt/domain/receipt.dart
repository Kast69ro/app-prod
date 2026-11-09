import 'package:flutter/foundation.dart';

import '../../payment/domain/payment.dart';

/// Данные для чека: платёж + точка, где его приняли.
@immutable
class Receipt {
  const Receipt({
    required this.payment,
    required this.storeName,
    required this.terminalName,
    required this.terminalId,
  });

  final Payment payment;
  final String storeName;
  final String terminalName;
  final String terminalId;
}
