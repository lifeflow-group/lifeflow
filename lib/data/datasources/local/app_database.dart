import 'package:drift/drift.dart';

// Conditionally import to avoid platform-incompatible import errors
import 'platform_executors/native_executor.dart'
    if (dart.library.html) 'platform_executors/web_executor.dart';
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
  AppDatabase([QueryExecutor? e]) : super(e ?? createExecutor());

  AppDatabase.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;
}
