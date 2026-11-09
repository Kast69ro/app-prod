import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences.g.dart';

/// Ключи обычных настроек. Сюда — только то, что не жалко потерять
/// и не секретно (тема и т. п.). Сессия и код — в [SecureStore].
abstract final class PrefKeys {
  static const themeMode = 'abqr.theme_mode.v1';
}

/// Хранилище настроек. Открывается в `bootstrap` до первого кадра,
/// чтобы тема применилась сразу, без мигания светлым экраном.
@Riverpod(keepAlive: true)
SharedPreferences preferences(Ref ref) =>
    throw UnimplementedError('preferencesProvider задаётся в bootstrap');
