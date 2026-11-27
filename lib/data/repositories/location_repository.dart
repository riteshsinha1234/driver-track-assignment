import '../location/connectivity_service.dart';
import '../location/location_service.dart';
import '../location/location_storage.dart';
import '../models/location_record.dart';
import '../remote/location_api.dart';

class LocationRepository {
  final LocationService locationService;
  final ConnectivityService connectivityService;
  final LocationStorage locationStorage;
  final LocationApi locationApi;

  LocationRepository({
    required this.locationService,
    required this.connectivityService,
    required this.locationStorage,
    required this.locationApi,
  });

  // Start tracking and save every generated location.
  Future<void> startTracking() async {
    locationService.startTracking();
  }

  // Stop tracking.
  void stopTracking() {
    locationService.stopTracking();
  }

  // Listen to new location records.
  Stream<LocationRecord> get locationStream {
    return locationService.locationStream;
  }

  // Save a location locally first.
  Future<void> saveLocation(LocationRecord record) async {
    await locationStorage.saveLocation(record);

    // Attempt synchronization if internet is available.
    if (await connectivityService.checkConnection()) {
      await syncPendingLocations();
    }
  }

  // Get all recorded locations.
  List<LocationRecord> getAllLocations() {
    return locationStorage.getAllLocations();
  }

  // Get pending locations.
  List<LocationRecord> getPendingLocations() {
    return locationStorage.getPendingLocations();
  }

  // Synchronize pending records.
  Future<void> syncPendingLocations() async {
    if (!await connectivityService.checkConnection()) return;

    final pendingRecords = getPendingLocations();

    for (final record in pendingRecords) {
      try {
        final success = await locationApi.uploadLocation(record);

        if (success) {
          await locationStorage.updateLocation(record.copyWith(isSynced: true));
        } else {
          await locationStorage.updateLocation(
            record.copyWith(retryCount: record.retryCount + 1),
          );
        }
      } catch (_) {
        await locationStorage.updateLocation(
          record.copyWith(retryCount: record.retryCount + 1),
        );
      }
    }
  }

  // Release resources.
  Future<void> dispose() async {
    await locationService.dispose();
  }
}


