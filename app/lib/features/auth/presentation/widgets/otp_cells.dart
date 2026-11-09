import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

/// 6 ячеек SMS-кода. Активная — зелёная рамка, при ошибке все — красноватые.
class OtpCells extends StatelessWidget {
  const OtpCells({
    super.key,
    required this.code,
    required this.length,
    required this.hasError,
    required this.label,
  });

  final String code;
  final int length;
  final bool hasError;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) cells.add(const SizedBox(width: 6));
      final border = hasError
          ? context.colors.errorBorder
          : i == code.length
          ? context.colors.accent
          : context.colors.borderList;
      cells.add(
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 58),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: border, width: 1.5),
              borderRadius: BorderRadius.circular(AppDimens.radiusRow),
            ),
            child: Text(
              i < code.length ? code[i] : '',
              textScaler: MediaQuery.textScalerOf(context)
                  .clamp(maxScaleFactor: 1.3),
              style: TextStyle(
                fontFeatures: AppFonts.tabular,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
          ),
        ),
      );
    }
    return Semantics(
      label: label,
      value: '${code.length} / $length',
      excludeSemantics: true,
      child: Row(children: cells),
    );
  }
}
