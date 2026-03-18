import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/theme/app_colors.dart';
import 'package:stock_market/core/widgets/common_button.dart';
import 'package:stock_market/core/widgets/common_textfield.dart';
import 'package:stock_market/features/watchlist/domain/entities/stock_entity.dart';
import 'package:stock_market/features/watchlist/domain/entities/watchlist_entity.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_event.dart';

class EditWatchListScreen extends StatefulWidget {
  const EditWatchListScreen({super.key, required this.watchlist});

  final WatchlistEntity watchlist;

  @override
  State<EditWatchListScreen> createState() => _EditWatchListScreenState();
}

class _EditWatchListScreenState extends State<EditWatchListScreen> {
  late TextEditingController _controller;
  List<StockEntity> stocks = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.watchlist.name);

    stocks = List.from(widget.watchlist.stocks);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Edit ${widget.watchlist.name}"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CommonTextField(
                controller: _controller,
                hintText: "Watchlist Name",
                suffixIcon: Icon(Icons.edit, color: AppColors.grey),
              ),
            ),

            Expanded(
              child: ReorderableListView.builder(
                itemCount: stocks.length,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex--;
                  final item = stocks.removeAt(oldIndex);
                  stocks.insert(newIndex, item);
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  final stock = stocks[index];
                  return ListTile(
                    key: ValueKey(stock.id),
                    leading: const Icon(Icons.drag_handle),
                    title: Text(stock.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColors.primary),
                          onPressed: () {
                            setState(() {
                              stocks.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      type: CommonButtonType.outline,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.lightGrey,
                      text: "Cancel",
                      textColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      type: CommonButtonType.filled,
                      onPressed: () {
                        // Update the watchlist in the Bloc
                        context.read<WatchlistBloc>().add(
                          UpdateWatchlist(
                            id: widget.watchlist.id,
                            name: _controller.text,
                            stocks: stocks,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      color: AppColors.primary,
                      text: "Save Watchlist",
                      textColor: AppColors.background,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
