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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'iconPath',
      serializers.serialize(object.iconPath,
          specifiedType: const FullType(String)),
      'colorHex',
      serializers.serialize(object.colorHex,
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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'iconPath':
          result.iconPath = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'colorHex':
          result.colorHex = serializers.deserialize(value,
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
  final String name;
  @override
  final String iconPath;
  @override
  final String colorHex;

  factory _$HabitCategory([void Function(HabitCategoryBuilder)? updates]) =>
      (new HabitCategoryBuilder()..update(updates))._build();

  _$HabitCategory._(
      {required this.id,
      required this.name,
      required this.iconPath,
      required this.colorHex})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'HabitCategory', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'HabitCategory', 'name');
    BuiltValueNullFieldError.checkNotNull(
        iconPath, r'HabitCategory', 'iconPath');
    BuiltValueNullFieldError.checkNotNull(
        colorHex, r'HabitCategory', 'colorHex');
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
        name == other.name &&
        iconPath == other.iconPath &&
        colorHex == other.colorHex;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, iconPath.hashCode);
    _$hash = $jc(_$hash, colorHex.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitCategory')
          ..add('id', id)
          ..add('name', name)
          ..add('iconPath', iconPath)
          ..add('colorHex', colorHex))
        .toString();
  }
}

class HabitCategoryBuilder
    implements Builder<HabitCategory, HabitCategoryBuilder> {
  _$HabitCategory? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _iconPath;
  String? get iconPath => _$this._iconPath;
  set iconPath(String? iconPath) => _$this._iconPath = iconPath;

  String? _colorHex;
  String? get colorHex => _$this._colorHex;
  set colorHex(String? colorHex) => _$this._colorHex = colorHex;

  HabitCategoryBuilder();

  HabitCategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _iconPath = $v.iconPath;
      _colorHex = $v.colorHex;
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
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'HabitCategory', 'name'),
          iconPath: BuiltValueNullFieldError.checkNotNull(
              iconPath, r'HabitCategory', 'iconPath'),
          colorHex: BuiltValueNullFieldError.checkNotNull(
              colorHex, r'HabitCategory', 'colorHex'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
