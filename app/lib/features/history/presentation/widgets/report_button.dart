import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

/// «Отчёт в PDF» справа от заголовка истории. Пока отчёт готовится —
/// крутилка вместо иконки, повторное нажатие не срабатывает.
class ReportButton extends StatelessWidget {
  const ReportButton({super.key, required this.busy, required this.onTap});

  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return IconButton(
      tooltip: busy ? l.reportPreparing : l.reportExport,
      onPressed: busy ? null : onTap,
      color: context.colors.textPrimary,
      // Без серой «выключенной» иконки: вместо неё крутилка.
      disabledColor: context.colors.textPrimary,
      icon: busy
          ? const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2.4),
            )
          : const Icon(Icons.picture_as_pdf_outlined),
    );
  }
}
