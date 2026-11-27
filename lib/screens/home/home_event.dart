import '../../data/models/location_record.dart';

abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class StartTracking extends HomeEvent {}

class StopTracking extends HomeEvent {}

class LocationUpdated extends HomeEvent {
  final LocationRecord record;

  LocationUpdated(this.record);
}

class SyncLocations extends HomeEvent {}

class ConnectivityChanged extends HomeEvent {
  final bool isConnected;

  ConnectivityChanged(this.isConnected);
}
