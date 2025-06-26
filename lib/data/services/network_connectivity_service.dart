import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/logger.dart';

// Provider to monitor connection status
final connectivityStatusProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(networkConnectivityProvider);

  // Returns a stream with boolean value (true = connected)
  return service.connectivityStream
      .map((status) => status != ConnectivityResult.none);
});

// Simpler provider to check current connection
final hasInternetProvider = FutureProvider<bool>((ref) {
  final service = ref.watch(networkConnectivityProvider);
  return service.isConnected();
});

final networkConnectivityProvider = Provider<NetworkConnectivityService>((ref) {
  return NetworkConnectivityService();
});

class NetworkConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final AppLogger _logger = AppLogger('NetworkConnectivityService');

  // Stream to listen for connectivity changes
  Stream<ConnectivityResult> get connectivityStream {
    // Convert Stream<List<ConnectivityResult>> to Stream<ConnectivityResult>
    return _connectivity.onConnectivityChanged.map((statuses) {
      // Check if the list contains any connection other than NONE
      if (statuses.contains(ConnectivityResult.ethernet) ||
          statuses.contains(ConnectivityResult.wifi) ||
          statuses.contains(ConnectivityResult.mobile)) {
        // Prioritize in the order: ethernet > wifi > mobile
        if (statuses.contains(ConnectivityResult.ethernet)) {
          return ConnectivityResult.ethernet;
        } else if (statuses.contains(ConnectivityResult.wifi)) {
          return ConnectivityResult.wifi;
        } else {
          return ConnectivityResult.mobile;
        }
      } else {
        // No connection
        return ConnectivityResult.none;
      }
    });
  }

  // Check current connectivity
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _logger.info("Connectivity check result: $result");

      // Check if the list of connections contains any type of connection other than NONE
      return result.contains(ConnectivityResult.ethernet) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile);
    } catch (e) {
      _logger.error("Error checking connectivity", e);
      return false;
    }
  }
}
