import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import '../serializers.dart';
import 'category.dart';
import 'suggestion.dart';

part 'habit_plan.g.dart';

abstract class HabitPlan implements Built<HabitPlan, HabitPlanBuilder> {
  String get id;

  String get title;

  Category get category;

  // Store format as Markdown
  String get description;

  String get imagePath;

  BuiltList<Suggestion> get suggestions;

  HabitPlan._();
  factory HabitPlan([void Function(HabitPlanBuilder) updates]) = _$HabitPlan;

  factory HabitPlan.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitPlan.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitPlan.serializer, this)
          as Map<String, dynamic>;

  static Serializer<HabitPlan> get serializer => _$habitPlanSerializer;
}
