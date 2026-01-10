import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart' show BuildContext;

import '../../../src/generated/l10n/app_localizations.dart';
import '../serializers.dart';

part 'personalization_context.g.dart';

abstract class PersonalizationContext
    implements Built<PersonalizationContext, PersonalizationContextBuilder> {
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(PersonalizationContextBuilder b) => b..goals = '';

  String get goals;
  PersonalityType? get personalityType;
  TimePreference? get timePreference;
  GuidanceLevel? get guidanceLevel;

  PersonalizationContext._();
  factory PersonalizationContext(
          [void Function(PersonalizationContextBuilder) updates]) =
      _$PersonalizationContext;

  factory PersonalizationContext.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(PersonalizationContext.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(PersonalizationContext.serializer, this)
          as Map<String, dynamic>;

  static Serializer<PersonalizationContext> get serializer =>
      _$personalizationContextSerializer;
}

class PersonalityType extends EnumClass {
  static const PersonalityType introverted = _$introverted;
  static const PersonalityType extroverted = _$extroverted;
  static const PersonalityType disciplined = _$disciplined;
  static const PersonalityType creative = _$creative;
  static const PersonalityType analytical = _$analytical;

  const PersonalityType._(super.name);

  String get displayName {
    switch (this) {
      case PersonalityType.introverted:
        return 'Introverted';
      case PersonalityType.extroverted:
        return 'Extroverted';
      case PersonalityType.disciplined:
        return 'Disciplined';
      case PersonalityType.creative:
        return 'Creative';
      case PersonalityType.analytical:
        return 'Analytical';
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
      case PersonalityType.introverted:
        return l10n.personalityIntroverted;
      case PersonalityType.extroverted:
        return l10n.personalityExtroverted;
      case PersonalityType.disciplined:
        return l10n.personalityDisciplined;
      case PersonalityType.creative:
        return l10n.personalityCreative;
      case PersonalityType.analytical:
        return l10n.personalityAnalytical;
      default:
        return displayName;
    }
  }

  static BuiltSet<PersonalityType> get values => _$personalityTypeValues;
  static PersonalityType valueOf(String name) => _$personalityTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(PersonalityType.serializer, this)
        as String;
  }

  static PersonalityType? deserialize(String? string) {
    if (string == null) return null;
    return serializers.deserializeWith(PersonalityType.serializer, string)
        as PersonalityType;
  }

  static Serializer<PersonalityType> get serializer =>
      _$personalityTypeSerializer;
}

class TimePreference extends EnumClass {
  static const TimePreference morning = _$morning;
  static const TimePreference noon = _$noon;
  static const TimePreference afternoon = _$afternoon;
  static const TimePreference evening = _$evening;
  static const TimePreference flexible = _$flexible;

  const TimePreference._(super.name);

  String get displayName {
    switch (this) {
      case TimePreference.morning:
        return 'Morning';
      case TimePreference.noon:
        return 'Noon';
      case TimePreference.afternoon:
        return 'Afternoon';
      case TimePreference.evening:
        return 'Evening';
      case TimePreference.flexible:
        return 'Flexible';
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
      case TimePreference.morning:
        return l10n.timeMorning;
      case TimePreference.noon:
        return l10n.timeNoon;
      case TimePreference.afternoon:
        return l10n.timeAfternoon;
      case TimePreference.evening:
        return l10n.timeEvening;
      case TimePreference.flexible:
        return l10n.timeFlexible;
      default:
        return displayName;
    }
  }

  static BuiltSet<TimePreference> get values => _$timePreferenceValues;
  static TimePreference valueOf(String name) => _$timePreferenceValueOf(name);

  String serialize() {
    return serializers.serializeWith(TimePreference.serializer, this) as String;
  }

  static TimePreference? deserialize(String? string) {
    if (string == null) return null;
    return serializers.deserializeWith(TimePreference.serializer, string)
        as TimePreference;
  }

  static Serializer<TimePreference> get serializer =>
      _$timePreferenceSerializer;
}

class GuidanceLevel extends EnumClass {
  static const GuidanceLevel simple = _$simple;
  static const GuidanceLevel intermediate = _$intermediate;
  static const GuidanceLevel advanced = _$advanced;

  const GuidanceLevel._(super.name);

  String get displayName {
    switch (this) {
      case GuidanceLevel.simple:
        return 'Simple';
      case GuidanceLevel.intermediate:
        return 'Intermediate';
      case GuidanceLevel.advanced:
        return 'Advanced';
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
      case GuidanceLevel.simple:
        return l10n.guidanceSimple;
      case GuidanceLevel.intermediate:
        return l10n.guidanceIntermediate;
      case GuidanceLevel.advanced:
        return l10n.guidanceAdvanced;
      default:
        return displayName;
    }
  }

  static BuiltSet<GuidanceLevel> get values => _$guidanceLevelValues;
  static GuidanceLevel valueOf(String name) => _$guidanceLevelValueOf(name);

  String serialize() {
    return serializers.serializeWith(GuidanceLevel.serializer, this) as String;
  }

  static GuidanceLevel? deserialize(String? string) {
    if (string == null) return null;
    return serializers.deserializeWith(GuidanceLevel.serializer, string)
        as GuidanceLevel;
  }

  static Serializer<GuidanceLevel> get serializer => _$guidanceLevelSerializer;
}
