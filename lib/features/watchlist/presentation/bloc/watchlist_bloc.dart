import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/features/watchlist/data/datasource/stock_stream_price.dart';
import 'package:stock_market/features/watchlist/domain/usecases/get_watchlists_usecase.dart';
import '../../domain/entities/watchlist_entity.dart';
import '../../domain/entities/stock_entity.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistsUseCase getWatchlistsUseCase;
  StockPriceStream? _priceStream;
  StreamSubscription<StockEntity>? _subscription;

  WatchlistBloc({required this.getWatchlistsUseCase})
    : super(const WatchlistState(watchlists: [], selectedIndex: 0)) {
    on<LoadWatchlists>(_onLoad);
    on<ChangeWatchlist>(_onChangeWatchlist);
    on<UpdateWatchlist>(_onUpdateWatchlist);
    on<StockUpdated>(_onStockUpdated);
  }

  void _onLoad(LoadWatchlists event, Emitter<WatchlistState> emit) async {
    final data = await getWatchlistsUseCase();
    emit(state.copyWith(watchlists: data));

    if (data.isNotEmpty) {
      _subscribeToStocks(data.first.stocks);
    }
  }

  void _onChangeWatchlist(ChangeWatchlist event, Emitter<WatchlistState> emit) {
    if (state.watchlists.isEmpty) return;

    final selected = state.watchlists[event.index];

    // create new stock objects to force UI rebuild
    final stocks = selected.stocks.map((s) => s).toList();

    emit(
      state.copyWith(
        selectedIndex: event.index,
        watchlists: state.watchlists.map((w) {
          if (w.id == selected.id) {
            return WatchlistEntity(id: w.id, name: w.name, stocks: stocks);
          }
          return w;
        }).toList(),
      ),
    );

    _subscription?.cancel();
    _priceStream?.dispose(); // cancel old timer
    _subscribeToStocks(selected.stocks);
  }

  void _onUpdateWatchlist(UpdateWatchlist event, Emitter<WatchlistState> emit) {
    final updatedWatchlists = state.watchlists.map((w) {
      if (w.id == event.id) {
        return WatchlistEntity(
          id: w.id,
          name: event.name,
          stocks: event.stocks,
        );
      }
      return w;
    }).toList();

    final selected = updatedWatchlists[state.selectedIndex];

    emit(state.copyWith(watchlists: updatedWatchlists));

    _subscription?.cancel();
    _subscribeToStocks(selected.stocks);
  }

  void _onStockUpdated(StockUpdated event, Emitter<WatchlistState> emit) {
    print("state.selectedIndex - ${state.selectedIndex}");
    final updatedStocks = state.watchlists[state.selectedIndex].stocks.map((s) {
      if (s.id == event.stock.id) return event.stock;
      return s;
    }).toList();

    final updatedWatchlists = state.watchlists.map((w) {
      if (w.id == state.watchlists[state.selectedIndex].id) {
        print("updating");
        return WatchlistEntity(id: w.id, name: w.name, stocks: updatedStocks);
      }
      return w;
    }).toList();

    emit(state.copyWith(watchlists: updatedWatchlists));
  }

  void _subscribeToStocks(List<StockEntity> stocks) {
    _priceStream = StockPriceStream(stocks);
    _priceStream!.start();
    _subscription = _priceStream!.stream.listen((updatedStock) {
      add(StockUpdated(updatedStock));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _priceStream?.dispose();
    return super.close();
  }
}
