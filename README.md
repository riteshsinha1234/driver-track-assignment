# DriverTrack – Flutter Location Tracking App

DriverTrack is a Flutter-based location tracking application designed for Rider and Driver applications. It demonstrates location tracking, offline data storage, connectivity monitoring, and synchronization using a structured BLoC architecture.

## Features

- **Location Tracking:** Simulated GPS coordinates generated periodically for demonstration.
- **Offline Storage:** Stores location records locally using Hive.
- **Connectivity Monitoring:** Detects network connectivity changes.
- **Data Synchronization:** Attempts to synchronize pending location records when connectivity is available.
- **Retry Tracking:** Maintains a retry counter for unsuccessful synchronization attempts.
- **BLoC Architecture:** Separates application state management from business logic.
- **Local Data Recovery:** Pending records remain stored in Hive across application restarts.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter & Dart | Cross-platform application development |
| flutter_bloc | State management |
| Hive | Local database and offline storage |
| connectivity_plus | Network connectivity monitoring |
| HTTP | REST API integration |
| UUID | Unique location record identifiers |
| Sizer | Responsive UI layout |

## Project Architecture

The application follows a layered architecture:

```text
lib/
├── components/
│   └── bloc/
│       └── bloc_provider.dart
├── data/
│   ├── location/
│   │   ├── connectivity_service.dart
│   │   ├── location_service.dart
│   │   └── location_storage.dart
│   ├── models/
│   │   └── location_record.dart
│   ├── remote/
│   │   └── location_api.dart
│   └── repositories/
│       └── location_repository.dart
├── screens/
│   └── home/
│       ├── home_bloc.dart
│       ├── home_event.dart
│       └── home_state.dart
└── main.dart

test/
├── location_repository_test.dart
└── widget_test.dart
```

## Offline Storage and Synchronization

DriverTrack uses Hive to store location records locally.

Each location record contains:
- Unique record ID
- Latitude and longitude
- Location name
- Timestamp
- Synchronization status
- Retry count

The application follows an offline-first approach:

1. A location record is generated.
2. The record is saved locally in Hive.
3. If network connectivity is available, synchronization is attempted.
4. Successfully uploaded records are marked as synchronized.
5. Failed records remain pending for future synchronization.
6. When connectivity returns, pending records can be synchronized.

Hive persistence allows pending records to remain available after the application is closed and reopened.

## Background Location Tracking

For production Rider and Driver applications, background location tracking requires platform-specific configuration and permissions.

### Android

Background tracking can be implemented using an Android Foreground Service with location permissions.

Key considerations:
- Request appropriate foreground and background location permissions.
- Use a persistent notification while tracking is active.
- Configure the required foreground service permissions and service type.
- Handle Android background execution and battery restrictions.

Android may restrict or stop background location updates depending on OS version, permissions, battery optimization, and user settings.

### iOS

Background location tracking can be implemented using Apple's Core Location framework.

Key considerations:
- Configure the Location Updates background capability.
- Request appropriate location permissions, including Always authorization when required.
- Configure background location updates.
- Handle authorization changes and location service availability.

iOS controls background execution. Continuous tracking is not guaranteed in every application state. When a user force-quits an application, normal continuous background tracking generally stops until the application is opened again.

### Important Platform Limitations

| Application state | Android | iOS |
|---|---|---|
| App in foreground | Supported with permissions | Supported with permissions |
| App minimized | Foreground Service can support tracking | Background location capability can support tracking |
| Phone locked | Foreground Service can continue tracking | Background location updates can continue under OS rules |
| App force-stopped / terminated | Force-stop prevents normal tracking until reopened | Force-quit generally prevents continuous tracking until reopened |

Actual behavior depends on OS version, device manufacturer, permissions, battery settings, and platform policies.

**Note:** The current DriverTrack project uses simulated GPS coordinates for demonstration. Real background GPS tracking requires native platform configuration and an appropriate location service implementation.

## Running the Project

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Android Emulator or physical Android device

### Installation

Clone the repository:

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
```

Navigate to the project:

```bash
cd driver_track
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Running Tests

Execute the automated tests using:

```bash
flutter test
```

## Future Improvements

- Real GPS integration and background location tracking.
- Production REST API integration.
- Automatic retry with exponential backoff.
- Backend idempotency for duplicate prevention.
- Synchronization locking to prevent concurrent uploads.
- Expanded automated tests for offline persistence and synchronization recovery.

## Project Goal

The goal of DriverTrack is to demonstrate a reliable foundation for location tracking applications, with an emphasis on offline-first data handling, structured state management, local persistence, and synchronization.

