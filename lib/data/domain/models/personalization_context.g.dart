// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalization_context.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PersonalityType _$introverted = const PersonalityType._('introverted');
const PersonalityType _$extroverted = const PersonalityType._('extroverted');
const PersonalityType _$disciplined = const PersonalityType._('disciplined');
const PersonalityType _$creative = const PersonalityType._('creative');
const PersonalityType _$analytical = const PersonalityType._('analytical');

PersonalityType _$personalityTypeValueOf(String name) {
  switch (name) {
    case 'introverted':
      return _$introverted;
    case 'extroverted':
      return _$extroverted;
    case 'disciplined':
      return _$disciplined;
    case 'creative':
      return _$creative;
    case 'analytical':
      return _$analytical;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PersonalityType> _$personalityTypeValues =
    new BuiltSet<PersonalityType>(const <PersonalityType>[
  _$introverted,
  _$extroverted,
  _$disciplined,
  _$creative,
  _$analytical,
]);

const TimePreference _$morning = const TimePreference._('morning');
const TimePreference _$noon = const TimePreference._('noon');
const TimePreference _$afternoon = const TimePreference._('afternoon');
const TimePreference _$evening = const TimePreference._('evening');
const TimePreference _$flexible = const TimePreference._('flexible');

TimePreference _$timePreferenceValueOf(String name) {
  switch (name) {
    case 'morning':
      return _$morning;
    case 'noon':
      return _$noon;
    case 'afternoon':
      return _$afternoon;
    case 'evening':
      return _$evening;
    case 'flexible':
      return _$flexible;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TimePreference> _$timePreferenceValues =
    new BuiltSet<TimePreference>(const <TimePreference>[
  _$morning,
  _$noon,
  _$afternoon,
  _$evening,
  _$flexible,
]);

const GuidanceLevel _$simple = const GuidanceLevel._('simple');
const GuidanceLevel _$intermediate = const GuidanceLevel._('intermediate');
const GuidanceLevel _$advanced = const GuidanceLevel._('advanced');

GuidanceLevel _$guidanceLevelValueOf(String name) {
  switch (name) {
    case 'simple':
      return _$simple;
    case 'intermediate':
      return _$intermediate;
    case 'advanced':
      return _$advanced;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GuidanceLevel> _$guidanceLevelValues =
    new BuiltSet<GuidanceLevel>(const <GuidanceLevel>[
  _$simple,
  _$intermediate,
  _$advanced,
]);

Serializer<PersonalizationContext> _$personalizationContextSerializer =
    new _$PersonalizationContextSerializer();
Serializer<PersonalityType> _$personalityTypeSerializer =
    new _$PersonalityTypeSerializer();
Serializer<TimePreference> _$timePreferenceSerializer =
    new _$TimePreferenceSerializer();
Serializer<GuidanceLevel> _$guidanceLevelSerializer =
    new _$GuidanceLevelSerializer();

class _$PersonalizationContextSerializer
    implements StructuredSerializer<PersonalizationContext> {
  @override
  final Iterable<Type> types = const [
    PersonalizationContext,
    _$PersonalizationContext
  ];
  @override
  final String wireName = 'PersonalizationContext';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, PersonalizationContext object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'goals',
      serializers.serialize(object.goals,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.personalityType;
    if (value != null) {
      result
        ..add('personalityType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(PersonalityType)));
    }
    value = object.timePreference;
    if (value != null) {
      result
        ..add('timePreference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(TimePreference)));
    }
    value = object.guidanceLevel;
    if (value != null) {
      result
        ..add('guidanceLevel')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GuidanceLevel)));
    }
    return result;
  }

  @override
  PersonalizationContext deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PersonalizationContextBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'goals':
          result.goals = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'personalityType':
          result.personalityType = serializers.deserialize(value,
                  specifiedType: const FullType(PersonalityType))
              as PersonalityType?;
          break;
        case 'timePreference':
          result.timePreference = serializers.deserialize(value,
              specifiedType: const FullType(TimePreference)) as TimePreference?;
          break;
        case 'guidanceLevel':
          result.guidanceLevel = serializers.deserialize(value,
              specifiedType: const FullType(GuidanceLevel)) as GuidanceLevel?;
          break;
      }
    }

    return result.build();
  }
}

class _$PersonalityTypeSerializer
    implements PrimitiveSerializer<PersonalityType> {
  @override
  final Iterable<Type> types = const <Type>[PersonalityType];
  @override
  final String wireName = 'PersonalityType';

  @override
  Object serialize(Serializers serializers, PersonalityType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PersonalityType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PersonalityType.valueOf(serialized as String);
}

class _$TimePreferenceSerializer
    implements PrimitiveSerializer<TimePreference> {
  @override
  final Iterable<Type> types = const <Type>[TimePreference];
  @override
  final String wireName = 'TimePreference';

  @override
  Object serialize(Serializers serializers, TimePreference object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TimePreference deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TimePreference.valueOf(serialized as String);
}

class _$GuidanceLevelSerializer implements PrimitiveSerializer<GuidanceLevel> {
  @override
  final Iterable<Type> types = const <Type>[GuidanceLevel];
  @override
  final String wireName = 'GuidanceLevel';

  @override
  Object serialize(Serializers serializers, GuidanceLevel object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GuidanceLevel deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GuidanceLevel.valueOf(serialized as String);
}

class _$PersonalizationContext extends PersonalizationContext {
  @override
  final String goals;
  @override
  final PersonalityType? personalityType;
  @override
  final TimePreference? timePreference;
  @override
  final GuidanceLevel? guidanceLevel;

  factory _$PersonalizationContext(
          [void Function(PersonalizationContextBuilder)? updates]) =>
      (new PersonalizationContextBuilder()..update(updates))._build();

  _$PersonalizationContext._(
      {required this.goals,
      this.personalityType,
      this.timePreference,
      this.guidanceLevel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        goals, r'PersonalizationContext', 'goals');
  }

  @override
  PersonalizationContext rebuild(
          void Function(PersonalizationContextBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PersonalizationContextBuilder toBuilder() =>
      new PersonalizationContextBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PersonalizationContext &&
        goals == other.goals &&
        personalityType == other.personalityType &&
        timePreference == other.timePreference &&
        guidanceLevel == other.guidanceLevel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, goals.hashCode);
    _$hash = $jc(_$hash, personalityType.hashCode);
    _$hash = $jc(_$hash, timePreference.hashCode);
    _$hash = $jc(_$hash, guidanceLevel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PersonalizationContext')
          ..add('goals', goals)
          ..add('personalityType', personalityType)
          ..add('timePreference', timePreference)
          ..add('guidanceLevel', guidanceLevel))
        .toString();
  }
}

class PersonalizationContextBuilder
    implements Builder<PersonalizationContext, PersonalizationContextBuilder> {
  _$PersonalizationContext? _$v;

  String? _goals;
  String? get goals => _$this._goals;
  set goals(String? goals) => _$this._goals = goals;

  PersonalityType? _personalityType;
  PersonalityType? get personalityType => _$this._personalityType;
  set personalityType(PersonalityType? personalityType) =>
      _$this._personalityType = personalityType;

  TimePreference? _timePreference;
  TimePreference? get timePreference => _$this._timePreference;
  set timePreference(TimePreference? timePreference) =>
      _$this._timePreference = timePreference;

  GuidanceLevel? _guidanceLevel;
  GuidanceLevel? get guidanceLevel => _$this._guidanceLevel;
  set guidanceLevel(GuidanceLevel? guidanceLevel) =>
      _$this._guidanceLevel = guidanceLevel;

  PersonalizationContextBuilder() {
    PersonalizationContext._setDefaults(this);
  }

  PersonalizationContextBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _goals = $v.goals;
      _personalityType = $v.personalityType;
      _timePreference = $v.timePreference;
      _guidanceLevel = $v.guidanceLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PersonalizationContext other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PersonalizationContext;
  }

  @override
  void update(void Function(PersonalizationContextBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PersonalizationContext build() => _build();

  _$PersonalizationContext _build() {
    final _$result = _$v ??
        new _$PersonalizationContext._(
          goals: BuiltValueNullFieldError.checkNotNull(
              goals, r'PersonalizationContext', 'goals'),
          personalityType: personalityType,
          timePreference: timePreference,
          guidanceLevel: guidanceLevel,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
