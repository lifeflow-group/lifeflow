// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_analysis.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitAnalysis> _$habitAnalysisSerializer =
    _$HabitAnalysisSerializer();
Serializer<HabitData> _$habitDataSerializer = _$HabitDataSerializer();

class _$HabitAnalysisSerializer implements StructuredSerializer<HabitAnalysis> {
  @override
  final Iterable<Type> types = const [HabitAnalysis, _$HabitAnalysis];
  @override
  final String wireName = 'HabitAnalysis';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitAnalysis object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(DateTime)),
      'endDate',
      serializers.serialize(object.endDate,
          specifiedType: const FullType(DateTime)),
      'habits',
      serializers.serialize(object.habits,
          specifiedType:
              const FullType(BuiltList, const [const FullType(HabitData)])),
    ];

    return result;
  }

  @override
  HabitAnalysis deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HabitAnalysisBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'habits':
          result.habits.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(HabitData)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$HabitDataSerializer implements StructuredSerializer<HabitData> {
  @override
  final Iterable<Type> types = const [HabitData, _$HabitData];
  @override
  final String wireName = 'HabitData';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(Category)),
      'trackingType',
      serializers.serialize(object.trackingType,
          specifiedType: const FullType(TrackingType)),
      'reminderEnabled',
      serializers.serialize(object.reminderEnabled,
          specifiedType: const FullType(bool)),
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(DateTime)),
      'exceptions',
      serializers.serialize(object.exceptions,
          specifiedType: const FullType(
              BuiltList, const [const FullType(HabitException)])),
    ];
    Object? value;
    value = object.targetValue;
    if (value != null) {
      result
        ..add('targetValue')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.unit;
    if (value != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.repeatFrequency;
    if (value != null) {
      result
        ..add('repeatFrequency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(RepeatFrequency)));
    }
    value = object.untilDate;
    if (value != null) {
      result
        ..add('untilDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  HabitData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HabitDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category':
          result.category.replace(serializers.deserialize(value,
              specifiedType: const FullType(Category))! as Category);
          break;
        case 'trackingType':
          result.trackingType = serializers.deserialize(value,
              specifiedType: const FullType(TrackingType))! as TrackingType;
          break;
        case 'reminderEnabled':
          result.reminderEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'targetValue':
          result.targetValue = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'repeatFrequency':
          result.repeatFrequency = serializers.deserialize(value,
                  specifiedType: const FullType(RepeatFrequency))
              as RepeatFrequency?;
          break;
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'untilDate':
          result.untilDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'exceptions':
          result.exceptions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(HabitException)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$HabitAnalysis extends HabitAnalysis {
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final BuiltList<HabitData> habits;

  factory _$HabitAnalysis([void Function(HabitAnalysisBuilder)? updates]) =>
      (HabitAnalysisBuilder()..update(updates))._build();

  _$HabitAnalysis._(
      {required this.startDate, required this.endDate, required this.habits})
      : super._();
  @override
  HabitAnalysis rebuild(void Function(HabitAnalysisBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitAnalysisBuilder toBuilder() => HabitAnalysisBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitAnalysis &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        habits == other.habits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, habits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitAnalysis')
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('habits', habits))
        .toString();
  }
}

class HabitAnalysisBuilder
    implements Builder<HabitAnalysis, HabitAnalysisBuilder> {
  _$HabitAnalysis? _$v;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  ListBuilder<HabitData>? _habits;
  ListBuilder<HabitData> get habits =>
      _$this._habits ??= ListBuilder<HabitData>();
  set habits(ListBuilder<HabitData>? habits) => _$this._habits = habits;

  HabitAnalysisBuilder();

  HabitAnalysisBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _habits = $v.habits.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitAnalysis other) {
    _$v = other as _$HabitAnalysis;
  }

  @override
  void update(void Function(HabitAnalysisBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitAnalysis build() => _build();

  _$HabitAnalysis _build() {
    _$HabitAnalysis _$result;
    try {
      _$result = _$v ??
          _$HabitAnalysis._(
            startDate: BuiltValueNullFieldError.checkNotNull(
                startDate, r'HabitAnalysis', 'startDate'),
            endDate: BuiltValueNullFieldError.checkNotNull(
                endDate, r'HabitAnalysis', 'endDate'),
            habits: habits.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'habits';
        habits.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HabitAnalysis', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HabitData extends HabitData {
  @override
  final String id;
  @override
  final String name;
  @override
  final Category category;
  @override
  final TrackingType trackingType;
  @override
  final bool reminderEnabled;
  @override
  final int? targetValue;
  @override
  final String? unit;
  @override
  final RepeatFrequency? repeatFrequency;
  @override
  final DateTime startDate;
  @override
  final DateTime? untilDate;
  @override
  final BuiltList<HabitException> exceptions;

  factory _$HabitData([void Function(HabitDataBuilder)? updates]) =>
      (HabitDataBuilder()..update(updates))._build();

  _$HabitData._(
      {required this.id,
      required this.name,
      required this.category,
      required this.trackingType,
      required this.reminderEnabled,
      this.targetValue,
      this.unit,
      this.repeatFrequency,
      required this.startDate,
      this.untilDate,
      required this.exceptions})
      : super._();
  @override
  HabitData rebuild(void Function(HabitDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitDataBuilder toBuilder() => HabitDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitData &&
        id == other.id &&
        name == other.name &&
        category == other.category &&
        trackingType == other.trackingType &&
        reminderEnabled == other.reminderEnabled &&
        targetValue == other.targetValue &&
        unit == other.unit &&
        repeatFrequency == other.repeatFrequency &&
        startDate == other.startDate &&
        untilDate == other.untilDate &&
        exceptions == other.exceptions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, trackingType.hashCode);
    _$hash = $jc(_$hash, reminderEnabled.hashCode);
    _$hash = $jc(_$hash, targetValue.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, repeatFrequency.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, untilDate.hashCode);
    _$hash = $jc(_$hash, exceptions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitData')
          ..add('id', id)
          ..add('name', name)
          ..add('category', category)
          ..add('trackingType', trackingType)
          ..add('reminderEnabled', reminderEnabled)
          ..add('targetValue', targetValue)
          ..add('unit', unit)
          ..add('repeatFrequency', repeatFrequency)
          ..add('startDate', startDate)
          ..add('untilDate', untilDate)
          ..add('exceptions', exceptions))
        .toString();
  }
}

class HabitDataBuilder implements Builder<HabitData, HabitDataBuilder> {
  _$HabitData? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CategoryBuilder? _category;
  CategoryBuilder get category => _$this._category ??= CategoryBuilder();
  set category(CategoryBuilder? category) => _$this._category = category;

  TrackingType? _trackingType;
  TrackingType? get trackingType => _$this._trackingType;
  set trackingType(TrackingType? trackingType) =>
      _$this._trackingType = trackingType;

  bool? _reminderEnabled;
  bool? get reminderEnabled => _$this._reminderEnabled;
  set reminderEnabled(bool? reminderEnabled) =>
      _$this._reminderEnabled = reminderEnabled;

  int? _targetValue;
  int? get targetValue => _$this._targetValue;
  set targetValue(int? targetValue) => _$this._targetValue = targetValue;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  RepeatFrequency? _repeatFrequency;
  RepeatFrequency? get repeatFrequency => _$this._repeatFrequency;
  set repeatFrequency(RepeatFrequency? repeatFrequency) =>
      _$this._repeatFrequency = repeatFrequency;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _untilDate;
  DateTime? get untilDate => _$this._untilDate;
  set untilDate(DateTime? untilDate) => _$this._untilDate = untilDate;

  ListBuilder<HabitException>? _exceptions;
  ListBuilder<HabitException> get exceptions =>
      _$this._exceptions ??= ListBuilder<HabitException>();
  set exceptions(ListBuilder<HabitException>? exceptions) =>
      _$this._exceptions = exceptions;

  HabitDataBuilder() {
    HabitData._setDefaults(this);
  }

  HabitDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _category = $v.category.toBuilder();
      _trackingType = $v.trackingType;
      _reminderEnabled = $v.reminderEnabled;
      _targetValue = $v.targetValue;
      _unit = $v.unit;
      _repeatFrequency = $v.repeatFrequency;
      _startDate = $v.startDate;
      _untilDate = $v.untilDate;
      _exceptions = $v.exceptions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitData other) {
    _$v = other as _$HabitData;
  }

  @override
  void update(void Function(HabitDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitData build() => _build();

  _$HabitData _build() {
    _$HabitData _$result;
    try {
      _$result = _$v ??
          _$HabitData._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'HabitData', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'HabitData', 'name'),
            category: category.build(),
            trackingType: BuiltValueNullFieldError.checkNotNull(
                trackingType, r'HabitData', 'trackingType'),
            reminderEnabled: BuiltValueNullFieldError.checkNotNull(
                reminderEnabled, r'HabitData', 'reminderEnabled'),
            targetValue: targetValue,
            unit: unit,
            repeatFrequency: repeatFrequency,
            startDate: BuiltValueNullFieldError.checkNotNull(
                startDate, r'HabitData', 'startDate'),
            untilDate: untilDate,
            exceptions: exceptions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'category';
        category.build();

        _$failedField = 'exceptions';
        exceptions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HabitData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
