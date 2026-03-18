import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/features/funds/presentation/screens/funds.dart';
import 'package:stock_market/features/gtts/presentation/screens/gtts_screen.dart';
import 'package:stock_market/features/orders/presentation/screens/orders.dart';
import 'package:stock_market/features/portfolio/presentation/screens/portfolio.dart';
import 'package:stock_market/features/profile/presentation/screens/profile.dart';
import 'package:stock_market/features/watchlist/presentation/screens/watchlist.dart';
import 'package:stock_market/presentation/bloc/navigation_bloc.dart';
import 'package:stock_market/presentation/bloc/navigation_event.dart';
import 'package:stock_market/presentation/bloc/navigation_state.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final screens = [
    WatchlistScreen(),
    OrdersScreen(),
    GttsScreen(),
    PortfolioScreen(),
    FundsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: screens[state.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(ChangeTabEvent(index));
            },
            selectedFontSize: 12,
            unselectedFontSize: 12,

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border_outlined),
                label: "Watchlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Orders",
              ),

              BottomNavigationBarItem(icon: Icon(Icons.bolt), label: "GTT+"),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "Portfolio",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: "Funds",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
