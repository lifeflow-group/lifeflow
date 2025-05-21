import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../serializers.dart';

part 'habit_category.g.dart';

abstract class HabitCategory
    implements Built<HabitCategory, HabitCategoryBuilder> {
  String get id;

  String get name;

  String get iconPath;

  String get colorHex;

  HabitCategory._();
  factory HabitCategory([void Function(HabitCategoryBuilder) updates]) =
      _$HabitCategory;

  static Serializer<HabitCategory> get serializer => _$habitCategorySerializer;

  factory HabitCategory.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(HabitCategory.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(HabitCategory.serializer, this)
          as Map<String, dynamic>;

  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (id) {
      case 'health':
        return l10n.categoryHealth;
      case 'work':
        return l10n.categoryWork;
      case 'personal_growth':
        return l10n.categoryPersonalGrowth;
      case 'hobby':
        return l10n.categoryHobby;
      case 'fitness':
        return l10n.categoryFitness;
      case 'education':
        return l10n.categoryEducation;
      case 'finance':
        return l10n.categoryFinance;
      case 'social':
        return l10n.categorySocial;
      case 'spiritual':
        return l10n.categorySpiritual;
      default:
        return name;
    }
  }
}
