import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// Тёмная кнопка 58 px («Получить код», «Войти»).
/// Серая, когда [onPressed] == null; темнее и без нажатия, когда [loading].
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final active = onPressed != null || loading;
    final bg = loading
        ? context.colors.buttonLoading
        : active
        ? context.colors.buttonPrimary
        : context.colors.buttonDisabled;
    final fg = active ? context.colors.surface : context.colors.textTertiary;

    return Semantics(
      button: true,
      enabled: onPressed != null && !loading,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(AppDimens.radiusField),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimens.radiusField),
          onTap: loading ? null : onPressed,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimens.buttonHeight,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.button.copyWith(color: fg),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
