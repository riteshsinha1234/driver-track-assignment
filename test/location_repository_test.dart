import 'package:flutter_test/flutter_test.dart';
import 'package:driver_track/data/models/location_record.dart';

void main() {
  group('LocationRecord Tests', () {
    test('should convert LocationRecord to Map', () {
      final record = LocationRecord(
        id: 'test-001',
        latitude: 25.5941,
        longitude: 85.1376,
        timestamp: DateTime(2026, 11, 27),
      );

      final map = record.toMap();

      expect(map['id'], 'test-001');
      expect(map['latitude'], 25.5941);
      expect(map['longitude'], 85.1376);
      expect(map['isSynced'], false);
      expect(map['retryCount'], 0);
    });

    test('should create LocationRecord from Map', () {
      final map = {
        'id': 'test-002',
        'latitude': 25.5941,
        'longitude': 85.1376,
        'timestamp': '2026-11-27T10:00:00.000',
        'isSynced': true,
        'retryCount': 2,
      };

      final record = LocationRecord.fromMap(map);

      expect(record.id, 'test-002');
      expect(record.isSynced, true);
      expect(record.retryCount, 2);
    });

    test('should update sync status using copyWith', () {
      final record = LocationRecord(
        id: 'test-003',
        latitude: 25.5941,
        longitude: 85.1376,
        timestamp: DateTime(2026, 11, 27),
      );

      final updatedRecord = record.copyWith(isSynced: true, retryCount: 1);

      expect(updatedRecord.id, record.id);
      expect(updatedRecord.isSynced, true);
      expect(updatedRecord.retryCount, 1);
    });
  });
}
