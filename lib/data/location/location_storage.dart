import 'package:hive_flutter/hive_flutter.dart';
import '../models/location_record.dart';

class LocationStorage {
  static const String _boxName = 'location_records';

  late Box<Map> _locationBox;

  // Initialize local database.
  Future<void> init() async {
    await Hive.initFlutter();
    _locationBox = await Hive.openBox<Map>(_boxName);
  }

  // Save a new location record.
  Future<void> saveLocation(LocationRecord record) async {
    await _locationBox.put(record.id, record.toMap());
  }

  // Get all recorded locations.
  List<LocationRecord> getAllLocations() {
    return _locationBox.values
        .map(
          (record) => LocationRecord.fromMap(Map<String, dynamic>.from(record)),
        )
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Get locations waiting for synchronization.
  List<LocationRecord> getPendingLocations() {
    return getAllLocations().where((record) => !record.isSynced).toList();
  }

  // Update an existing location record.
  Future<void> updateLocation(LocationRecord record) async {
    await _locationBox.put(record.id, record.toMap());
  }

  // Get total number of recorded locations.
  int getTotalCount() {
    return _locationBox.length;
  }

  // Get number of pending records.
  int getPendingCount() {
    return getPendingLocations().length;
  }

  // Close local database.
  Future<void> close() async {
    if (_locationBox.isOpen) {
      await _locationBox.close();
    }
  }
}
