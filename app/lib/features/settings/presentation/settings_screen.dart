import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/phone_format.dart';
import '../../../core/widgets/confirm_logout.dart';
import '../../../core/widgets/info_card.dart';
import '../../../core/widgets/text_link.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import 'theme_mode_controller.dart';
import 'widgets/theme_selector.dart';

/// Настройки: данные точки, тема, смена кода, выход.
/// Открываются тапом по логотипу на главной.
/// TODO: политика конфиденциальности и версия — ждут согласования пакетов.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider).value?.session;
    String orDash(String? v) => (v == null || v.isEmpty) ? '—' : v;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            8,
            AppDimens.screenPadding,
            24,
          ),
          children: [
            BackLink(label: l.back, onTap: () => context.pop()),
            const SizedBox(height: 4),
            Text(
              l.settingsTitle,
              style: AppTextStyles.screenTitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            InfoCard(
              children: [
                InfoRow(l.settingsTerminal, orDash(session?.terminalName)),
                InfoRow(l.settingsStore, orDash(session?.storeName)),
                InfoRow(l.settingsTerminalId, orDash(session?.terminalId)),
                InfoRow(
                  l.settingsPhone,
                  session == null ? '—' : formatPhoneHidden(session.phone),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ThemeSelector(
              value: ref.watch(themeModeControllerProvider),
              onChanged: ref.read(themeModeControllerProvider.notifier).select,
            ),
            const SizedBox(height: 12),
            _ActionRow(
              label: l.settingsChangePin,
              onTap: () => context.push(Routes.changePin),
            ),
            const SizedBox(height: 12),
            _ActionRow(
              label: l.logout,
              color: context.colors.error,
              showChevron: false,
              onTap: () async {
                if (await confirmLogout(context)) {
                  await ref.read(sessionControllerProvider.notifier).signOut();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.onTap,
    this.color,
    this.showChevron = true,
  });

  final String label;
  final VoidCallback onTap;

  /// По умолчанию — `textPrimary` из темы.
  final Color? color;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusRow),
      side: BorderSide(color: context.colors.borderList),
    );
    return Semantics(
      button: true,
      child: Material(
        color: context.colors.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          highlightColor: context.colors.disabledBg,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 52),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        color: color ?? context.colors.textPrimary,
                      ),
                    ),
                  ),
                  if (showChevron)
                    ExcludeSemantics(
                      child: Text(
                        '›',
                        style: TextStyle(
                          fontSize: 20,
                          color: context.colors.textTertiary,
                        ),
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
