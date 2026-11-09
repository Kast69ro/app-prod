import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/money_format.dart';
import '../../../core/utils/plural.dart';
import '../../../core/widgets/api_error_text.dart';
import '../../../core/widgets/retry_banner.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import 'home_providers.dart';
import 'widgets/last_payment_card.dart';
import 'widgets/qr_card.dart';
import 'widgets/stat_tile.dart';

/// Главная. Прототип: `POS Terminal.dc.html`, стр. 26–75.
///
/// Название, точка и QR берутся из сохранённой сессии — QR виден сразу,
/// даже без сети. С бэка подтягиваются свежие данные, сводка и последний платёж.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(terminalInfoProvider);
    ref.invalidate(todaySummaryProvider);
    await Future.wait([
      ref.read(terminalInfoProvider.future),
      ref.read(todaySummaryProvider.future),
    ]).catchError((_) => const <Object>[]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider).value?.session;
    final terminal = ref.watch(terminalInfoProvider);
    final summary = ref.watch(todaySummaryProvider).value;

    // Ошибку показываем, только когда загрузка закончилась.
    final error = [
      terminal,
      ref.watch(todaySummaryProvider),
    ].where((v) => v.hasError && !v.isLoading).map((v) => v.error!).firstOrNull;

    final merchant = (session?.storeName.isNotEmpty ?? false)
        ? session!.storeName
        : '—';
    final refunded = summary?.refunded;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.screenPadding,
              18,
              AppDimens.screenPadding,
              20,
            ),
            children: [
              _Header(
                title: (session?.terminalName.isNotEmpty ?? false)
                    ? session!.terminalName
                    : '—',
                terminalId: session?.terminalId ?? '—',
                merchant: merchant,
                settingsLabel: l.settingsTitle,
                onSettings: () => context.push(Routes.settings),
              ),
              if (error != null) ...[
                const SizedBox(height: 14),
                RetryBanner(
                  text: apiErrorText(error, l),
                  retryLabel: l.retry,
                  onRetry: () => _refresh(ref),
                ),
              ],
              const SizedBox(height: 20),
              QrCard(
                payload: session?.terminalQR,
                merchant: merchant,
                onOpen: () => context.push(Routes.qr),
              ),
              const SizedBox(height: 14),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: StatTile(
                        label: l.homeTodaySuccess,
                        amount: summary == null
                            ? '—'
                            : formatMoney(summary.success.amount),
                        count: summary == null
                            ? '—'
                            : paymentsCount(summary.success.count),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      // Пока бэк не отдаёт блок `refunded` — прочерк.
                      // Отклонённые (`cancel`) сюда не подставляем: это не возвраты.
                      child: StatTile(
                        label: l.homeTodayRefund,
                        amount: refunded == null
                            ? '—'
                            : formatMoney(refunded.amount),
                        count: refunded == null
                            ? '—'
                            : paymentsCount(refunded.count),
                        amountColor: context.colors.error,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              LastPaymentCard(
                payment: terminal.value?.lastPayment,
                onTap: () => context.go(Routes.history),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.terminalId,
    required this.merchant,
    required this.settingsLabel,
    required this.onSettings,
  });

  final String title;
  final String terminalId;
  final String merchant;
  final String settingsLabel;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.terminalTitle,
              ),
              const SizedBox(height: 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'ID $terminalId',
                    style: AppTextStyles.monoCaption.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      merchant,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // Лого — вход в настройки. Зона нажатия 44 px вокруг картинки 40 px.
        Semantics(
          button: true,
          label: settingsLabel,
          excludeSemantics: true,
          child: InkWell(
            onTap: onSettings,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/activbank-qr-app.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
