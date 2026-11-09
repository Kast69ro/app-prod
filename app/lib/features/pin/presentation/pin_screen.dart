import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/phone_format.dart';
import '../../../core/widgets/brand_header.dart';
import '../../../core/widgets/confirm_logout.dart';
import '../../../core/widgets/text_link.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import 'pin_controller.dart';
import 'widgets/pin_entry_view.dart';

/// Создание / подтверждение / ввод кода доступа. Прототип: стр. 176–211.
class PinScreen extends ConsumerWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(pinControllerProvider);
    final c = ref.read(pinControllerProvider.notifier);
    final session = ref.watch(sessionControllerProvider).value?.session;

    final title = switch (s.stage) {
      PinStage.create => l.pinTitleCreate,
      PinStage.confirm => l.pinTitleConfirm,
      PinStage.unlock => l.pinTitleUnlock,
    };
    final subtitle = switch (s.stage) {
      PinStage.create => l.pinSubCreate,
      PinStage.confirm => l.pinSubConfirm,
      PinStage.unlock =>
        '${formatPhoneHidden(session?.phone ?? '')} · '
            '${(session?.terminalName.isNotEmpty ?? false) ? session!.terminalName : l.terminalFallback}',
    };

    return PopScope(
      canPop: false,
      child: PinEntryView(
        header: const BrandHeader(),
        title: title,
        subtitle: subtitle,
        value: s.pin,
        error: pinErrorText(s.error, l),
        onKey: c.key,
        footer: s.stage == PinStage.unlock
            ? TextLink(
                label: l.logout,
                onTap: () async {
                  if (await confirmLogout(context)) await c.signOut();
                },
              )
            : null,
      ),
    );
  }
}

String? pinErrorText(PinError? e, AppLocalizations l) => switch (e) {
  PinMismatch() => l.pinMismatch,
  PinWrongCode(:final attemptsLeft) => l.pinWrong(attemptsLeft),
  null => null,
};
