import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/presentation/bloc/navigation_event.dart';
import 'package:stock_market/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
