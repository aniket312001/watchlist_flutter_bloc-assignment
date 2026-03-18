import 'package:stock_market/features/watchlist/domain/entities/watchlist_entity.dart';
import 'package:stock_market/features/watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistsUseCase {
  final WatchlistRepository repository;

  GetWatchlistsUseCase(this.repository);

  Future<List<WatchlistEntity>> call() async {
    return await repository.getWatchlists();
  }
}
