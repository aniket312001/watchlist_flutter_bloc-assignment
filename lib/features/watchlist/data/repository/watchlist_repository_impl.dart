import 'package:stock_market/features/watchlist/data/datasource/watchlist_remote_datasource.dart';
import 'package:stock_market/features/watchlist/domain/repositories/watchlist_repository.dart';

import '../../domain/entities/watchlist_entity.dart';
import '../../domain/entities/stock_entity.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;

  WatchlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<WatchlistEntity>> getWatchlists() async {
    return await remoteDataSource.fetchWatchlists();
  }
}
