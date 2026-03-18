import 'dart:async';
import '../../domain/entities/stock_entity.dart';

class StockPriceStream {
  List<StockEntity> _stocks;
  final StreamController<StockEntity> _controller =
      StreamController.broadcast();

  StockPriceStream(this._stocks);

  Stream<StockEntity> get stream => _controller.stream;
  Timer? _timer;

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      for (var i = 0; i < _stocks.length; i++) {
        final stock = _stocks[i];
        final change = ([-1, 1]..shuffle()).first * (0.5 + (5 * _random()));
        final newPrice = (stock.price + change).clamp(1, double.infinity);
        final percentChange = ((newPrice - stock.price) / stock.price) * 100;

        final updatedStock = StockEntity(
          id: stock.id,
          name: stock.name,
          exchange: stock.exchange,
          price: newPrice.toDouble(),
          change: change,
          percent: percentChange,
        );

        print("updatedStock - ${updatedStock.name} -${updatedStock.price}");

        _stocks[i] = updatedStock;
        _controller.add(updatedStock);
      }
    });
  }

  void updateStocks(List<StockEntity> newStocks) {
    _stocks = newStocks;
  }

  double _random() => (DateTime.now().microsecond % 100) / 100;
  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
