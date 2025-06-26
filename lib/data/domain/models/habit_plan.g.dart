// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitPlan> _$habitPlanSerializer = new _$HabitPlanSerializer();

class _$HabitPlanSerializer implements StructuredSerializer<HabitPlan> {
  @override
  final Iterable<Type> types = const [HabitPlan, _$HabitPlan];
  @override
  final String wireName = 'HabitPlan';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitPlan object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(Category)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'imagePath',
      serializers.serialize(object.imagePath,
          specifiedType: const FullType(String)),
      'suggestions',
      serializers.serialize(object.suggestions,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Suggestion)])),
    ];

    return result;
  }

  @override
  HabitPlan deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitPlanBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category':
          result.category.replace(serializers.deserialize(value,
              specifiedType: const FullType(Category))! as Category);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imagePath':
          result.imagePath = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'suggestions':
          result.suggestions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Suggestion)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$HabitPlan extends HabitPlan {
  @override
  final String id;
  @override
  final String title;
  @override
  final Category category;
  @override
  final String description;
  @override
  final String imagePath;
  @override
  final BuiltList<Suggestion> suggestions;

  factory _$HabitPlan([void Function(HabitPlanBuilder)? updates]) =>
      (new HabitPlanBuilder()..update(updates))._build();

  _$HabitPlan._(
      {required this.id,
      required this.title,
      required this.category,
      required this.description,
      required this.imagePath,
      required this.suggestions})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'HabitPlan', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'HabitPlan', 'title');
    BuiltValueNullFieldError.checkNotNull(category, r'HabitPlan', 'category');
    BuiltValueNullFieldError.checkNotNull(
        description, r'HabitPlan', 'description');
    BuiltValueNullFieldError.checkNotNull(imagePath, r'HabitPlan', 'imagePath');
    BuiltValueNullFieldError.checkNotNull(
        suggestions, r'HabitPlan', 'suggestions');
  }

  @override
  HabitPlan rebuild(void Function(HabitPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitPlanBuilder toBuilder() => new HabitPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitPlan &&
        id == other.id &&
        title == other.title &&
        category == other.category &&
        description == other.description &&
        imagePath == other.imagePath &&
        suggestions == other.suggestions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, imagePath.hashCode);
    _$hash = $jc(_$hash, suggestions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitPlan')
          ..add('id', id)
          ..add('title', title)
          ..add('category', category)
          ..add('description', description)
          ..add('imagePath', imagePath)
          ..add('suggestions', suggestions))
        .toString();
  }
}

class HabitPlanBuilder implements Builder<HabitPlan, HabitPlanBuilder> {
  _$HabitPlan? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CategoryBuilder? _category;
  CategoryBuilder get category => _$this._category ??= new CategoryBuilder();
  set category(CategoryBuilder? category) => _$this._category = category;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _imagePath;
  String? get imagePath => _$this._imagePath;
  set imagePath(String? imagePath) => _$this._imagePath = imagePath;

  ListBuilder<Suggestion>? _suggestions;
  ListBuilder<Suggestion> get suggestions =>
      _$this._suggestions ??= new ListBuilder<Suggestion>();
  set suggestions(ListBuilder<Suggestion>? suggestions) =>
      _$this._suggestions = suggestions;

  HabitPlanBuilder();

  HabitPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _category = $v.category.toBuilder();
      _description = $v.description;
      _imagePath = $v.imagePath;
      _suggestions = $v.suggestions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitPlan other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitPlan;
  }

  @override
  void update(void Function(HabitPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitPlan build() => _build();

  _$HabitPlan _build() {
    _$HabitPlan _$result;
    try {
      _$result = _$v ??
          new _$HabitPlan._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'HabitPlan', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'HabitPlan', 'title'),
            category: category.build(),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'HabitPlan', 'description'),
            imagePath: BuiltValueNullFieldError.checkNotNull(
                imagePath, r'HabitPlan', 'imagePath'),
            suggestions: suggestions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'category';
        category.build();

        _$failedField = 'suggestions';
        suggestions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HabitPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
