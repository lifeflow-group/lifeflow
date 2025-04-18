import 'package:drift/drift.dart';

class HabitSeriesTable extends Table {
  // Unique ID for the series (UUID)
  TextColumn get id => text()();

  // User ID
  TextColumn get userId => text()();

  // Link to the original habit
  TextColumn get habitId => text()();

  // Start date of the series
  DateTimeColumn get startDate => dateTime()();

  // End date of the series (nullable)
  DateTimeColumn get untilDate => dateTime().nullable()();

  // Repeat rule: daily / weekly / monthly (Enum value converted to text)
  TextColumn get repeatFrequency => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
