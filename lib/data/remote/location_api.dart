import 'dart:math';

import '../models/location_record.dart';

class LocationApi {
  final Random _random = Random();

  // Stores IDs already accepted by the mock server.
  final Set<String> _uploadedIds = {};

  // Simulate uploading a location record.
  Future<bool> uploadLocation(LocationRecord record) async {
    // Simulate network request delay.
    await Future.delayed(const Duration(milliseconds: 800));

    // Prevent duplicate submissions.
    if (_uploadedIds.contains(record.id)) {
      return true;
    }

    // Simulate occasional API failure.
    final shouldFail = _random.nextInt(5) == 0;

    if (shouldFail) {
      return false;
    }

    // Mark record as uploaded on the mock server.
    _uploadedIds.add(record.id);

    return true;
  }

  // Upload multiple pending records.
  Future<List<String>> uploadLocations(List<LocationRecord> records) async {
    final successfulIds = <String>[];

    for (final record in records) {
      final success = await uploadLocation(record);

      if (success) {
        successfulIds.add(record.id);
      }
    }

    return successfulIds;
  }

  // Check uploaded record count.
  int get uploadedCount => _uploadedIds.length;
}
