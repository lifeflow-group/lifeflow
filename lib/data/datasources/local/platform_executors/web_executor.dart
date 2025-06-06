import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift_flutter/drift_flutter.dart'
    show DriftWebOptions, driftDatabase;
import 'package:flutter/material.dart' show debugPrint;
import 'package:web/web.dart' show window;

import '../../../services/analytics/analytics_service.dart';
import '../../../services/analytics/firebase_analytics_service_backend.dart';

/// Create executor for web platform
QueryExecutor createExecutor() {
  return driftDatabase(
    name: 'lifeflow',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
      onResult: (result) {
        if (result.missingFeatures.isNotEmpty) {
          debugPrint(
              'Using ${result.chosenImplementation} due to unsupported browser features: ${result.missingFeatures}');

          // Log to analytics for remote visibility
          final analyticsService =
              AnalyticsService(FirebaseAnalyticsServiceBackend());

          // Convert Set<MissingBrowserFeature> to List<String>
          final missingFeaturesList = result.missingFeatures
              .map((feature) => feature.toString())
              .toList();

          analyticsService.trackWebDatabaseCompatibilityIssue(
              result.chosenImplementation.toString(),
              missingFeaturesList,
              window.navigator.userAgent);
        }
      },
    ),
  );
}
