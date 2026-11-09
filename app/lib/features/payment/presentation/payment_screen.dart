import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/money_format.dart';
import '../../../core/widgets/info_card.dart';
import '../../../core/widgets/sheet_page.dart';
import '../../../core/widgets/text_link.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import '../../receipt/data/receipt_sharer.dart';
import '../../receipt/domain/receipt.dart';
import '../../receipt/presentation/receipt_pdf.dart';
import '../domain/payment.dart';
import 'payment_status_style.dart';
import 'widgets/payment_actions.dart';
import 'widgets/payment_trail.dart';
import 'widgets/status_chip.dart';

/// Карточка операции. Прототип: `POS Terminal.dc.html`, стр. 135–174.
/// Вместо «Печать чека» — «Поделиться чеком» (только для оплаченных).
///
/// Открывается шторкой поверх истории (см. [SheetPage]): закрыть можно
/// свайпом вниз, тапом по затемнению или кнопкой «← Назад».
class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key, required this.payment});

  final Payment payment;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

enum _Share { idle, busy, failed }

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _shareKey = GlobalKey();
  var _share = _Share.idle;

  Future<void> _shareReceipt(Receipt receipt) async {
    setState(() => _share = _Share.busy);
    try {
      final l = AppLocalizations.of(context);
      final pdf = await ref.read(receiptPdfProvider).build(receipt, l);
      if (!mounted) return;

      // iPad открывает окно «Поделиться» стрелкой от кнопки.
      final button = _shareKey.currentContext?.findRenderObject() as RenderBox?;
      final origin = button == null
          ? null
          : button.localToGlobal(Offset.zero) & button.size;

      await ref
          .read(receiptSharerProvider)
          .share(pdf, fileName: _fileName(widget.payment), origin: origin);
      if (mounted) setState(() => _share = _Share.idle);
    } catch (_) {
      if (mounted) setState(() => _share = _Share.failed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider).value?.session;
    final p = widget.payment;
    final status = PaymentStatusStyle.of(p.status, l, context.colors);
    final at = p.createdAt;
    final terminalId = session?.terminalId ?? '';
    final terminalName = session?.terminalName ?? '';
    String orDash(String v) => v.isEmpty ? '—' : v;

    final receipt = Receipt(
      payment: p,
      storeName: session?.storeName ?? '',
      terminalName: terminalName,
      terminalId: terminalId,
    );

    return SheetScaffold(
      backgroundColor: context.colors.background,
      handleColor: context.colors.cellIdle,
      // Шапка — внутри списка: свайп вниз по ней тоже закрывает шторку.
      builder: (context, controller) => ListView(
        controller: controller,
        padding: EdgeInsets.zero,
        children: [
          _Header(
            backLabel: l.back,
            onBack: () => context.pop(),
            status: status,
            amount: formatMoney(p.amount),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InfoCard(
                  children: [
                    InfoRow(
                      l.paymentDate,
                      at == null ? '—' : formatDayMonth(at),
                    ),
                    InfoRow(l.paymentTime, at == null ? '—' : formatTime(at)),
                    if (p.isInternal) ...[
                      InfoRow(l.paymentPayer, p.sender),
                      InfoRow(l.receiptBank, l.paymentOurBank),
                      InfoRow(l.paymentTransfer, l.paymentTransferInternal),
                    ] else
                      InfoRow(l.paymentBank, p.sender),
                    // Как в прототипе: ID терминала, иначе название.
                    InfoRow(
                      l.settingsTerminal,
                      orDash(terminalId.isNotEmpty ? terminalId : terminalName),
                    ),
                    InfoRow(l.settingsStore, orDash(session?.storeName ?? '')),
                  ],
                ),
                const SizedBox(height: 12),
                PaymentTrail(payment: p),
              ],
            ),
          ),
        ],
      ),
      bottom: _Actions(
        children: [
          RefundButton(label: l.paymentRefund),
          if (p.status == PaymentStatus.success)
            ShareReceiptButton(
              key: _shareKey,
              label: switch (_share) {
                _Share.idle => l.paymentShare,
                _Share.busy => l.paymentSharing,
                _Share.failed => l.paymentShareError,
              },
              busy: _share == _Share.busy,
              failed: _share == _Share.failed,
              onTap: () => _shareReceipt(receipt),
            ),
        ],
      ),
    );
  }
}

/// `receipt_2026-09-08_1412` — имя файла без кириллицы и пробелов.
String _fileName(Payment p) {
  final at = p.createdAt;
  if (at == null) return 'receipt';
  final t = formatTime(at).replaceAll(':', '');
  return 'receipt_${formatIsoDate(at)}_$t';
}

class _Header extends StatelessWidget {
  const _Header({
    required this.backLabel,
    required this.onBack,
    required this.status,
    required this.amount,
  });

  final String backLabel;
  final VoidCallback onBack;
  final PaymentStatusStyle status;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(bottom: BorderSide(color: context.colors.borderList)),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: BackLink(label: backLabel, onTap: onBack),
                  ),
                  const SizedBox(width: 12),
                  StatusChip(style: status, large: true),
                ],
              ),
              const SizedBox(height: 12),
              // На узком экране с крупным шрифтом сумма уменьшается, а не обрезается.
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(amount, style: AppTextStyles.amountLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.colors.borderList)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                children[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
