import 'package:freezed_annotation/freezed_annotation.dart';

import '../../payment/data/payment_dto.dart';
import '../domain/history_feed.dart';

part 'history_dtos.freezed.dart';
part 'history_dtos.g.dart';

/// Ответ `GET /pos/history`. Блок `terminal` здесь не нужен — его берёт главная.
@freezed
abstract class HistoryPageDto with _$HistoryPageDto {
  const factory HistoryPageDto({
    @Default(0) int total,
    @Default(0) int offset,
    @Default(<PaymentDto>[]) List<PaymentDto> payments,
  }) = _HistoryPageDto;

  const HistoryPageDto._();

  factory HistoryPageDto.fromJson(Map<String, dynamic> json) =>
      _$HistoryPageDtoFromJson(json);

  HistoryPage toDomain() => HistoryPage(
    total: total,
    offset: offset,
    payments: [for (final p in payments) p.toDomain()],
  );
}
