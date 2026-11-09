import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// Текстовая кнопка по центру с зоной нажатия 44 px («Выйти» под клавиатурой).
class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
  });

  final String label;
  final VoidCallback onTap;

  /// По умолчанию — `textSecondary` из темы.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppDimens.minTap),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: color ?? context.colors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// «← Назад» из шапки карточки операции в прототипе (стр. 139).
class BackLink extends StatelessWidget {
  const BackLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Transform.translate(
        offset: const Offset(-14, 0),
        child: Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: AppDimens.minTap),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Align(
                  widthFactor: 1,
                  child: Text(
                    '← $label',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
