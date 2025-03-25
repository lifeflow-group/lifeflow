import 'package:drift/drift.dart';

class HabitExceptionsTable extends Table {
  // Unique ID for the exception (UUID)
  TextColumn get id => text()();

  // Link to HabitSeries (similar to foreign key, but managed manually)
  TextColumn get habitSeriesId => text()();

  // Date of the exception (override or skip)
  DateTimeColumn get date => dateTime()();

  // If true => skip this day, do not display habit
  BoolColumn get isSkipped => boolean().withDefault(const Constant(false))();

  // Override notification for this instance
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();

  // Override target value (if needed)
  IntColumn get targetValue => integer().nullable()();

  // Individual progress (if needed)
  IntColumn get currentValue => integer().nullable()();

  // Mark completion for this instance (override completion)
  BoolColumn get isCompleted => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
