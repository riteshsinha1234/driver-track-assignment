
import '../../data/models/location_record.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final List<LocationRecord> locations;

  TrackingLoaded({
    this.locations = const [],
  });

  int get totalRecords => locations.length;

  int get syncedRecords =>
      locations.where((record) => record.isSynced).length;

  int get pendingRecords =>
      locations.where((record) => !record.isSynced).length;
}

class TrackingError extends TrackingState {
  final String error;

  TrackingError({required this.error});
}
