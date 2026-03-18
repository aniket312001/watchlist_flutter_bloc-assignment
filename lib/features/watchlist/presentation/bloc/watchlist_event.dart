import 'package:stock_market/features/watchlist/domain/entities/stock_entity.dart';

abstract class WatchlistEvent {}

class LoadWatchlists extends WatchlistEvent {}

class ChangeWatchlist extends WatchlistEvent {
  final int index;
  ChangeWatchlist(this.index);
}

class UpdateWatchlist extends WatchlistEvent {
  final String id;
  final String name;
  final List<StockEntity> stocks;

  UpdateWatchlist({required this.id, required this.name, required this.stocks});
}

class StockUpdated extends WatchlistEvent {
  final StockEntity stock;
  StockUpdated(this.stock);
}
