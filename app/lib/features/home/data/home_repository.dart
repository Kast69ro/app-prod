import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_paths.dart';
import '../../../core/api/api_providers.dart';
import '../../../core/api/parse.dart';
import '../../../core/utils/date_format.dart';
import '../domain/home_models.dart';
import 'home_dtos.dart';

part 'home_repository.g.dart';

class HomeRepository {
  HomeRepository(this._api);

  final ApiClient _api;

  Future<TerminalInfo> getTerminal() async {
    final json = await _api.get(ApiPaths.terminal);
    return parseResponse(() => TerminalResponseDto.fromJson(json).toDomain());
  }

  /// Сводка за календарный день [day] (по часам телефона).
  Future<DaySummary> getSummary(DateTime day) async {
    final json = await _api.get(
      ApiPaths.summary,
      query: {'date': formatIsoDate(day)},
    );
    return parseResponse(() => SummaryDto.fromJson(json).toDomain());
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) =>
    HomeRepository(ref.watch(apiClientProvider));
