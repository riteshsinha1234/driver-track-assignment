import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Check the current network connection.
  Future<bool> checkConnection() async {
    final results = await _connectivity.checkConnectivity();

    return _hasConnection(results);
  }

  // Listen for network connection changes.
  Stream<bool> get onConnectionChanged {
    return _connectivity.onConnectivityChanged.map(_hasConnection);
  }

  // Check whether any network interface is connected.
  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
