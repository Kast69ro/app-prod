import 'package:flutter/material.dart';

import '../../../../core/security/biometric_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../biometric_controller.dart';

/// «Входить по Face ID?» после создания кода. `true` — «Включить».
/// Закрыли кнопкой «Назад» — как «Не сейчас».
Future<bool> showBiometricOffer(
  BuildContext context,
  BiometricKind kind,
) async {
  final l = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: context.colors.surface,
      title: Text(l.biometricOfferTitle(kind)),
      content: Text(
        l.biometricOfferText,
        style: TextStyle(color: context.colors.textSecondary, height: 1.45),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: context.colors.textSecondary,
          ),
          child: Text(l.biometricOfferLater),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: context.colors.accent),
          child: Text(l.biometricOfferEnable),
        ),
      ],
    ),
  );
  return ok ?? false;
}
