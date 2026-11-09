import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// Красный блок с текстом ошибки.
class ErrorBox extends StatelessWidget {
  const ErrorBox(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: context.colors.errorBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusRow),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            height: 1.45,
            color: context.colors.error,
          ),
        ),
      ),
    );
  }
}
