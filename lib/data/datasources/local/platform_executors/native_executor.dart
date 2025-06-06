import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart'
    show DriftNativeOptions, driftDatabase;
import 'package:path_provider/path_provider.dart';

/// Create executor for native platforms
QueryExecutor createExecutor() {
  return driftDatabase(
    name: 'lifeflow',
    native: DriftNativeOptions(
        databaseDirectory: Platform.isAndroid
            ? getApplicationDocumentsDirectory
            : Platform.isIOS
                ? getApplicationSupportDirectory
                : () async => Directory.systemTemp),
  );
}
