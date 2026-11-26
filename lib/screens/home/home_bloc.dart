import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());

      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(HomeLoaded(message: "Home Screen Loaded Successfully"));
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });
  }
}
