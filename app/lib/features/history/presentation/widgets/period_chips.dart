import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/history_period.dart';

/// Ряд чипов периода под заголовком истории. Листается вбок.
/// Выбранный — красноватый, как активная вкладка.
class PeriodChips extends StatelessWidget {
  const PeriodChips({
    super.key,
    required this.selected,
    required this.customLabel,
    required this.onSelect,
    required this.onCustom,
  });

  final PeriodKind selected;

  /// Даты своего периода на чипе (`10.09 – 10.10`), если он выбран.
  final String? customLabel;
  final ValueChanged<PeriodKind> onSelect;

  /// «Период…» — экран сам откроет календарь.
  final VoidCallback onCustom;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    String label(PeriodKind k) => switch (k) {
      PeriodKind.all => l.periodAll,
      PeriodKind.today => l.periodToday,
      PeriodKind.yesterday => l.periodYesterday,
      PeriodKind.week => l.periodWeek,
      PeriodKind.month => l.periodMonth,
      PeriodKind.lastMonth => l.periodLastMonth,
      PeriodKind.custom => customLabel ?? l.periodCustom,
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
      child: Row(
        children: [
          for (final (i, k) in PeriodKind.values.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            _Chip(
              label: label(k),
              selected: k == selected,
              onTap: k == PeriodKind.custom ? onCustom : () => onSelect(k),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    const shape = StadiumBorder();
    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: selected ? c.tabActiveBg : c.surface,
        shape: shape.copyWith(
          side: BorderSide(color: selected ? c.accent : c.borderList),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppDimens.minTap),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                widthFactor: 1,
                child: Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected ? c.accent : c.textPrimary,
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
