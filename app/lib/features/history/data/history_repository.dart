import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_paths.dart';
import '../../../core/api/api_providers.dart';
import '../../../core/api/parse.dart';
import '../../../core/utils/date_format.dart';
import '../../payment/domain/payment.dart';
import '../domain/history_feed.dart';
import '../domain/history_period.dart';
import 'history_dtos.dart';

part 'history_repository.g.dart';

class HistoryRepository {
  HistoryRepository(this._api);

  final ApiClient _api;

  /// Страница истории от новых к старым. [range] == `null` — за всё время.
  Future<HistoryPage> getPage({
    required int offset,
    int limit = ApiPaths.historyPageSize,
    DateRange? range,
  }) async {
    final json = await _api.get(
      ApiPaths.history,
      query: {
        // Один день — `date`, период — `from` и `to` (включительно).
        if (range != null && range.isSingleDay)
          'date': formatIsoDate(range.from)
        else if (range != null) ...{
          'from': formatIsoDate(range.from),
          'to': formatIsoDate(range.to),
        },
        'limit': limit,
        'offset': offset,
      },
    );
    return parseResponse(() => HistoryPageDto.fromJson(json).toDomain());
  }

  /// Все операции периода — для отчёта. Страницами по максимуму бэка;
  /// [HistoryFeed] убирает дубли, если платежи придут во время выгрузки.
  Future<List<Payment>> getAll(DateRange range) async {
    Future<HistoryPage> page(int offset) => getPage(
      offset: offset,
      limit: ApiPaths.historyMaxPageSize,
      range: range,
    );

    var feed = HistoryFeed.first(await page(0));
    while (feed.hasMore) {
      final next = await page(feed.nextOffset);
      // Бэк сказал «есть ещё», но ничего не прислал — не крутимся вечно.
      if (next.payments.isEmpty) break;
      feed = feed.append(next);
    }
    return feed.payments;
  }
}

@riverpod
HistoryRepository historyRepository(Ref ref) =>
    HistoryRepository(ref.watch(apiClientProvider));
