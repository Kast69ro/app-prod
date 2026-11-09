import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/widgets/qr_code_view.dart';
import '../../auth/presentation/session_controller.dart';
import '../data/home_repository.dart';
import '../domain/home_models.dart';

part 'home_providers.g.dart';

/// Данные точки с бэка. Заодно обновляет сессию: название, точку и QR
/// храним на устройстве, чтобы QR показывался сразу, даже без сети.
@riverpod
Future<TerminalInfo> terminalInfo(Ref ref) async {
  final info = await ref.watch(homeRepositoryProvider).getTerminal();

  final sessionCtl = ref.read(sessionControllerProvider.notifier);
  final session = ref.read(sessionControllerProvider).value?.session;
  if (session != null) {
    final updated = session.copyWith(
      terminalName: info.terminalName.isNotEmpty
          ? info.terminalName
          : session.terminalName,
      storeName: info.storeName.isNotEmpty ? info.storeName : session.storeName,
      terminalQR: info.terminalQR.isNotEmpty
          ? info.terminalQR
          : session.terminalQR,
    );
    if (updated != session) await sessionCtl.updateSession(updated);
  }
  return info;
}

/// Матрица QR, закешированная по строке: строится один раз на обоих экранах.
@riverpod
QrBuild qrBuild(Ref ref, String data) => QrBuild.from(data);

/// Сводка за сегодня.
@riverpod
Future<DaySummary> todaySummary(Ref ref) =>
    ref.watch(homeRepositoryProvider).getSummary(DateTime.now());
