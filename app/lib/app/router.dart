import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/theme/app_colors.dart';
import '../core/widgets/sheet_page.dart';
import '../features/auth/domain/session.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/session_controller.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/home/presentation/qr_fullscreen_screen.dart';
import '../features/payment/domain/payment.dart';
import '../features/payment/presentation/payment_screen.dart';
import '../features/pin/presentation/change_pin_screen.dart';
import '../features/pin/presentation/pin_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import 'main_shell.dart';
import 'routes.dart';

export 'routes.dart';

part 'router.g.dart';

/// Куда пускать в зависимости от состояния сессии.
/// Вынесено отдельно, чтобы покрыть тестом.
String? redirectFor(AsyncValue<SessionState> session, String location) {
  final String target;
  if (session.isLoading && !session.hasValue) {
    target = Routes.splash;
  } else {
    final status = session.value?.status ?? AuthStatus.signedOut;
    target = switch (status) {
      AuthStatus.signedOut => Routes.login,
      AuthStatus.pinSetup || AuthStatus.locked => Routes.pin,
      AuthStatus.unlocked => Routes.home,
    };
  }
  // После входа можно ходить по внутренним экранам; до входа — только target.
  if (target == Routes.home) {
    const gates = {Routes.splash, Routes.login, Routes.pin};
    return gates.contains(location) ? Routes.home : null;
  }
  return location == target ? null : target;
}

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final rootKey = GlobalKey<NavigatorState>();

  // GoRouter пересчитывает redirect, когда меняется сессия.
  final refresh = ValueNotifier(0);
  ref.listen(sessionControllerProvider, (_, _) => refresh.value++);

  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) =>
        redirectFor(ref.read(sessionControllerProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) =>
            Scaffold(backgroundColor: context.colors.background),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.pin,
        // Ключ по статусу: после смены «создать» → «ввести» экран пересоздаётся.
        pageBuilder: (context, state) => NoTransitionPage(
          key: ValueKey(ref.read(sessionControllerProvider).value?.status),
          child: const PinScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomeScreen(),
                routes: [
                  // Поверх вкладок, без нижней панели.
                  GoRoute(
                    path: 'qr',
                    parentNavigatorKey: rootKey,
                    pageBuilder: (context, state) => CustomTransitionPage(
                      fullscreenDialog: true,
                      child: const QrFullscreenScreen(),
                      transitionsBuilder: (context, animation, _, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'settings',
                    parentNavigatorKey: rootKey,
                    builder: (context, state) => const SettingsScreen(),
                    routes: [
                      GoRoute(
                        path: 'pin',
                        parentNavigatorKey: rootKey,
                        builder: (context, state) => const ChangePinScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.history,
                builder: (context, state) => const HistoryScreen(),
                routes: [
                  // Платёж передаётся через `extra`: своего ID у него нет.
                  // Без `extra` (например, после восстановления) — в историю.
                  GoRoute(
                    path: 'payment',
                    parentNavigatorKey: rootKey,
                    redirect: (context, state) =>
                        state.extra is Payment ? null : Routes.history,
                    // Шторкой поверх истории, а не новой страницей.
                    pageBuilder: (context, state) => SheetPage(
                      key: state.pageKey,
                      child: PaymentScreen(payment: state.extra! as Payment),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
}
