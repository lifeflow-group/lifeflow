// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_series.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitSeries> _$habitSeriesSerializer = new _$HabitSeriesSerializer();

class _$HabitSeriesSerializer implements StructuredSerializer<HabitSeries> {
  @override
  final Iterable<Type> types = const [HabitSeries, _$HabitSeries];
  @override
  final String wireName = 'HabitSeries';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitSeries object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'habitId',
      serializers.serialize(object.habitId,
          specifiedType: const FullType(String)),
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.untilDate;
    if (value != null) {
      result
        ..add('untilDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.repeatFrequency;
    if (value != null) {
      result
        ..add('repeatFrequency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(RepeatFrequency)));
    }
    return result;
  }

  @override
  HabitSeries deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitSeriesBuilder();

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
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'habitId':
          result.habitId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'untilDate':
          result.untilDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'repeatFrequency':
          result.repeatFrequency = serializers.deserialize(value,
                  specifiedType: const FullType(RepeatFrequency))
              as RepeatFrequency?;
          break;
      }
    }

    return result.build();
  }
}

class _$HabitSeries extends HabitSeries {
  @override
  final String id;
  @override
  final String userId;
  @override
  final String habitId;
  @override
  final DateTime startDate;
  @override
  final DateTime? untilDate;
  @override
  final RepeatFrequency? repeatFrequency;

  factory _$HabitSeries([void Function(HabitSeriesBuilder)? updates]) =>
      (new HabitSeriesBuilder()..update(updates))._build();

  _$HabitSeries._(
      {required this.id,
      required this.userId,
      required this.habitId,
      required this.startDate,
      this.untilDate,
      this.repeatFrequency})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'HabitSeries', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'HabitSeries', 'userId');
    BuiltValueNullFieldError.checkNotNull(habitId, r'HabitSeries', 'habitId');
    BuiltValueNullFieldError.checkNotNull(
        startDate, r'HabitSeries', 'startDate');
  }

  @override
  HabitSeries rebuild(void Function(HabitSeriesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitSeriesBuilder toBuilder() => new HabitSeriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitSeries &&
        id == other.id &&
        userId == other.userId &&
        habitId == other.habitId &&
        startDate == other.startDate &&
        untilDate == other.untilDate &&
        repeatFrequency == other.repeatFrequency;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, habitId.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, untilDate.hashCode);
    _$hash = $jc(_$hash, repeatFrequency.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitSeries')
          ..add('id', id)
          ..add('userId', userId)
          ..add('habitId', habitId)
          ..add('startDate', startDate)
          ..add('untilDate', untilDate)
          ..add('repeatFrequency', repeatFrequency))
        .toString();
  }
}

class HabitSeriesBuilder implements Builder<HabitSeries, HabitSeriesBuilder> {
  _$HabitSeries? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _habitId;
  String? get habitId => _$this._habitId;
  set habitId(String? habitId) => _$this._habitId = habitId;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _untilDate;
  DateTime? get untilDate => _$this._untilDate;
  set untilDate(DateTime? untilDate) => _$this._untilDate = untilDate;

  RepeatFrequency? _repeatFrequency;
  RepeatFrequency? get repeatFrequency => _$this._repeatFrequency;
  set repeatFrequency(RepeatFrequency? repeatFrequency) =>
      _$this._repeatFrequency = repeatFrequency;

  HabitSeriesBuilder() {
    HabitSeries._setDefaults(this);
  }

  HabitSeriesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _habitId = $v.habitId;
      _startDate = $v.startDate;
      _untilDate = $v.untilDate;
      _repeatFrequency = $v.repeatFrequency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitSeries other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitSeries;
  }

  @override
  void update(void Function(HabitSeriesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitSeries build() => _build();

  _$HabitSeries _build() {
    final _$result = _$v ??
        new _$HabitSeries._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'HabitSeries', 'id'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'HabitSeries', 'userId'),
          habitId: BuiltValueNullFieldError.checkNotNull(
              habitId, r'HabitSeries', 'habitId'),
          startDate: BuiltValueNullFieldError.checkNotNull(
              startDate, r'HabitSeries', 'startDate'),
          untilDate: untilDate,
          repeatFrequency: repeatFrequency,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
