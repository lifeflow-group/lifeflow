// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_exception.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitException> _$habitExceptionSerializer =
    _$HabitExceptionSerializer();

class _$HabitExceptionSerializer
    implements StructuredSerializer<HabitException> {
  @override
  final Iterable<Type> types = const [HabitException, _$HabitException];
  @override
  final String wireName = 'HabitException';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitException object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'habitSeriesId',
      serializers.serialize(object.habitSeriesId,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
      'isSkipped',
      serializers.serialize(object.isSkipped,
          specifiedType: const FullType(bool)),
      'reminderEnabled',
      serializers.serialize(object.reminderEnabled,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
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
  HabitException deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HabitExceptionBuilder();

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
        case 'habitSeriesId':
          result.habitSeriesId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'isSkipped':
          result.isSkipped = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'reminderEnabled':
          result.reminderEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'targetValue':
          result.targetValue = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'currentValue':
          result.currentValue = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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

class _$HabitException extends HabitException {
  @override
  final String id;
  @override
  final String habitSeriesId;
  @override
  final DateTime date;
  @override
  final bool isSkipped;
  @override
  final bool reminderEnabled;
  @override
  final int? targetValue;
  @override
  final int? currentValue;
  @override
  final bool? isCompleted;

  factory _$HabitException([void Function(HabitExceptionBuilder)? updates]) =>
      (HabitExceptionBuilder()..update(updates))._build();

  _$HabitException._(
      {required this.id,
      required this.habitSeriesId,
      required this.date,
      required this.isSkipped,
      required this.reminderEnabled,
      this.targetValue,
      this.currentValue,
      this.isCompleted})
      : super._();
  @override
  HabitException rebuild(void Function(HabitExceptionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitExceptionBuilder toBuilder() => HabitExceptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitException &&
        id == other.id &&
        habitSeriesId == other.habitSeriesId &&
        date == other.date &&
        isSkipped == other.isSkipped &&
        reminderEnabled == other.reminderEnabled &&
        targetValue == other.targetValue &&
        currentValue == other.currentValue &&
        isCompleted == other.isCompleted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, habitSeriesId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, isSkipped.hashCode);
    _$hash = $jc(_$hash, reminderEnabled.hashCode);
    _$hash = $jc(_$hash, targetValue.hashCode);
    _$hash = $jc(_$hash, currentValue.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitException')
          ..add('id', id)
          ..add('habitSeriesId', habitSeriesId)
          ..add('date', date)
          ..add('isSkipped', isSkipped)
          ..add('reminderEnabled', reminderEnabled)
          ..add('targetValue', targetValue)
          ..add('currentValue', currentValue)
          ..add('isCompleted', isCompleted))
        .toString();
  }
}

class HabitExceptionBuilder
    implements Builder<HabitException, HabitExceptionBuilder> {
  _$HabitException? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _habitSeriesId;
  String? get habitSeriesId => _$this._habitSeriesId;
  set habitSeriesId(String? habitSeriesId) =>
      _$this._habitSeriesId = habitSeriesId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  bool? _isSkipped;
  bool? get isSkipped => _$this._isSkipped;
  set isSkipped(bool? isSkipped) => _$this._isSkipped = isSkipped;

  bool? _reminderEnabled;
  bool? get reminderEnabled => _$this._reminderEnabled;
  set reminderEnabled(bool? reminderEnabled) =>
      _$this._reminderEnabled = reminderEnabled;

  int? _targetValue;
  int? get targetValue => _$this._targetValue;
  set targetValue(int? targetValue) => _$this._targetValue = targetValue;

  int? _currentValue;
  int? get currentValue => _$this._currentValue;
  set currentValue(int? currentValue) => _$this._currentValue = currentValue;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  HabitExceptionBuilder() {
    HabitException._setDefaults(this);
  }

  HabitExceptionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _habitSeriesId = $v.habitSeriesId;
      _date = $v.date;
      _isSkipped = $v.isSkipped;
      _reminderEnabled = $v.reminderEnabled;
      _targetValue = $v.targetValue;
      _currentValue = $v.currentValue;
      _isCompleted = $v.isCompleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitException other) {
    _$v = other as _$HabitException;
  }

  @override
  void update(void Function(HabitExceptionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitException build() => _build();

  _$HabitException _build() {
    final _$result = _$v ??
        _$HabitException._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'HabitException', 'id'),
          habitSeriesId: BuiltValueNullFieldError.checkNotNull(
              habitSeriesId, r'HabitException', 'habitSeriesId'),
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'HabitException', 'date'),
          isSkipped: BuiltValueNullFieldError.checkNotNull(
              isSkipped, r'HabitException', 'isSkipped'),
          reminderEnabled: BuiltValueNullFieldError.checkNotNull(
              reminderEnabled, r'HabitException', 'reminderEnabled'),
          targetValue: targetValue,
          currentValue: currentValue,
          isCompleted: isCompleted,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
