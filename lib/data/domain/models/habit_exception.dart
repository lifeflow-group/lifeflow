import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'habit_exception.g.dart';

abstract class HabitException
    implements Built<HabitException, HabitExceptionBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(HabitExceptionBuilder b) => b..isSkipped = false;

  /// Unique ID for the exception (UUID)
  String get id;

  /// ID of the HabitSeries associated with this exception
  String get habitSeriesId;

  /// The date the exception is applied (instance is overridden or skipped)
  DateTime get date;

  /// If true → skip this day, do not display the habit on that day
  bool get isSkipped;

  bool get reminderEnabled;

  int? get targetValue;

  int? get currentValue;

  bool? get isCompleted;

  HabitException._();

  factory HabitException([void Function(HabitExceptionBuilder) updates]) =
      _$HabitException;

  factory HabitException.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitException.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitException.serializer, this)
          as Map<String, dynamic>;

  static Serializer<HabitException> get serializer =>
      _$habitExceptionSerializer;
}
