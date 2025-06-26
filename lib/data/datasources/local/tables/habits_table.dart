import 'package:drift/drift.dart';

import 'habit_categories_table.dart';

class HabitsTable extends Table {
  TextColumn get id => text()(); // UUID

  TextColumn get userId => text()();

  TextColumn get name => text()();

  // Only store categoryId, FK to HabitCategories.id
  TextColumn get categoryId => text().references(HabitCategoriesTable, #id)();

  DateTimeColumn get date => dateTime()();

  TextColumn get habitSeriesId => text().nullable()();

  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();

  TextColumn get trackingType => text()(); // complete / progress

  IntColumn get targetValue => integer().nullable()();

  IntColumn get currentValue => integer().nullable()();

  TextColumn get unit => text().nullable()();

  BoolColumn get isCompleted => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
