import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/theme/app_theme.dart';
import 'package:stock_market/features/watchlist/data/datasource/watchlist_remote_datasource.dart';
import 'package:stock_market/features/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:stock_market/features/watchlist/domain/usecases/get_watchlists_usecase.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:stock_market/presentation/bloc/navigation_bloc.dart';
import 'package:stock_market/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:stock_market/presentation/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),

        BlocProvider(
          create: (_) => WatchlistBloc(
            getWatchlistsUseCase: GetWatchlistsUseCase(
              WatchlistRepositoryImpl(
                remoteDataSource: WatchlistRemoteDataSource(),
              ),
            ),
          )..add(LoadWatchlists()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock Market',
        theme: AppTheme.lightTheme,
        home: MainScreen(),
      ),
    );
  }
}
