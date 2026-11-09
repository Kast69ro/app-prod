import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';

/// Вкладки «Главная» / «История» внизу экрана. Прототип: стр. 113–120.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: context.colors.background,
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border(top: BorderSide(color: context.colors.border)),
        ),
        child: SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 18),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 0),
            child: Row(
              children: [
                Expanded(
                  child: _Tab(
                    label: l.tabHome,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    active: shell.currentIndex == 0,
                    onTap: () => _go(0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _Tab(
                    label: l.tabHistory,
                    icon: Icons.history_rounded,
                    activeIcon: Icons.history_rounded,
                    active: shell.currentIndex == 1,
                    onTap: () => _go(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Повторный тап по активной вкладке возвращает её к началу.
  void _go(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = active ? context.colors.accent : context.colors.textTertiary;
    return Semantics(
      button: true,
      selected: active,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: active ? context.colors.tabActiveBg : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 58),
            child: Column(
              // min: иначе панель растягивается на весь экран.
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? activeIcon : icon, size: 22, color: fg),
                const SizedBox(height: 4),
                Text(
                  label,
                  textScaler: MediaQuery.textScalerOf(context)
                      .clamp(maxScaleFactor: 1.3),
                  style: TextStyle(fontSize: 12, color: fg),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
