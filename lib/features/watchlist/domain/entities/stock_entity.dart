import 'package:equatable/equatable.dart';

class StockEntity extends Equatable {
  final String id;
  final String name;
  final String exchange;
  final double price;
  final double change;
  final double percent;

  StockEntity({
    required this.id,
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.percent,
  });

  @override
  List<Object?> get props => [id, name, exchange, price, change, percent];
}
