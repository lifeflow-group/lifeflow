// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Habit> _$habitSerializer = new _$HabitSerializer();

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
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(HabitCategory)),
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(DateTime)),
      'reminderEnabled',
      serializers.serialize(object.reminderEnabled,
          specifiedType: const FullType(bool)),
      'trackingType',
      serializers.serialize(object.trackingType,
          specifiedType: const FullType(TrackingType)),
    ];
    Object? value;
    value = object.repeatFrequency;
    if (value != null) {
      result
        ..add('repeatFrequency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(RepeatFrequency)));
    }
    value = object.quantity;
    if (value != null) {
      result
        ..add('quantity')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.unit;
    if (value != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.progress;
    if (value != null) {
      result
        ..add('progress')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.completed;
    if (value != null) {
      result
        ..add('completed')
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
        case 'category':
          result.category.replace(serializers.deserialize(value,
              specifiedType: const FullType(HabitCategory))! as HabitCategory);
          break;
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'repeatFrequency':
          result.repeatFrequency = serializers.deserialize(value,
                  specifiedType: const FullType(RepeatFrequency))
              as RepeatFrequency?;
          break;
        case 'reminderEnabled':
          result.reminderEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'trackingType':
          result.trackingType = serializers.deserialize(value,
              specifiedType: const FullType(TrackingType))! as TrackingType;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'progress':
          result.progress = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'completed':
          result.completed = serializers.deserialize(value,
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
  final HabitCategory category;
  @override
  final DateTime startDate;
  @override
  final RepeatFrequency? repeatFrequency;
  @override
  final bool reminderEnabled;
  @override
  final TrackingType trackingType;
  @override
  final int? quantity;
  @override
  final String? unit;
  @override
  final int? progress;
  @override
  final bool? completed;

  factory _$Habit([void Function(HabitBuilder)? updates]) =>
      (new HabitBuilder()..update(updates))._build();

  _$Habit._(
      {required this.id,
      required this.name,
      required this.category,
      required this.startDate,
      this.repeatFrequency,
      required this.reminderEnabled,
      required this.trackingType,
      this.quantity,
      this.unit,
      this.progress,
      this.completed})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Habit', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'Habit', 'name');
    BuiltValueNullFieldError.checkNotNull(category, r'Habit', 'category');
    BuiltValueNullFieldError.checkNotNull(startDate, r'Habit', 'startDate');
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
        category == other.category &&
        startDate == other.startDate &&
        repeatFrequency == other.repeatFrequency &&
        reminderEnabled == other.reminderEnabled &&
        trackingType == other.trackingType &&
        quantity == other.quantity &&
        unit == other.unit &&
        progress == other.progress &&
        completed == other.completed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, repeatFrequency.hashCode);
    _$hash = $jc(_$hash, reminderEnabled.hashCode);
    _$hash = $jc(_$hash, trackingType.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, progress.hashCode);
    _$hash = $jc(_$hash, completed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Habit')
          ..add('id', id)
          ..add('name', name)
          ..add('category', category)
          ..add('startDate', startDate)
          ..add('repeatFrequency', repeatFrequency)
          ..add('reminderEnabled', reminderEnabled)
          ..add('trackingType', trackingType)
          ..add('quantity', quantity)
          ..add('unit', unit)
          ..add('progress', progress)
          ..add('completed', completed))
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

  HabitCategoryBuilder? _category;
  HabitCategoryBuilder get category =>
      _$this._category ??= new HabitCategoryBuilder();
  set category(HabitCategoryBuilder? category) => _$this._category = category;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  RepeatFrequency? _repeatFrequency;
  RepeatFrequency? get repeatFrequency => _$this._repeatFrequency;
  set repeatFrequency(RepeatFrequency? repeatFrequency) =>
      _$this._repeatFrequency = repeatFrequency;

  bool? _reminderEnabled;
  bool? get reminderEnabled => _$this._reminderEnabled;
  set reminderEnabled(bool? reminderEnabled) =>
      _$this._reminderEnabled = reminderEnabled;

  TrackingType? _trackingType;
  TrackingType? get trackingType => _$this._trackingType;
  set trackingType(TrackingType? trackingType) =>
      _$this._trackingType = trackingType;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  int? _progress;
  int? get progress => _$this._progress;
  set progress(int? progress) => _$this._progress = progress;

  bool? _completed;
  bool? get completed => _$this._completed;
  set completed(bool? completed) => _$this._completed = completed;

  HabitBuilder() {
    Habit._setDefaults(this);
  }

  HabitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _category = $v.category.toBuilder();
      _startDate = $v.startDate;
      _repeatFrequency = $v.repeatFrequency;
      _reminderEnabled = $v.reminderEnabled;
      _trackingType = $v.trackingType;
      _quantity = $v.quantity;
      _unit = $v.unit;
      _progress = $v.progress;
      _completed = $v.completed;
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
            category: category.build(),
            startDate: BuiltValueNullFieldError.checkNotNull(
                startDate, r'Habit', 'startDate'),
            repeatFrequency: repeatFrequency,
            reminderEnabled: BuiltValueNullFieldError.checkNotNull(
                reminderEnabled, r'Habit', 'reminderEnabled'),
            trackingType: BuiltValueNullFieldError.checkNotNull(
                trackingType, r'Habit', 'trackingType'),
            quantity: quantity,
            unit: unit,
            progress: progress,
            completed: completed,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'category';
        category.build();
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
