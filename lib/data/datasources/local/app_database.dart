import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // Mobile (Android/iOS/macOS)
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lifeflow.sqlite'));
    return NativeDatabase(file);
  });
}
