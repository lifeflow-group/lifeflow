// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_suggestion_request_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DataSourceType _$personalizationOnly =
    const DataSourceType._('personalizationOnly');
const DataSourceType _$habitsOnly = const DataSourceType._('habitsOnly');
const DataSourceType _$both = const DataSourceType._('both');

DataSourceType _$dataSourceTypeValueOf(String name) {
  switch (name) {
    case 'personalizationOnly':
      return _$personalizationOnly;
    case 'habitsOnly':
      return _$habitsOnly;
    case 'both':
      return _$both;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DataSourceType> _$dataSourceTypeValues =
    new BuiltSet<DataSourceType>(const <DataSourceType>[
  _$personalizationOnly,
  _$habitsOnly,
  _$both,
]);

Serializer<AISuggestionRequestInput> _$aISuggestionRequestInputSerializer =
    new _$AISuggestionRequestInputSerializer();
Serializer<DataSourceType> _$dataSourceTypeSerializer =
    new _$DataSourceTypeSerializer();

class _$AISuggestionRequestInputSerializer
    implements StructuredSerializer<AISuggestionRequestInput> {
  @override
  final Iterable<Type> types = const [
    AISuggestionRequestInput,
    _$AISuggestionRequestInput
  ];
  @override
  final String wireName = 'AISuggestionRequestInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AISuggestionRequestInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'dataSourceType',
      serializers.serialize(object.dataSourceType,
          specifiedType: const FullType(DataSourceType)),
      'personalizationContext',
      serializers.serialize(object.personalizationContext,
          specifiedType: const FullType(PersonalizationContext)),
    ];
    Object? value;
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.habitAnalysis;
    if (value != null) {
      result
        ..add('habitAnalysis')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(HabitAnalysis)));
    }
    return result;
  }

  @override
  AISuggestionRequestInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AISuggestionRequestInputBuilder();

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
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'dataSourceType':
          result.dataSourceType = serializers.deserialize(value,
              specifiedType: const FullType(DataSourceType))! as DataSourceType;
          break;
        case 'personalizationContext':
          result.personalizationContext.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PersonalizationContext))!
              as PersonalizationContext);
          break;
        case 'habitAnalysis':
          result.habitAnalysis.replace(serializers.deserialize(value,
              specifiedType: const FullType(HabitAnalysis))! as HabitAnalysis);
          break;
      }
    }

    return result.build();
  }
}

class _$DataSourceTypeSerializer
    implements PrimitiveSerializer<DataSourceType> {
  @override
  final Iterable<Type> types = const <Type>[DataSourceType];
  @override
  final String wireName = 'DataSourceType';

  @override
  Object serialize(Serializers serializers, DataSourceType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  DataSourceType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DataSourceType.valueOf(serialized as String);
}

class _$AISuggestionRequestInput extends AISuggestionRequestInput {
  @override
  final String id;
  @override
  final String? userId;
  @override
  final DateTime createdAt;
  @override
  final DataSourceType dataSourceType;
  @override
  final PersonalizationContext personalizationContext;
  @override
  final HabitAnalysis? habitAnalysis;

  factory _$AISuggestionRequestInput(
          [void Function(AISuggestionRequestInputBuilder)? updates]) =>
      (new AISuggestionRequestInputBuilder()..update(updates))._build();

  _$AISuggestionRequestInput._(
      {required this.id,
      this.userId,
      required this.createdAt,
      required this.dataSourceType,
      required this.personalizationContext,
      this.habitAnalysis})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'AISuggestionRequestInput', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'AISuggestionRequestInput', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        dataSourceType, r'AISuggestionRequestInput', 'dataSourceType');
    BuiltValueNullFieldError.checkNotNull(personalizationContext,
        r'AISuggestionRequestInput', 'personalizationContext');
  }

  @override
  AISuggestionRequestInput rebuild(
          void Function(AISuggestionRequestInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AISuggestionRequestInputBuilder toBuilder() =>
      new AISuggestionRequestInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AISuggestionRequestInput &&
        id == other.id &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        dataSourceType == other.dataSourceType &&
        personalizationContext == other.personalizationContext &&
        habitAnalysis == other.habitAnalysis;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, dataSourceType.hashCode);
    _$hash = $jc(_$hash, personalizationContext.hashCode);
    _$hash = $jc(_$hash, habitAnalysis.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AISuggestionRequestInput')
          ..add('id', id)
          ..add('userId', userId)
          ..add('createdAt', createdAt)
          ..add('dataSourceType', dataSourceType)
          ..add('personalizationContext', personalizationContext)
          ..add('habitAnalysis', habitAnalysis))
        .toString();
  }
}

class AISuggestionRequestInputBuilder
    implements
        Builder<AISuggestionRequestInput, AISuggestionRequestInputBuilder> {
  _$AISuggestionRequestInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DataSourceType? _dataSourceType;
  DataSourceType? get dataSourceType => _$this._dataSourceType;
  set dataSourceType(DataSourceType? dataSourceType) =>
      _$this._dataSourceType = dataSourceType;

  PersonalizationContextBuilder? _personalizationContext;
  PersonalizationContextBuilder get personalizationContext =>
      _$this._personalizationContext ??= new PersonalizationContextBuilder();
  set personalizationContext(
          PersonalizationContextBuilder? personalizationContext) =>
      _$this._personalizationContext = personalizationContext;

  HabitAnalysisBuilder? _habitAnalysis;
  HabitAnalysisBuilder get habitAnalysis =>
      _$this._habitAnalysis ??= new HabitAnalysisBuilder();
  set habitAnalysis(HabitAnalysisBuilder? habitAnalysis) =>
      _$this._habitAnalysis = habitAnalysis;

  AISuggestionRequestInputBuilder() {
    AISuggestionRequestInput._setDefaults(this);
  }

  AISuggestionRequestInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _createdAt = $v.createdAt;
      _dataSourceType = $v.dataSourceType;
      _personalizationContext = $v.personalizationContext.toBuilder();
      _habitAnalysis = $v.habitAnalysis?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AISuggestionRequestInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AISuggestionRequestInput;
  }

  @override
  void update(void Function(AISuggestionRequestInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AISuggestionRequestInput build() => _build();

  _$AISuggestionRequestInput _build() {
    _$AISuggestionRequestInput _$result;
    try {
      _$result = _$v ??
          new _$AISuggestionRequestInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'AISuggestionRequestInput', 'id'),
            userId: userId,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'AISuggestionRequestInput', 'createdAt'),
            dataSourceType: BuiltValueNullFieldError.checkNotNull(
                dataSourceType, r'AISuggestionRequestInput', 'dataSourceType'),
            personalizationContext: personalizationContext.build(),
            habitAnalysis: _habitAnalysis?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'personalizationContext';
        personalizationContext.build();
        _$failedField = 'habitAnalysis';
        _habitAnalysis?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AISuggestionRequestInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
