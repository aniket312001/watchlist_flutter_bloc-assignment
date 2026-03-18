import 'package:equatable/equatable.dart';
import 'package:stock_market/features/watchlist/domain/entities/stock_entity.dart';

class WatchlistEntity extends Equatable {
  final String id;
  final String name;
  final List<StockEntity> stocks;

  WatchlistEntity({required this.id, required this.name, required this.stocks});
  @override
  List<Object?> get props => [id, name, stocks];
}
