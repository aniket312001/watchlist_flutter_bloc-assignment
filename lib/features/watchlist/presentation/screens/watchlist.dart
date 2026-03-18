import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/theme/app_colors.dart';
import 'package:stock_market/core/widgets/common_button.dart';
import 'package:stock_market/core/widgets/common_divider.dart';
import 'package:stock_market/core/widgets/common_tabs.dart';
import 'package:stock_market/core/widgets/common_textfield.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:stock_market/features/watchlist/presentation/screens/edit_watchlist.dart';
import 'package:stock_market/features/watchlist/presentation/widgets/market_header.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MarketHeader(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const CommonTextField(
            hintText: "Search for instruments",
            prefixIcon: Icon(Icons.search),
          ),
        ),

        // ✅ Tabs
        BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return CommonTabs(
              tabs: state.watchlists.map((e) => e.name).toList(),
              selectedIndex: state.selectedIndex,
              onTap: (index) {
                context.read<WatchlistBloc>().add(ChangeWatchlist(index));
              },
            );
          },
        ),

        // ✅ Sort Button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonButton(
            onPressed: () {},
            color: AppColors.lightGrey,
            text: "Sort by",
            textColor: AppColors.primary,
            prefixIcon: Icon(
              Icons.format_align_left_sharp,
              color: AppColors.primary,
            ),
          ),
        ),
        const CommonDivider(),
        Expanded(
          child: BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const CommonDivider();
                },
                itemCount: state.watchlists.isNotEmpty
                    ? state.watchlists[state.selectedIndex].stocks.length
                    : 0,
                itemBuilder: (context, index) {
                  final stock = state.watchlists.isNotEmpty
                      ? state.watchlists[state.selectedIndex].stocks[index]
                      : null;
                  if (stock == null) return SizedBox.shrink();
                  return ListTile(
                    key: ValueKey(stock.id),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditWatchListScreen(
                            watchlist: state.watchlists[state.selectedIndex],
                          ),
                        ),
                      );
                    },

                    title: Text(
                      stock.name,
                      style: TextStyle(color: AppColors.primary),
                    ),
                    subtitle: Text(
                      stock.exchange,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          stock.price.toStringAsFixed(2).toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: stock.change > 0
                                ? AppColors.profit
                                : AppColors.loss,
                          ),
                        ),

                        Text(
                          "${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
