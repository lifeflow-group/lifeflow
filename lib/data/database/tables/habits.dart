import 'package:drift/drift.dart';

import 'habit_categories.dart';

class HabitTable extends Table {
  TextColumn get id => text()(); // UUID

  TextColumn get name => text()();

  // Only store categoryId, FK to HabitCategories.id
  TextColumn get categoryId => text().references(HabitCategoryTable, #id)();

  DateTimeColumn get startDate => dateTime()();

  TextColumn get repeatFrequency => text().nullable()();

  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();

  TextColumn get trackingType => text()(); // complete / progress

  IntColumn get quantity => integer().nullable()();

  TextColumn get unit => text().nullable()();

  IntColumn get progress => integer().nullable()();

  BoolColumn get completed => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
