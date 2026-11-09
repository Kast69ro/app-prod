import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';

/// «Выйти?» — после выхода снова нужен вход по SMS, поэтому переспрашиваем.
Future<bool> confirmLogout(BuildContext context) async {
  final l = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: context.colors.surface,
      title: Text(l.logoutConfirmTitle),
      content: Text(
        l.logoutConfirmText,
        style: TextStyle(color: context.colors.textSecondary, height: 1.45),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: context.colors.textSecondary,
          ),
          child: Text(l.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: context.colors.error),
          child: Text(l.logout),
        ),
      ],
    ),
  );
  return ok ?? false;
}
