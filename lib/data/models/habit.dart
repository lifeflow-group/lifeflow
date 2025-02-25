import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'habit.g.dart';

enum RepeatFrequency { daily, weekly, monthly }

enum TrackingType { complete, progress }

abstract class Habit implements Built<Habit, HabitBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(HabitBuilder b) => b
    ..startDate = DateTime.now().toUtc()
    ..trackingType = TrackingType.complete;

  String get id;

  String get name;

  String get category;

  DateTime get startDate; // use time in startDate

  RepeatFrequency? get repeatFrequency;

  bool get reminderEnabled;

  TrackingType get trackingType;

  int? get quantity;

  String? get unit;

  int? get progress;

  bool? get completed;

  Habit._();
  factory Habit([void Function(HabitBuilder) updates]) = _$Habit;

  factory Habit.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(Habit.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(Habit.serializer, this) as Map<String, dynamic>;

  static Serializer<Habit> get serializer => _$habitSerializer;
}
