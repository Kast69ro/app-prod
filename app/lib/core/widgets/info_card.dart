import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// Белая карточка с полями «название — значение»:
/// реквизиты операции и данные точки в настройках.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.children, this.gap = 14});

  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) spaced.add(SizedBox(height: gap));
      spaced.add(children[i]);
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.borderList),
        borderRadius: BorderRadius.circular(AppDimens.radiusRow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: spaced,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow(this.label, this.value, {super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    // Подпись — не шире половины строки (с крупным шрифтом переносится),
    // значение занимает всё остальное.
    return MergeSemantics(
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth / 2),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFeatures: AppFonts.tabular,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
