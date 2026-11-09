import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/session_controller.dart';

/// Через сколько в фоне снова спрашивать код. Короткие отлучки
/// (окно «Поделиться», входящий звонок) не блокируют.
const autoLockAfter = Duration(seconds: 30);

/// Блокирует приложение, если оно пробыло в фоне дольше [autoLockAfter].
/// TODO(security): блокировка по бездействию на открытом экране.
class AutoLock extends ConsumerStatefulWidget {
  const AutoLock({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AutoLock> createState() => _AutoLockState();
}

class _AutoLockState extends ConsumerState<AutoLock> {
  late final AppLifecycleListener _listener;
  DateTime? _hiddenAt;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onHide: () => _hiddenAt ??= DateTime.now(),
      onShow: _onShow,
    );
  }

  void _onShow() {
    final hiddenAt = _hiddenAt;
    _hiddenAt = null;
    if (hiddenAt == null) return;
    if (DateTime.now().difference(hiddenAt) >= autoLockAfter) {
      ref.read(sessionControllerProvider.notifier).lock();
    }
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
