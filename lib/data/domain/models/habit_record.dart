import '../../datasources/local/app_database.dart';

/// A complete habit record including category and series data
class HabitRecord {
  final HabitsTableData habit;
  final HabitCategoriesTableData category;
  final HabitSeriesTableData? series;

  const HabitRecord({
    required this.habit,
    required this.category,
    this.series,
  });

  factory HabitRecord.fromTuple(
      (
        HabitsTableData,
        HabitCategoriesTableData,
        HabitSeriesTableData?
      ) tuple) {
    return HabitRecord(habit: tuple.$1, category: tuple.$2, series: tuple.$3);
  }
}
