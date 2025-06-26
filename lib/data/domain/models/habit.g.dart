// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RepeatFrequency _$daily = const RepeatFrequency._('daily');
const RepeatFrequency _$weekly = const RepeatFrequency._('weekly');
const RepeatFrequency _$monthly = const RepeatFrequency._('monthly');

RepeatFrequency _$repeatFrequencyValueOf(String name) {
  switch (name) {
    case 'daily':
      return _$daily;
    case 'weekly':
      return _$weekly;
    case 'monthly':
      return _$monthly;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<RepeatFrequency> _$repeatFrequencyValues =
    new BuiltSet<RepeatFrequency>(const <RepeatFrequency>[
  _$daily,
  _$weekly,
  _$monthly,
]);

const TrackingType _$complete = const TrackingType._('complete');
const TrackingType _$progress = const TrackingType._('progress');

TrackingType _$trackingTypeValueOf(String name) {
  switch (name) {
    case 'complete':
      return _$complete;
    case 'progress':
      return _$progress;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TrackingType> _$trackingTypeValues =
    new BuiltSet<TrackingType>(const <TrackingType>[
  _$complete,
  _$progress,
]);

Serializer<RepeatFrequency> _$repeatFrequencySerializer =
    new _$RepeatFrequencySerializer();
Serializer<TrackingType> _$trackingTypeSerializer =
    new _$TrackingTypeSerializer();
Serializer<Habit> _$habitSerializer = new _$HabitSerializer();

class _$RepeatFrequencySerializer
    implements PrimitiveSerializer<RepeatFrequency> {
  @override
  final Iterable<Type> types = const <Type>[RepeatFrequency];
  @override
  final String wireName = 'RepeatFrequency';

  @override
  Object serialize(Serializers serializers, RepeatFrequency object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  RepeatFrequency deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RepeatFrequency.valueOf(serialized as String);
}

class _$TrackingTypeSerializer implements PrimitiveSerializer<TrackingType> {
  @override
  final Iterable<Type> types = const <Type>[TrackingType];
  @override
  final String wireName = 'TrackingType';

  @override
  Object serialize(Serializers serializers, TrackingType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TrackingType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TrackingType.valueOf(serialized as String);
}

class _$HabitSerializer implements StructuredSerializer<Habit> {
  @override
  final Iterable<Type> types = const [Habit, _$Habit];
  @override
  final String wireName = 'Habit';

  @override
  Iterable<Object?> serialize(Serializers serializers, Habit object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(Category)),
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
      'reminderEnabled',
      serializers.serialize(object.reminderEnabled,
          specifiedType: const FullType(bool)),
      'trackingType',
      serializers.serialize(object.trackingType,
          specifiedType: const FullType(TrackingType)),
    ];
    Object? value;
    value = object.series;
    if (value != null) {
      result
        ..add('series')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(HabitSeries)));
    }
    value = object.targetValue;
    if (value != null) {
      result
        ..add('targetValue')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.currentValue;
    if (value != null) {
      result
        ..add('currentValue')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.unit;
    if (value != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isCompleted;
    if (value != null) {
      result
        ..add('isCompleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  Habit deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitBuilder();

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
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category':
          result.category.replace(serializers.deserialize(value,
              specifiedType: const FullType(Category))! as Category);
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'series':
          result.series.replace(serializers.deserialize(value,
              specifiedType: const FullType(HabitSeries))! as HabitSeries);
          break;
        case 'reminderEnabled':
          result.reminderEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'trackingType':
          result.trackingType = serializers.deserialize(value,
              specifiedType: const FullType(TrackingType))! as TrackingType;
          break;
        case 'targetValue':
          result.targetValue = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'currentValue':
          result.currentValue = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isCompleted':
          result.isCompleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$Habit extends Habit {
  @override
  final String id;
  @override
  final String name;
  @override
  final String userId;
  @override
  final Category category;
  @override
  final DateTime date;
  @override
  final HabitSeries? series;
  @override
  final bool reminderEnabled;
  @override
  final TrackingType trackingType;
  @override
  final int? targetValue;
  @override
  final int? currentValue;
  @override
  final String? unit;
  @override
  final bool? isCompleted;

  factory _$Habit([void Function(HabitBuilder)? updates]) =>
      (new HabitBuilder()..update(updates))._build();

  _$Habit._(
      {required this.id,
      required this.name,
      required this.userId,
      required this.category,
      required this.date,
      this.series,
      required this.reminderEnabled,
      required this.trackingType,
      this.targetValue,
      this.currentValue,
      this.unit,
      this.isCompleted})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Habit', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'Habit', 'name');
    BuiltValueNullFieldError.checkNotNull(userId, r'Habit', 'userId');
    BuiltValueNullFieldError.checkNotNull(category, r'Habit', 'category');
    BuiltValueNullFieldError.checkNotNull(date, r'Habit', 'date');
    BuiltValueNullFieldError.checkNotNull(
        reminderEnabled, r'Habit', 'reminderEnabled');
    BuiltValueNullFieldError.checkNotNull(
        trackingType, r'Habit', 'trackingType');
  }

  @override
  Habit rebuild(void Function(HabitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitBuilder toBuilder() => new HabitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Habit &&
        id == other.id &&
        name == other.name &&
        userId == other.userId &&
        category == other.category &&
        date == other.date &&
        series == other.series &&
        reminderEnabled == other.reminderEnabled &&
        trackingType == other.trackingType &&
        targetValue == other.targetValue &&
        currentValue == other.currentValue &&
        unit == other.unit &&
        isCompleted == other.isCompleted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, series.hashCode);
    _$hash = $jc(_$hash, reminderEnabled.hashCode);
    _$hash = $jc(_$hash, trackingType.hashCode);
    _$hash = $jc(_$hash, targetValue.hashCode);
    _$hash = $jc(_$hash, currentValue.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Habit')
          ..add('id', id)
          ..add('name', name)
          ..add('userId', userId)
          ..add('category', category)
          ..add('date', date)
          ..add('series', series)
          ..add('reminderEnabled', reminderEnabled)
          ..add('trackingType', trackingType)
          ..add('targetValue', targetValue)
          ..add('currentValue', currentValue)
          ..add('unit', unit)
          ..add('isCompleted', isCompleted))
        .toString();
  }
}

class HabitBuilder implements Builder<Habit, HabitBuilder> {
  _$Habit? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  CategoryBuilder? _category;
  CategoryBuilder get category => _$this._category ??= new CategoryBuilder();
  set category(CategoryBuilder? category) => _$this._category = category;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HabitSeriesBuilder? _series;
  HabitSeriesBuilder get series => _$this._series ??= new HabitSeriesBuilder();
  set series(HabitSeriesBuilder? series) => _$this._series = series;

  bool? _reminderEnabled;
  bool? get reminderEnabled => _$this._reminderEnabled;
  set reminderEnabled(bool? reminderEnabled) =>
      _$this._reminderEnabled = reminderEnabled;

  TrackingType? _trackingType;
  TrackingType? get trackingType => _$this._trackingType;
  set trackingType(TrackingType? trackingType) =>
      _$this._trackingType = trackingType;

  int? _targetValue;
  int? get targetValue => _$this._targetValue;
  set targetValue(int? targetValue) => _$this._targetValue = targetValue;

  int? _currentValue;
  int? get currentValue => _$this._currentValue;
  set currentValue(int? currentValue) => _$this._currentValue = currentValue;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  HabitBuilder() {
    Habit._setDefaults(this);
  }

  HabitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _userId = $v.userId;
      _category = $v.category.toBuilder();
      _date = $v.date;
      _series = $v.series?.toBuilder();
      _reminderEnabled = $v.reminderEnabled;
      _trackingType = $v.trackingType;
      _targetValue = $v.targetValue;
      _currentValue = $v.currentValue;
      _unit = $v.unit;
      _isCompleted = $v.isCompleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Habit other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Habit;
  }

  @override
  void update(void Function(HabitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Habit build() => _build();

  _$Habit _build() {
    _$Habit _$result;
    try {
      _$result = _$v ??
          new _$Habit._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Habit', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(name, r'Habit', 'name'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Habit', 'userId'),
            category: category.build(),
            date: BuiltValueNullFieldError.checkNotNull(date, r'Habit', 'date'),
            series: _series?.build(),
            reminderEnabled: BuiltValueNullFieldError.checkNotNull(
                reminderEnabled, r'Habit', 'reminderEnabled'),
            trackingType: BuiltValueNullFieldError.checkNotNull(
                trackingType, r'Habit', 'trackingType'),
            targetValue: targetValue,
            currentValue: currentValue,
            unit: unit,
            isCompleted: isCompleted,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'category';
        category.build();

        _$failedField = 'series';
        _series?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Habit', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
