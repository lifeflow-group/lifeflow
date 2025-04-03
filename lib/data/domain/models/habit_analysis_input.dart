import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:uuid/uuid.dart';

import '../serializers.dart';
import 'habit.dart';
import 'habit_category.dart';
import 'habit_exception.dart';

part 'habit_analysis_input.g.dart';

abstract class HabitAnalysisInput
    implements Built<HabitAnalysisInput, HabitAnalysisInputBuilder> {
  // User ID to identify the habit list.
  String get userId;
  // Start date for analysis (beginning of the month)
  DateTime get startDate;
  // End date for analysis (end of the month)
  DateTime get endDate;

  // Optimized list of habits
  BuiltList<HabitData> get habits;

  HabitAnalysisInput._();

  factory HabitAnalysisInput(
          [void Function(HabitAnalysisInputBuilder) updates]) =
      _$HabitAnalysisInput;

  factory HabitAnalysisInput.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitAnalysisInput.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitAnalysisInput.serializer, this)
          as Map<String, dynamic>;

  static Serializer<HabitAnalysisInput> get serializer =>
      _$habitAnalysisInputSerializer;
}

abstract class HabitData implements Built<HabitData, HabitDataBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(HabitDataBuilder b) =>
      b..id = 'habit-${Uuid().v4()}';

  String get id;
  String get name;
  HabitCategory get category;
  TrackingType get trackingType;
  bool get reminderEnabled;

  // TrackingType = progress
  int? get targetValue;
  String? get unit;

  // Recurrence Rule
  RepeatFrequency? get repeatFrequency;
  DateTime get startDate;
  DateTime? get untilDate;

  // List of exceptions
  BuiltList<HabitException> get exceptions;

  // Should be calculated on the backend
  // PerformanceMetric get performanceMetric;

  HabitData._();

  factory HabitData([void Function(HabitDataBuilder) updates]) = _$HabitData;

  factory HabitData.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitData.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitData.serializer, this)
          as Map<String, dynamic>;

  static Serializer<HabitData> get serializer => _$habitDataSerializer;
}
