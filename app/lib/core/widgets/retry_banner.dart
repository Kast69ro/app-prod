import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// Ошибка загрузки с кнопкой «Повторить». Не закрывает экран:
/// QR и сохранённые данные остаются видны.
class RetryBanner extends StatelessWidget {
  const RetryBanner({
    super.key,
    required this.text,
    required this.retryLabel,
    required this.onRetry,
  });

  final String text;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
        decoration: BoxDecoration(
          color: context.colors.errorBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusRow),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: context.colors.error,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                foregroundColor: context.colors.error,
                minimumSize: const Size(AppDimens.minTap, AppDimens.minTap),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
