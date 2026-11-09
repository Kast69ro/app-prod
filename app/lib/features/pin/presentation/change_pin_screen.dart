import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/text_link.dart';
import '../../../l10n/app_localizations.dart';
import 'change_pin_controller.dart';
import 'pin_screen.dart';
import 'widgets/pin_entry_view.dart';

/// Смена кода входа из настроек.
class ChangePinScreen extends ConsumerWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(changePinControllerProvider);
    final c = ref.read(changePinControllerProvider.notifier);

    ref.listen(changePinControllerProvider, (prev, next) {
      if (next.stage == ChangePinStage.done) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.pinChanged)));
        Navigator.of(context).pop();
      }
    });

    final (title, subtitle) = switch (s.stage) {
      ChangePinStage.current => (l.pinTitleCurrent, l.pinSubCurrent),
      ChangePinStage.create => (l.pinTitleNew, l.pinSubCreate),
      ChangePinStage.confirm ||
      ChangePinStage.done => (l.pinTitleConfirm, l.pinSubConfirm),
    };

    return PinEntryView(
      header: BackLink(
        label: l.back,
        onTap: () => Navigator.of(context).maybePop(),
      ),
      title: title,
      subtitle: subtitle,
      value: s.pin,
      error: pinErrorText(s.error, l),
      onKey: c.key,
    );
  }
}
