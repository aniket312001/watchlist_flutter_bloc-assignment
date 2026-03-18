import 'package:equatable/equatable.dart';
import '../../domain/entities/watchlist_entity.dart';
import '../../domain/entities/stock_entity.dart';

class WatchlistState extends Equatable {
  final List<WatchlistEntity> watchlists;
  final int selectedIndex;

  const WatchlistState({required this.watchlists, required this.selectedIndex});

  WatchlistState copyWith({
    List<WatchlistEntity>? watchlists,
    int? selectedIndex,
  }) {
    return WatchlistState(
      watchlists: watchlists ?? this.watchlists,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [watchlists, selectedIndex];
}
