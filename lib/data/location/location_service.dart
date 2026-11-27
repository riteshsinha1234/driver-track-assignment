import 'dart:async';
import 'dart:math';

import 'package:uuid/uuid.dart';

import '../models/location_record.dart';

class LocationService {
  final Uuid _uuid = const Uuid();
  final Random _random = Random();

  Timer? _timer;
  final StreamController<LocationRecord> _locationController =
      StreamController<LocationRecord>.broadcast();

  bool _isTracking = false;

  bool get isTracking => _isTracking;

  Stream<LocationRecord> get locationStream => _locationController.stream;

  // Starting simulated location tracking.
  void startTracking() {
    if (_isTracking) return;

    _isTracking = true;

    // Generate the first location immediately.
    _generateLocation();

    // Generate a new location every 5 seconds.
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _generateLocation(),
    );
  }

  // Generate simulated GPS coordinates.
  void _generateLocation() {
    // Example starting coordinates near Patna.
    const baseLatitude = 25.5941;
    const baseLongitude = 85.1376;

    final latitude = baseLatitude + (_random.nextDouble() - 0.5) * 0.002;

    final longitude = baseLongitude + (_random.nextDouble() - 0.5) * 0.002;

    final record = LocationRecord(
      id: _uuid.v4(),
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
    );

    _locationController.add(record);
  }

  // Stop location tracking.
  void stopTracking() {
    _timer?.cancel();
    _timer = null;
    _isTracking = false;
  }

  // Release resources.
  Future<void> dispose() async {
    stopTracking();
    await _locationController.close();
  }
}
