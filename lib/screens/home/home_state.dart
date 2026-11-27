import '../../data/models/location_record.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String message;
  final bool isTracking;
  final bool isConnected;
  final List<LocationRecord> locations;
  final int totalLocations;
  final int pendingLocations;
  final int syncedLocations;

  HomeLoaded({
    this.message = '',
    this.isTracking = false,
    this.isConnected = true,
    this.locations = const [],
    this.totalLocations = 0,
    this.pendingLocations = 0,
    this.syncedLocations = 0,
  });
}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}
