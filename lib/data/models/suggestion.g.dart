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
      'icon',
      serializers.serialize(object.icon, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.habit;
    if (value != null) {
      result
        ..add('habit')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Habit)));
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
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'habit':
          result.habit.replace(serializers.deserialize(value,
              specifiedType: const FullType(Habit))! as Habit);
          break;
      }
    }

    return result.build();
  }
}

class _$Suggestion extends Suggestion {
  @override
  final String icon;
  @override
  final String title;
  @override
  final String description;
  @override
  final Habit? habit;

  factory _$Suggestion([void Function(SuggestionBuilder)? updates]) =>
      (new SuggestionBuilder()..update(updates))._build();

  _$Suggestion._(
      {required this.icon,
      required this.title,
      required this.description,
      this.habit})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(icon, r'Suggestion', 'icon');
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
        icon == other.icon &&
        title == other.title &&
        description == other.description &&
        habit == other.habit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, habit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Suggestion')
          ..add('icon', icon)
          ..add('title', title)
          ..add('description', description)
          ..add('habit', habit))
        .toString();
  }
}

class SuggestionBuilder implements Builder<Suggestion, SuggestionBuilder> {
  _$Suggestion? _$v;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  HabitBuilder? _habit;
  HabitBuilder get habit => _$this._habit ??= new HabitBuilder();
  set habit(HabitBuilder? habit) => _$this._habit = habit;

  SuggestionBuilder();

  SuggestionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _icon = $v.icon;
      _title = $v.title;
      _description = $v.description;
      _habit = $v.habit?.toBuilder();
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
            icon: BuiltValueNullFieldError.checkNotNull(
                icon, r'Suggestion', 'icon'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'Suggestion', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'Suggestion', 'description'),
            habit: _habit?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'habit';
        _habit?.build();
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
