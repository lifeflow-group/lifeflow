import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'habit_category.g.dart';

abstract class HabitCategory
    implements Built<HabitCategory, HabitCategoryBuilder> {
  String get id;

  String get label;

  String get iconPath;

  HabitCategory._();
  factory HabitCategory([void Function(HabitCategoryBuilder) updates]) =
      _$HabitCategory;

  static Serializer<HabitCategory> get serializer => _$habitCategorySerializer;

  factory HabitCategory.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitCategory.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitCategory.serializer, this)
          as Map<String, dynamic>;
}
