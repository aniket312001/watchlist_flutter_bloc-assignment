import 'package:flutter/material.dart';
import 'package:stock_market/features/watchlist/domain/entities/stock_entity.dart';

class StockTile extends StatelessWidget {
  final StockEntity stock;
  final int index;

  const StockTile({super.key, required this.stock, required this.index});

  @override
  Widget build(BuildContext context) {
    final isProfit = stock.change >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          /// LEFT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  stock.exchange,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock.price.toStringAsFixed(2),
                style: TextStyle(
                  color: isProfit ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                style: TextStyle(
                  color: isProfit ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          /// DRAG HANDLE 👇
          ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
        ],
      ),
    );
  }
}
