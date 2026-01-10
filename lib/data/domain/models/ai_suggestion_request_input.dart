import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart' show BuildContext;

import '../../../src/generated/l10n/app_localizations.dart';
import '../serializers.dart';
import 'habit_analysis.dart';
import 'personalization_context.dart';

part 'ai_suggestion_request_input.g.dart';

abstract class AISuggestionRequestInput
    implements
        Built<AISuggestionRequestInput, AISuggestionRequestInputBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(AISuggestionRequestInputBuilder b) => b
    ..createdAt = DateTime.now().toUtc()
    ..dataSourceType = DataSourceType.both;

  String get id;
  String? get userId;
  DateTime get createdAt;

  DataSourceType get dataSourceType;

  PersonalizationContext get personalizationContext;

  HabitAnalysis? get habitAnalysis;

  AISuggestionRequestInput._();
  factory AISuggestionRequestInput(
          [void Function(AISuggestionRequestInputBuilder) updates]) =
      _$AISuggestionRequestInput;

  factory AISuggestionRequestInput.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(AISuggestionRequestInput.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(AISuggestionRequestInput.serializer, this)
          as Map<String, dynamic>;

  static Serializer<AISuggestionRequestInput> get serializer =>
      _$aISuggestionRequestInputSerializer;
}

class DataSourceType extends EnumClass {
  static const DataSourceType personalizationOnly = _$personalizationOnly;
  static const DataSourceType habitsOnly = _$habitsOnly;
  static const DataSourceType both = _$both;

  const DataSourceType._(super.name);

  String get displayName {
    switch (this) {
      case DataSourceType.personalizationOnly:
        return 'Personalization Only';
      case DataSourceType.habitsOnly:
        return 'Habits Only';
      case DataSourceType.both:
        return 'Both';
      default:
        return name
            .split(RegExp(r'(?=[A-Z])'))
            .map((s) => s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '')
            .join(' ');
    }
  }

  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case DataSourceType.personalizationOnly:
        return l10n.dataSourcePersonalizationOnly;
      case DataSourceType.habitsOnly:
        return l10n.dataSourceHabitsOnly;
      case DataSourceType.both:
        return l10n.dataSourceBoth;
      default:
        return displayName;
    }
  }

  static BuiltSet<DataSourceType> get values => _$dataSourceTypeValues;
  static DataSourceType valueOf(String name) => _$dataSourceTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(DataSourceType.serializer, this) as String;
  }

  static DataSourceType? deserialize(String? string) {
    if (string == null) return null;
    return serializers.deserializeWith(DataSourceType.serializer, string)
        as DataSourceType;
  }

  static Serializer<DataSourceType> get serializer =>
      _$dataSourceTypeSerializer;
}
