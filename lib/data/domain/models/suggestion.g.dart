// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Suggestion> _$suggestionSerializer = new _$SuggestionSerializer();

class _$SuggestionSerializer implements StructuredSerializer<Suggestion> {
  @override
  final Iterable<Type> types = const [Suggestion, _$Suggestion];
  @override
  final String wireName = 'Suggestion';

  @override
  Iterable<Object?> serialize(Serializers serializers, Suggestion object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.habitData;
    if (value != null) {
      result
        ..add('habitData')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(HabitData)));
    }
    return result;
  }

  @override
  Suggestion deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SuggestionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'habitData':
          result.habitData.replace(serializers.deserialize(value,
              specifiedType: const FullType(HabitData))! as HabitData);
          break;
      }
    }

    return result.build();
  }
}

class _$Suggestion extends Suggestion {
  @override
  final String title;
  @override
  final String description;
  @override
  final HabitData? habitData;

  factory _$Suggestion([void Function(SuggestionBuilder)? updates]) =>
      (new SuggestionBuilder()..update(updates))._build();

  _$Suggestion._(
      {required this.title, required this.description, this.habitData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(title, r'Suggestion', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'Suggestion', 'description');
  }

  @override
  Suggestion rebuild(void Function(SuggestionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuggestionBuilder toBuilder() => new SuggestionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Suggestion &&
        title == other.title &&
        description == other.description &&
        habitData == other.habitData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, habitData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Suggestion')
          ..add('title', title)
          ..add('description', description)
          ..add('habitData', habitData))
        .toString();
  }
}

class SuggestionBuilder implements Builder<Suggestion, SuggestionBuilder> {
  _$Suggestion? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  HabitDataBuilder? _habitData;
  HabitDataBuilder get habitData =>
      _$this._habitData ??= new HabitDataBuilder();
  set habitData(HabitDataBuilder? habitData) => _$this._habitData = habitData;

  SuggestionBuilder();

  SuggestionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _habitData = $v.habitData?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Suggestion other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Suggestion;
  }

  @override
  void update(void Function(SuggestionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Suggestion build() => _build();

  _$Suggestion _build() {
    _$Suggestion _$result;
    try {
      _$result = _$v ??
          new _$Suggestion._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'Suggestion', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'Suggestion', 'description'),
            habitData: _habitData?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'habitData';
        _habitData?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Suggestion', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
