import 'package:flutter/foundation.dart';

enum PaymentStatus {
  success,
  cancel,
  pending,
  refunded,
  refundPending,

  /// Статус, которого фронт не знает. Не считаем его оплатой.
  unknown;

  static PaymentStatus parse(String? raw) =>
      switch (raw?.trim().toLowerCase()) {
        'success' || 'ok' || 'paid' => success,
        'cancel' ||
        'cancelled' ||
        'canceled' ||
        'declined' ||
        'failed' ||
        'rejected' => cancel,
        'pending' || 'new' || 'processing' || 'created' => pending,
        'refunded' || 'refund' || 'reversed' => refunded,
        'refund_pending' => refundPending,
        _ => unknown,
      };
}

/// Откуда пришли деньги: из другого банка или со счёта клиента ActivBank.
enum PaymentType {
  /// Межбанк: в `sender` — название банка-отправителя.
  external,

  /// Внутри банка (us-on-us): в `sender` — имя плательщика.
  internal;

  /// Без поля `type` (старый бэк) — межбанк, как было до него.
  static PaymentType parse(String? raw) =>
      raw?.trim().toLowerCase() == 'internal' ? internal : external;
}

/// Входящий платёж по QR.
@immutable
class Payment {
  const Payment({
    required this.sender,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.senderBankId,
    this.type = PaymentType.external,
  });

  /// Банк-отправитель или, для [PaymentType.internal], имя плательщика
  /// (`—`, если бэк не прислал).
  final String sender;
  final PaymentType type;
  final int? senderBankId;

  /// Клиент ActivBank: в [sender] — имя человека, а не банк.
  bool get isInternal => type == PaymentType.internal;

  /// Сумма в TJS.
  final double amount;
  final PaymentStatus status;

  /// Местное время платежа; `null`, если бэк прислал битую дату.
  final DateTime? createdAt;

  @override
  bool operator ==(Object other) =>
      other is Payment &&
      other.sender == sender &&
      other.type == type &&
      other.senderBankId == senderBankId &&
      other.amount == amount &&
      other.status == status &&
      other.createdAt == createdAt;

  @override
  int get hashCode =>
      Object.hash(sender, type, senderBankId, amount, status, createdAt);
}
