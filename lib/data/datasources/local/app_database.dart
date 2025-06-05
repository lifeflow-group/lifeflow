import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:path_provider/path_provider.dart';
import 'package:web/web.dart' as web;

import '../../services/analytics/analytics_service.dart';
import '../../services/analytics/firebase_analytics_service_backend.dart';
import 'dao/category_dao.dart';
import 'dao/habit_dao.dart';
import 'dao/habit_exception_dao.dart';
import 'dao/habit_series_dao.dart';
import 'tables/habit_exceptions_table.dart';
import 'tables/habit_series_table.dart';
import 'tables/habits_table.dart';
import 'tables/habit_categories_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  HabitsTable,
  HabitCategoriesTable,
  HabitSeriesTable,
  HabitExceptionsTable
], daos: [
  HabitDao,
  CategoryDao,
  HabitSeriesDao,
  HabitExceptionDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e])
      : super(
          e ??
              driftDatabase(
                name: 'lifeflow',
                native: const DriftNativeOptions(
                    databaseDirectory: getApplicationSupportDirectory),
                web: DriftWebOptions(
                  sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                  driftWorker: Uri.parse('drift_worker.js'),
                  onResult: (result) {
                    if (result.missingFeatures.isNotEmpty) {
                      debugPrint(
                        'Using ${result.chosenImplementation} due to unsupported '
                        'browser features: ${result.missingFeatures}',
                      );

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
                          web.window.navigator.userAgent);
                    }
                  },
                ),
              ),
        );

  AppDatabase.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;
}
