class LocationRecord {
  // Unique identifier for every location record.
  final String id;

  // Driver's GPS coordinates.
  final double latitude;
  final double longitude;

  // Date and time when the location was recorded.
  final DateTime timestamp;

  // Synchronization status.
  final bool isSynced;

  // Number of failed synchronization attempts.
  final int retryCount;

  const LocationRecord({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.isSynced = false,
    this.retryCount = 0,
  });

  // Convert location record into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'isSynced': isSynced,
      'retryCount': retryCount,
    };
  }

  // Create a location record from a Map.
  factory LocationRecord.fromMap(Map<String, dynamic> map) {
    return LocationRecord(
      id: map['id'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      timestamp: DateTime.parse(map['timestamp'] as String),
      isSynced: map['isSynced'] as bool? ?? false,
      retryCount: map['retryCount'] as int? ?? 0,
    );
  }

  // Create an updated copy without changing the original record.
  LocationRecord copyWith({bool? isSynced, int? retryCount}) {
    return LocationRecord(
      id: id,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,
      isSynced: isSynced ?? this.isSynced,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}
