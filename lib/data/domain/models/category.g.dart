// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Category> _$categorySerializer = new _$CategorySerializer();

class _$CategorySerializer implements StructuredSerializer<Category> {
  @override
  final Iterable<Type> types = const [Category, _$Category];
  @override
  final String wireName = 'Category';

  @override
  Iterable<Object?> serialize(Serializers serializers, Category object,
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
  Category deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CategoryBuilder();

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

class _$Category extends Category {
  @override
  final String id;
  @override
  final String name;
  @override
  final String iconPath;
  @override
  final String colorHex;

  factory _$Category([void Function(CategoryBuilder)? updates]) =>
      (new CategoryBuilder()..update(updates))._build();

  _$Category._(
      {required this.id,
      required this.name,
      required this.iconPath,
      required this.colorHex})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Category', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'Category', 'name');
    BuiltValueNullFieldError.checkNotNull(iconPath, r'Category', 'iconPath');
    BuiltValueNullFieldError.checkNotNull(colorHex, r'Category', 'colorHex');
  }

  @override
  Category rebuild(void Function(CategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryBuilder toBuilder() => new CategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Category &&
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
    return (newBuiltValueToStringHelper(r'Category')
          ..add('id', id)
          ..add('name', name)
          ..add('iconPath', iconPath)
          ..add('colorHex', colorHex))
        .toString();
  }
}

class CategoryBuilder implements Builder<Category, CategoryBuilder> {
  _$Category? _$v;

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

  CategoryBuilder();

  CategoryBuilder get _$this {
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
  void replace(Category other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Category;
  }

  @override
  void update(void Function(CategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Category build() => _build();

  _$Category _build() {
    final _$result = _$v ??
        new _$Category._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Category', 'id'),
          name:
              BuiltValueNullFieldError.checkNotNull(name, r'Category', 'name'),
          iconPath: BuiltValueNullFieldError.checkNotNull(
              iconPath, r'Category', 'iconPath'),
          colorHex: BuiltValueNullFieldError.checkNotNull(
              colorHex, r'Category', 'colorHex'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
