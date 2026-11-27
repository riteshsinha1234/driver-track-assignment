import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/location_repository.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final LocationRepository locationRepository;

  TrackingBloc({required this.locationRepository}) : super(TrackingInitial()) {
    on<LoadTrackingRecords>(_onLoadTrackingRecords);
    on<RefreshTrackingRecords>(_onRefreshTrackingRecords);
  }

  Future<void> _onLoadTrackingRecords(
    LoadTrackingRecords event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLoading());

    try {
      final locations = locationRepository.getAllLocations();

      emit(TrackingLoaded(locations: locations));
    } catch (e) {
      emit(TrackingError(error: e.toString()));
    }
  }

  void _onRefreshTrackingRecords(
    RefreshTrackingRecords event,
    Emitter<TrackingState> emit,
  ) {
    try {
      final locations = locationRepository.getAllLocations();

      emit(TrackingLoaded(locations: locations));
    } catch (e) {
      emit(TrackingError(error: e.toString()));
    }
  }
}
