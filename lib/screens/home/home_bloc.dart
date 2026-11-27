import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/location_record.dart';
import '../../data/repositories/location_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocationRepository locationRepository;

  StreamSubscription<LocationRecord>? _locationSubscription;
  StreamSubscription<bool>? _connectivitySubscription;

  HomeBloc({required this.locationRepository}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<StartTracking>(_onStartTracking);
    on<StopTracking>(_onStopTracking);
    on<LocationUpdated>(_onLocationUpdated);
    on<SyncLocations>(_onSyncLocations);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      _locationSubscription ??= locationRepository.locationStream.listen((
        record,
      ) {
        add(LocationUpdated(record));
      });

      _connectivitySubscription ??= locationRepository
          .connectivityService
          .onConnectionChanged
          .listen((isConnected) {
            add(ConnectivityChanged(isConnected));
          });

      final isConnected = await locationRepository.connectivityService
          .checkConnection();

      if (isConnected) {
        await locationRepository.syncPendingLocations();
      }

      _emitLoaded(emit, isConnected: isConnected);
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  Future<void> _onStartTracking(
    StartTracking event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await locationRepository.startTracking();
      _emitLoaded(emit, message: 'Tracking started');
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void _onStopTracking(StopTracking event, Emitter<HomeState> emit) {
    locationRepository.stopTracking();
    _emitLoaded(emit, message: 'Tracking stopped');
  }

  Future<void> _onLocationUpdated(
    LocationUpdated event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await locationRepository.saveLocation(event.record);
      _emitLoaded(emit, message: 'Location saved');
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  Future<void> _onSyncLocations(
    SyncLocations event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await locationRepository.syncPendingLocations();
      _emitLoaded(emit, message: 'Synchronization completed');
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  Future<void> _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<HomeState> emit,
  ) async {
    if (event.isConnected) {
      await locationRepository.syncPendingLocations();
    }

    _emitLoaded(
      emit,
      isConnected: event.isConnected,
      message: event.isConnected ? 'Internet connected' : 'Offline',
    );
  }

  void _emitLoaded(
    Emitter<HomeState> emit, {
    String message = '',
    bool? isConnected,
  }) {
    final locations = locationRepository.getAllLocations();

    emit(
      HomeLoaded(
        message: message,
        isTracking: locationRepository.locationService.isTracking,
        isConnected:
            isConnected ??
            (state is HomeLoaded ? (state as HomeLoaded).isConnected : true),
        locations: locations,
        totalLocations: locations.length,
        pendingLocations: locations.where((record) => !record.isSynced).length,
        syncedLocations: locations.where((record) => record.isSynced).length,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _locationSubscription?.cancel();
    await _connectivitySubscription?.cancel();
    await super.close();
  }
}
