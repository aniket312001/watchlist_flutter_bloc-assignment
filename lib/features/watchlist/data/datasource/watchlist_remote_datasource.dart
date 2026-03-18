import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/watchlist_entity.dart';

class WatchlistRemoteDataSource {
  Future<List<WatchlistEntity>> fetchWatchlists() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 300));

    return [
      WatchlistEntity(
        id: "1",
        name: "Watchlist 1",
        stocks: [
          StockEntity(
            id: "1",
            name: "TCS",
            exchange: "NSE",
            price: 3500,
            change: 20,
            percent: 0.5,
          ),
          StockEntity(
            id: "2",
            name: "INFY",
            exchange: "NSE",
            price: 1500,
            change: -10,
            percent: -0.6,
          ),
          StockEntity(
            id: "3",
            name: "HINDUNILVER",
            exchange: "NSE",
            price: 2100,
            change: -10,
            percent: -0.6,
          ),
          StockEntity(
            id: "444",
            name: "HDFCBANK",
            exchange: "NSE",
            price: 2100,
            change: -10,
            percent: -0.6,
          ),

          StockEntity(
            id: "4",
            name: "GOLDBEES",
            exchange: "NSE",
            price: 127,
            change: -10,
            percent: -0.6,
          ),
        ],
      ),
      WatchlistEntity(
        id: "9",
        name: "Watchlist 2",
        stocks: [
          StockEntity(
            id: "3",
            name: "RELIANCE",
            exchange: "NSE",
            price: 2500,
            change: 15,
            percent: 0.8,
          ),

          StockEntity(
            id: "43",
            name: "NEWSTOCK",
            exchange: "NSE",
            price: 1500,
            change: 15,
            percent: 0.8,
          ),
        ],
      ),
    ];
  }
}
