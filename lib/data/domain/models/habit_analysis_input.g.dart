// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_analysis_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitAnalysisInput> _$habitAnalysisInputSerializer =
    new _$HabitAnalysisInputSerializer();
Serializer<HabitData> _$habitDataSerializer = new _$HabitDataSerializer();

class _$HabitAnalysisInputSerializer
    implements StructuredSerializer<HabitAnalysisInput> {
  @override
  final Iterable<Type> types = const [HabitAnalysisInput, _$HabitAnalysisInput];
  @override
  final String wireName = 'HabitAnalysisInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, HabitAnalysisInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
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
  HabitAnalysisInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitAnalysisInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
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
          specifiedType: const FullType(HabitCategory)),
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
    final result = new HabitDataBuilder();

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
              specifiedType: const FullType(HabitCategory))! as HabitCategory);
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

class _$HabitAnalysisInput extends HabitAnalysisInput {
  @override
  final String userId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final BuiltList<HabitData> habits;

  factory _$HabitAnalysisInput(
          [void Function(HabitAnalysisInputBuilder)? updates]) =>
      (new HabitAnalysisInputBuilder()..update(updates))._build();

  _$HabitAnalysisInput._(
      {required this.userId,
      required this.startDate,
      required this.endDate,
      required this.habits})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'HabitAnalysisInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        startDate, r'HabitAnalysisInput', 'startDate');
    BuiltValueNullFieldError.checkNotNull(
        endDate, r'HabitAnalysisInput', 'endDate');
    BuiltValueNullFieldError.checkNotNull(
        habits, r'HabitAnalysisInput', 'habits');
  }

  @override
  HabitAnalysisInput rebuild(
          void Function(HabitAnalysisInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitAnalysisInputBuilder toBuilder() =>
      new HabitAnalysisInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitAnalysisInput &&
        userId == other.userId &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        habits == other.habits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, habits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitAnalysisInput')
          ..add('userId', userId)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('habits', habits))
        .toString();
  }
}

class HabitAnalysisInputBuilder
    implements Builder<HabitAnalysisInput, HabitAnalysisInputBuilder> {
  _$HabitAnalysisInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  ListBuilder<HabitData>? _habits;
  ListBuilder<HabitData> get habits =>
      _$this._habits ??= new ListBuilder<HabitData>();
  set habits(ListBuilder<HabitData>? habits) => _$this._habits = habits;

  HabitAnalysisInputBuilder();

  HabitAnalysisInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _habits = $v.habits.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitAnalysisInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitAnalysisInput;
  }

  @override
  void update(void Function(HabitAnalysisInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitAnalysisInput build() => _build();

  _$HabitAnalysisInput _build() {
    _$HabitAnalysisInput _$result;
    try {
      _$result = _$v ??
          new _$HabitAnalysisInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'HabitAnalysisInput', 'userId'),
            startDate: BuiltValueNullFieldError.checkNotNull(
                startDate, r'HabitAnalysisInput', 'startDate'),
            endDate: BuiltValueNullFieldError.checkNotNull(
                endDate, r'HabitAnalysisInput', 'endDate'),
            habits: habits.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'habits';
        habits.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HabitAnalysisInput', _$failedField, e.toString());
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
  final HabitCategory category;
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
      (new HabitDataBuilder()..update(updates))._build();

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
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'HabitData', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'HabitData', 'name');
    BuiltValueNullFieldError.checkNotNull(category, r'HabitData', 'category');
    BuiltValueNullFieldError.checkNotNull(
        trackingType, r'HabitData', 'trackingType');
    BuiltValueNullFieldError.checkNotNull(
        reminderEnabled, r'HabitData', 'reminderEnabled');
    BuiltValueNullFieldError.checkNotNull(startDate, r'HabitData', 'startDate');
    BuiltValueNullFieldError.checkNotNull(
        exceptions, r'HabitData', 'exceptions');
  }

  @override
  HabitData rebuild(void Function(HabitDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitDataBuilder toBuilder() => new HabitDataBuilder()..replace(this);

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

  HabitCategoryBuilder? _category;
  HabitCategoryBuilder get category =>
      _$this._category ??= new HabitCategoryBuilder();
  set category(HabitCategoryBuilder? category) => _$this._category = category;

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
      _$this._exceptions ??= new ListBuilder<HabitException>();
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
    ArgumentError.checkNotNull(other, 'other');
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
          new _$HabitData._(
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
        throw new BuiltValueNestedFieldError(
            r'HabitData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
