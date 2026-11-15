import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/phone_format.dart';
import '../../../core/widgets/brand_header.dart';
import '../../../core/widgets/confirm_logout.dart';
import '../../../core/widgets/text_link.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import 'biometric_controller.dart';
import 'pin_controller.dart';
import 'widgets/biometric_button.dart';
import 'widgets/biometric_offer_dialog.dart';
import 'widgets/pin_entry_view.dart';

/// Создание / подтверждение / ввод кода доступа. Прототип: стр. 176–211.
/// При вводе — ещё и вход по Face ID / отпечатку, если он включён.
class PinScreen extends ConsumerStatefulWidget {
  const PinScreen({super.key});

  @override
  ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen> {
  @override
  void initState() {
    super.initState();
    // Системное окно — сразу, как только экран кода показался.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && ref.read(pinControllerProvider).stage == PinStage.unlock) {
        _biometricUnlock();
      }
    });
  }

  /// Не прошло или отменили — ничего не показываем: человек вводит код.
  Future<void> _biometricUnlock() async {
    final l = AppLocalizations.of(context);
    await ref
        .read(biometricControllerProvider.notifier)
        .unlock(biometricPrompt(l, cancel: l.biometricUseCode));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(pinControllerProvider);
    final c = ref.read(pinControllerProvider.notifier);
    final session = ref.watch(sessionControllerProvider).value?.session;
    final bio = ref.watch(biometricControllerProvider).value;

    // Код подтверждён — спрашиваем про биометрию, потом сохраняем.
    ref.listen(pinControllerProvider.select((s) => s.offerBiometric), (
      _,
      kind,
    ) async {
      if (kind == null) return;
      final enable = await showBiometricOffer(context, kind);
      await c.finishSetup(
        enable: enable,
        prompt: biometricPrompt(l, cancel: l.cancel),
      );
    });

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

    final unlock = s.stage == PinStage.unlock;
    return PopScope(
      canPop: false,
      child: PinEntryView(
        header: const BrandHeader(),
        title: title,
        subtitle: subtitle,
        value: s.pin,
        error: pinErrorText(s.error, l),
        onKey: c.key,
        action: unlock && bio != null && bio.canUnlock
            ? BiometricButton(
                kind: bio.kind!,
                label: l.biometricUnlockLabel(bio.kind!),
                onTap: s.busy ? null : _biometricUnlock,
              )
            : null,
        footer: unlock
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
