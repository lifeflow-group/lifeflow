import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'habit.dart';

part 'habit_series.g.dart';

abstract class HabitSeries implements Built<HabitSeries, HabitSeriesBuilder> {
  // Default initialization
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(HabitSeriesBuilder b) => b
    ..startDate = DateTime.now().toUtc()
    ..repeatFrequency = RepeatFrequency.daily;

  // UUID of the series, not the original habit
  String get id;

  // User ID
  String get userId;

  // Link to the original Habit (like a foreign key)
  String get habitId;

  // Start date of the series
  DateTime get startDate;

  // End date, null if not limited
  DateTime? get untilDate;

  // daily / weekly / monthly...
  RepeatFrequency get repeatFrequency;

  HabitSeries._();

  factory HabitSeries([void Function(HabitSeriesBuilder) updates]) =
      _$HabitSeries;

  factory HabitSeries.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitSeries.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitSeries.serializer, this)
          as Map<String, dynamic>;

  static Serializer<HabitSeries> get serializer => _$habitSeriesSerializer;
}
