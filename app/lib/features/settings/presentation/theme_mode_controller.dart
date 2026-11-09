import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/theme_mode_repository.dart';

part 'theme_mode_controller.g.dart';

/// Текущая тема приложения. `MaterialApp` следит за ним и перерисовывается.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ref.watch(themeModeRepositoryProvider).read();

  /// Тема меняется сразу, сохранение — следом.
  Future<void> select(ThemeMode mode) async {
    if (mode == state) return;
    state = mode;
    await ref.read(themeModeRepositoryProvider).write(mode);
  }
}
