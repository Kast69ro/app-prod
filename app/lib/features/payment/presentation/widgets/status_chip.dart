import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../payment_status_style.dart';

/// Чип статуса операции: «Оплачено», «Отклонён»…
/// [large] — в шапке карточки операции (28 px вместо 26).
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.style, this.large = false});

  final PaymentStatusStyle style;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Container(
      // С крупным системным шрифтом чип растёт по высоте.
      constraints: BoxConstraints(minHeight: large ? 28 : 26),
      padding: EdgeInsets.symmetric(horizontal: large ? 11 : 10, vertical: 3),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(AppDimens.radiusChip),
      ),
      // widthFactor: 1 — чип по ширине текста. `Container.alignment` растянул
      // бы его на всю доступную ширину.
      child: Align(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          style.label,
          style: TextStyle(fontSize: 13, color: style.fg),
        ),
      ),
    );
  }
}
