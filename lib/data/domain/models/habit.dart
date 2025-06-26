import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import '../serializers.dart';
import 'category.dart';
import 'habit_series.dart';

part 'habit.g.dart';

class RepeatFrequency extends EnumClass {
  static const RepeatFrequency daily = _$daily;
  static const RepeatFrequency weekly = _$weekly;
  static const RepeatFrequency monthly = _$monthly;

  const RepeatFrequency._(super.name);

  static BuiltSet<RepeatFrequency> get values => _$repeatFrequencyValues;
  static RepeatFrequency valueOf(String name) => _$repeatFrequencyValueOf(name);

  String serialize() {
    return serializers.serializeWith(RepeatFrequency.serializer, this)
        as String;
  }

  static RepeatFrequency deserialize(String string) {
    return serializers.deserializeWith(RepeatFrequency.serializer, string)
        as RepeatFrequency;
  }

  static Serializer<RepeatFrequency> get serializer =>
      _$repeatFrequencySerializer;
}

class TrackingType extends EnumClass {
  static const TrackingType complete = _$complete;
  static const TrackingType progress = _$progress;

  const TrackingType._(super.name);

  static BuiltSet<TrackingType> get values => _$trackingTypeValues;
  static TrackingType valueOf(String name) => _$trackingTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(TrackingType.serializer, this) as String;
  }

  static TrackingType deserialize(String string) {
    return serializers.deserializeWith(TrackingType.serializer, string)
        as TrackingType;
  }

  static Serializer<TrackingType> get serializer => _$trackingTypeSerializer;
}

abstract class Habit implements Built<Habit, HabitBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(HabitBuilder b) => b
    ..date = DateTime.now().toUtc()
    ..trackingType = TrackingType.complete;

  String get id;

  String get name;

  String get userId;

  Category get category;

  DateTime get date; // use time in startDate

  HabitSeries? get series;

  bool get reminderEnabled;

  TrackingType get trackingType;

  int? get targetValue;

  int? get currentValue;

  String? get unit;

  bool? get isCompleted;

  Habit._();
  factory Habit([void Function(HabitBuilder) updates]) = _$Habit;

  factory Habit.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(Habit.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(Habit.serializer, this) as Map<String, dynamic>;

  static Serializer<Habit> get serializer => _$habitSerializer;
}
