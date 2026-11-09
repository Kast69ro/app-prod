import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/payment.dart';

part 'payment_dto.freezed.dart';
part 'payment_dto.g.dart';

/// Платёж из `/pos/terminal` (`last_payment`) и `/pos/history` (`payments`).
@freezed
abstract class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    // `internal` — клиент нашего банка, `external` — межбанк.
    String? type,
    String? sender,
    @JsonKey(name: 'sender_bank_id') int? senderBankId,
    @Default(0) num amount,
    String? status,
    @JsonKey(name: 'creation_datetime') String? creationDatetime,
  }) = _PaymentDto;

  const PaymentDto._();

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);

  Payment toDomain() {
    final name = sender?.trim();
    return Payment(
      sender: (name == null || name.isEmpty) ? '—' : name,
      type: PaymentType.parse(type),
      senderBankId: senderBankId,
      amount: amount.toDouble(),
      status: PaymentStatus.parse(status),
      // Дата без часового пояса — это местное время банка.
      createdAt: creationDatetime == null
          ? null
          : DateTime.tryParse(creationDatetime!),
    );
  }
}
