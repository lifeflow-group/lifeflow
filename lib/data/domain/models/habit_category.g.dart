// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitCategory> _$habitCategorySerializer =
    new _$HabitCategorySerializer();

class _$HabitCategorySerializer implements StructuredSerializer<HabitCategory> {
  @override
  final Iterable<Type> types = const [HabitCategory, _$HabitCategory];
  @override
  final String wireName = 'HabitCategory';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitCategory object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'label',
      serializers.serialize(object.label,
          specifiedType: const FullType(String)),
      'iconPath',
      serializers.serialize(object.iconPath,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  HabitCategory deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitCategoryBuilder();

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
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'iconPath':
          result.iconPath = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HabitCategory extends HabitCategory {
  @override
  final String id;
  @override
  final String label;
  @override
  final String iconPath;

  factory _$HabitCategory([void Function(HabitCategoryBuilder)? updates]) =>
      (new HabitCategoryBuilder()..update(updates))._build();

  _$HabitCategory._(
      {required this.id, required this.label, required this.iconPath})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'HabitCategory', 'id');
    BuiltValueNullFieldError.checkNotNull(label, r'HabitCategory', 'label');
    BuiltValueNullFieldError.checkNotNull(
        iconPath, r'HabitCategory', 'iconPath');
  }

  @override
  HabitCategory rebuild(void Function(HabitCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitCategoryBuilder toBuilder() => new HabitCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitCategory &&
        id == other.id &&
        label == other.label &&
        iconPath == other.iconPath;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, iconPath.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitCategory')
          ..add('id', id)
          ..add('label', label)
          ..add('iconPath', iconPath))
        .toString();
  }
}

class HabitCategoryBuilder
    implements Builder<HabitCategory, HabitCategoryBuilder> {
  _$HabitCategory? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _iconPath;
  String? get iconPath => _$this._iconPath;
  set iconPath(String? iconPath) => _$this._iconPath = iconPath;

  HabitCategoryBuilder();

  HabitCategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _iconPath = $v.iconPath;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitCategory other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitCategory;
  }

  @override
  void update(void Function(HabitCategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitCategory build() => _build();

  _$HabitCategory _build() {
    final _$result = _$v ??
        new _$HabitCategory._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'HabitCategory', 'id'),
          label: BuiltValueNullFieldError.checkNotNull(
              label, r'HabitCategory', 'label'),
          iconPath: BuiltValueNullFieldError.checkNotNull(
              iconPath, r'HabitCategory', 'iconPath'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
