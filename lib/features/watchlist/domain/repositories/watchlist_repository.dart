import 'package:stock_market/features/watchlist/domain/entities/watchlist_entity.dart';

abstract class WatchlistRepository {
  Future<List<WatchlistEntity>> getWatchlists();
}
