import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationState()) {
    on<ChangeNavigationTab>(_onChangeNavigationTab);
  }

  void _onChangeNavigationTab(
    ChangeNavigationTab event,
    Emitter<BottomNavigationState> emit,
  ) {
    if (event.index < 0 || event.index > 1) return;

    emit(state.copyWith(selectedIndex: event.index));
  }
}
