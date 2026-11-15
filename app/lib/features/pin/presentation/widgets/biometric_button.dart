import 'package:flutter/material.dart';

import '../../../../core/security/biometric_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';

/// «Войти по Face ID» / «Войти по отпечатку» под точками кода.
class BiometricButton extends StatelessWidget {
  const BiometricButton({
    super.key,
    required this.kind,
    required this.label,
    required this.onTap,
  });

  final BiometricKind kind;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.accent;
    return Center(
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    kind == BiometricKind.face
                        ? Icons.face_outlined
                        : Icons.fingerprint,
                    size: 24,
                    color: color,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 15, color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
