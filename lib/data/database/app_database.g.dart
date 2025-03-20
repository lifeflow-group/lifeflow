// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitCategoryTableTable extends HabitCategoryTable
    with TableInfo<$HabitCategoryTableTable, HabitCategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconPathMeta =
      const VerificationMeta('iconPath');
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
      'icon_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, label, iconPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_category_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<HabitCategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('icon_path')) {
      context.handle(_iconPathMeta,
          iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta));
    } else if (isInserting) {
      context.missing(_iconPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitCategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCategoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      iconPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_path'])!,
    );
  }

  @override
  $HabitCategoryTableTable createAlias(String alias) {
    return $HabitCategoryTableTable(attachedDatabase, alias);
  }
}

class HabitCategoryTableData extends DataClass
    implements Insertable<HabitCategoryTableData> {
  final String id;
  final String label;
  final String iconPath;
  const HabitCategoryTableData(
      {required this.id, required this.label, required this.iconPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['icon_path'] = Variable<String>(iconPath);
    return map;
  }

  HabitCategoryTableCompanion toCompanion(bool nullToAbsent) {
    return HabitCategoryTableCompanion(
      id: Value(id),
      label: Value(label),
      iconPath: Value(iconPath),
    );
  }

  factory HabitCategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCategoryTableData(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      iconPath: serializer.fromJson<String>(json['iconPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'iconPath': serializer.toJson<String>(iconPath),
    };
  }

  HabitCategoryTableData copyWith(
          {String? id, String? label, String? iconPath}) =>
      HabitCategoryTableData(
        id: id ?? this.id,
        label: label ?? this.label,
        iconPath: iconPath ?? this.iconPath,
      );
  HabitCategoryTableData copyWithCompanion(HabitCategoryTableCompanion data) {
    return HabitCategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCategoryTableData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('iconPath: $iconPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, iconPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCategoryTableData &&
          other.id == this.id &&
          other.label == this.label &&
          other.iconPath == this.iconPath);
}

class HabitCategoryTableCompanion
    extends UpdateCompanion<HabitCategoryTableData> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> iconPath;
  final Value<int> rowid;
  const HabitCategoryTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitCategoryTableCompanion.insert({
    required String id,
    required String label,
    required String iconPath,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        label = Value(label),
        iconPath = Value(iconPath);
  static Insertable<HabitCategoryTableData> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? iconPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (iconPath != null) 'icon_path': iconPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitCategoryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<String>? iconPath,
      Value<int>? rowid}) {
    return HabitCategoryTableCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      iconPath: iconPath ?? this.iconPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('iconPath: $iconPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitTableTable extends HabitTable
    with TableInfo<$HabitTableTable, HabitTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES habit_category_table (id)'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _repeatFrequencyMeta =
      const VerificationMeta('repeatFrequency');
  @override
  late final GeneratedColumn<String> repeatFrequency = GeneratedColumn<String>(
      'repeat_frequency', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reminderEnabledMeta =
      const VerificationMeta('reminderEnabled');
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
      'reminder_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminder_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _trackingTypeMeta =
      const VerificationMeta('trackingType');
  @override
  late final GeneratedColumn<String> trackingType = GeneratedColumn<String>(
      'tracking_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
      'progress', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        categoryId,
        startDate,
        repeatFrequency,
        reminderEnabled,
        trackingType,
        quantity,
        unit,
        progress,
        completed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_table';
  @override
  VerificationContext validateIntegrity(Insertable<HabitTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('repeat_frequency')) {
      context.handle(
          _repeatFrequencyMeta,
          repeatFrequency.isAcceptableOrUnknown(
              data['repeat_frequency']!, _repeatFrequencyMeta));
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
          _reminderEnabledMeta,
          reminderEnabled.isAcceptableOrUnknown(
              data['reminder_enabled']!, _reminderEnabledMeta));
    }
    if (data.containsKey('tracking_type')) {
      context.handle(
          _trackingTypeMeta,
          trackingType.isAcceptableOrUnknown(
              data['tracking_type']!, _trackingTypeMeta));
    } else if (isInserting) {
      context.missing(_trackingTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      repeatFrequency: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}repeat_frequency']),
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reminder_enabled'])!,
      trackingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tracking_type'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}progress']),
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed']),
    );
  }

  @override
  $HabitTableTable createAlias(String alias) {
    return $HabitTableTable(attachedDatabase, alias);
  }
}

class HabitTableData extends DataClass implements Insertable<HabitTableData> {
  final String id;
  final String name;
  final String categoryId;
  final DateTime startDate;
  final String? repeatFrequency;
  final bool reminderEnabled;
  final String trackingType;
  final int? quantity;
  final String? unit;
  final int? progress;
  final bool? completed;
  const HabitTableData(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.startDate,
      this.repeatFrequency,
      required this.reminderEnabled,
      required this.trackingType,
      this.quantity,
      this.unit,
      this.progress,
      this.completed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || repeatFrequency != null) {
      map['repeat_frequency'] = Variable<String>(repeatFrequency);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['tracking_type'] = Variable<String>(trackingType);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || progress != null) {
      map['progress'] = Variable<int>(progress);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    return map;
  }

  HabitTableCompanion toCompanion(bool nullToAbsent) {
    return HabitTableCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: Value(categoryId),
      startDate: Value(startDate),
      repeatFrequency: repeatFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatFrequency),
      reminderEnabled: Value(reminderEnabled),
      trackingType: Value(trackingType),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      progress: progress == null && nullToAbsent
          ? const Value.absent()
          : Value(progress),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  factory HabitTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      repeatFrequency: serializer.fromJson<String?>(json['repeatFrequency']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      trackingType: serializer.fromJson<String>(json['trackingType']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      unit: serializer.fromJson<String?>(json['unit']),
      progress: serializer.fromJson<int?>(json['progress']),
      completed: serializer.fromJson<bool?>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'repeatFrequency': serializer.toJson<String?>(repeatFrequency),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'trackingType': serializer.toJson<String>(trackingType),
      'quantity': serializer.toJson<int?>(quantity),
      'unit': serializer.toJson<String?>(unit),
      'progress': serializer.toJson<int?>(progress),
      'completed': serializer.toJson<bool?>(completed),
    };
  }

  HabitTableData copyWith(
          {String? id,
          String? name,
          String? categoryId,
          DateTime? startDate,
          Value<String?> repeatFrequency = const Value.absent(),
          bool? reminderEnabled,
          String? trackingType,
          Value<int?> quantity = const Value.absent(),
          Value<String?> unit = const Value.absent(),
          Value<int?> progress = const Value.absent(),
          Value<bool?> completed = const Value.absent()}) =>
      HabitTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        startDate: startDate ?? this.startDate,
        repeatFrequency: repeatFrequency.present
            ? repeatFrequency.value
            : this.repeatFrequency,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        trackingType: trackingType ?? this.trackingType,
        quantity: quantity.present ? quantity.value : this.quantity,
        unit: unit.present ? unit.value : this.unit,
        progress: progress.present ? progress.value : this.progress,
        completed: completed.present ? completed.value : this.completed,
      );
  HabitTableData copyWithCompanion(HabitTableCompanion data) {
    return HabitTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      repeatFrequency: data.repeatFrequency.present
          ? data.repeatFrequency.value
          : this.repeatFrequency,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      trackingType: data.trackingType.present
          ? data.trackingType.value
          : this.trackingType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      progress: data.progress.present ? data.progress.value : this.progress,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('startDate: $startDate, ')
          ..write('repeatFrequency: $repeatFrequency, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('trackingType: $trackingType, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('progress: $progress, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      categoryId,
      startDate,
      repeatFrequency,
      reminderEnabled,
      trackingType,
      quantity,
      unit,
      progress,
      completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.startDate == this.startDate &&
          other.repeatFrequency == this.repeatFrequency &&
          other.reminderEnabled == this.reminderEnabled &&
          other.trackingType == this.trackingType &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.progress == this.progress &&
          other.completed == this.completed);
}

class HabitTableCompanion extends UpdateCompanion<HabitTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<DateTime> startDate;
  final Value<String?> repeatFrequency;
  final Value<bool> reminderEnabled;
  final Value<String> trackingType;
  final Value<int?> quantity;
  final Value<String?> unit;
  final Value<int?> progress;
  final Value<bool?> completed;
  final Value<int> rowid;
  const HabitTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.repeatFrequency = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.trackingType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.progress = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitTableCompanion.insert({
    required String id,
    required String name,
    required String categoryId,
    required DateTime startDate,
    this.repeatFrequency = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    required String trackingType,
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.progress = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        categoryId = Value(categoryId),
        startDate = Value(startDate),
        trackingType = Value(trackingType);
  static Insertable<HabitTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<DateTime>? startDate,
    Expression<String>? repeatFrequency,
    Expression<bool>? reminderEnabled,
    Expression<String>? trackingType,
    Expression<int>? quantity,
    Expression<String>? unit,
    Expression<int>? progress,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (startDate != null) 'start_date': startDate,
      if (repeatFrequency != null) 'repeat_frequency': repeatFrequency,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (trackingType != null) 'tracking_type': trackingType,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (progress != null) 'progress': progress,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? categoryId,
      Value<DateTime>? startDate,
      Value<String?>? repeatFrequency,
      Value<bool>? reminderEnabled,
      Value<String>? trackingType,
      Value<int?>? quantity,
      Value<String?>? unit,
      Value<int?>? progress,
      Value<bool?>? completed,
      Value<int>? rowid}) {
    return HabitTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      startDate: startDate ?? this.startDate,
      repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      trackingType: trackingType ?? this.trackingType,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      progress: progress ?? this.progress,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (repeatFrequency.present) {
      map['repeat_frequency'] = Variable<String>(repeatFrequency.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (trackingType.present) {
      map['tracking_type'] = Variable<String>(trackingType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('startDate: $startDate, ')
          ..write('repeatFrequency: $repeatFrequency, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('trackingType: $trackingType, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('progress: $progress, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitCategoryTableTable habitCategoryTable =
      $HabitCategoryTableTable(this);
  late final $HabitTableTable habitTable = $HabitTableTable(this);
  late final HabitDao habitDao = HabitDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [habitCategoryTable, habitTable];
}

typedef $$HabitCategoryTableTableCreateCompanionBuilder
    = HabitCategoryTableCompanion Function({
  required String id,
  required String label,
  required String iconPath,
  Value<int> rowid,
});
typedef $$HabitCategoryTableTableUpdateCompanionBuilder
    = HabitCategoryTableCompanion Function({
  Value<String> id,
  Value<String> label,
  Value<String> iconPath,
  Value<int> rowid,
});

final class $$HabitCategoryTableTableReferences extends BaseReferences<
    _$AppDatabase, $HabitCategoryTableTable, HabitCategoryTableData> {
  $$HabitCategoryTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitTableTable, List<HabitTableData>>
      _habitTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.habitTable,
              aliasName: $_aliasNameGenerator(
                  db.habitCategoryTable.id, db.habitTable.categoryId));

  $$HabitTableTableProcessedTableManager get habitTableRefs {
    final manager = $$HabitTableTableTableManager($_db, $_db.habitTable)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HabitCategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCategoryTableTable> {
  $$HabitCategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconPath => $composableBuilder(
      column: $table.iconPath, builder: (column) => ColumnFilters(column));

  Expression<bool> habitTableRefs(
      Expression<bool> Function($$HabitTableTableFilterComposer f) f) {
    final $$HabitTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitTableTableFilterComposer(
              $db: $db,
              $table: $db.habitTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitCategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCategoryTableTable> {
  $$HabitCategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconPath => $composableBuilder(
      column: $table.iconPath, builder: (column) => ColumnOrderings(column));
}

class $$HabitCategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCategoryTableTable> {
  $$HabitCategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  Expression<T> habitTableRefs<T extends Object>(
      Expression<T> Function($$HabitTableTableAnnotationComposer a) f) {
    final $$HabitTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitTableTableAnnotationComposer(
              $db: $db,
              $table: $db.habitTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitCategoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitCategoryTableTable,
    HabitCategoryTableData,
    $$HabitCategoryTableTableFilterComposer,
    $$HabitCategoryTableTableOrderingComposer,
    $$HabitCategoryTableTableAnnotationComposer,
    $$HabitCategoryTableTableCreateCompanionBuilder,
    $$HabitCategoryTableTableUpdateCompanionBuilder,
    (HabitCategoryTableData, $$HabitCategoryTableTableReferences),
    HabitCategoryTableData,
    PrefetchHooks Function({bool habitTableRefs})> {
  $$HabitCategoryTableTableTableManager(
      _$AppDatabase db, $HabitCategoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCategoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> iconPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitCategoryTableCompanion(
            id: id,
            label: label,
            iconPath: iconPath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String label,
            required String iconPath,
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitCategoryTableCompanion.insert(
            id: id,
            label: label,
            iconPath: iconPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitCategoryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({habitTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitTableRefs) db.habitTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitTableRefs)
                    await $_getPrefetchedData<HabitCategoryTableData,
                            $HabitCategoryTableTable, HabitTableData>(
                        currentTable: table,
                        referencedTable: $$HabitCategoryTableTableReferences
                            ._habitTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HabitCategoryTableTableReferences(db, table, p0)
                                .habitTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HabitCategoryTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitCategoryTableTable,
    HabitCategoryTableData,
    $$HabitCategoryTableTableFilterComposer,
    $$HabitCategoryTableTableOrderingComposer,
    $$HabitCategoryTableTableAnnotationComposer,
    $$HabitCategoryTableTableCreateCompanionBuilder,
    $$HabitCategoryTableTableUpdateCompanionBuilder,
    (HabitCategoryTableData, $$HabitCategoryTableTableReferences),
    HabitCategoryTableData,
    PrefetchHooks Function({bool habitTableRefs})>;
typedef $$HabitTableTableCreateCompanionBuilder = HabitTableCompanion Function({
  required String id,
  required String name,
  required String categoryId,
  required DateTime startDate,
  Value<String?> repeatFrequency,
  Value<bool> reminderEnabled,
  required String trackingType,
  Value<int?> quantity,
  Value<String?> unit,
  Value<int?> progress,
  Value<bool?> completed,
  Value<int> rowid,
});
typedef $$HabitTableTableUpdateCompanionBuilder = HabitTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> categoryId,
  Value<DateTime> startDate,
  Value<String?> repeatFrequency,
  Value<bool> reminderEnabled,
  Value<String> trackingType,
  Value<int?> quantity,
  Value<String?> unit,
  Value<int?> progress,
  Value<bool?> completed,
  Value<int> rowid,
});

final class $$HabitTableTableReferences
    extends BaseReferences<_$AppDatabase, $HabitTableTable, HabitTableData> {
  $$HabitTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitCategoryTableTable _categoryIdTable(_$AppDatabase db) =>
      db.habitCategoryTable.createAlias($_aliasNameGenerator(
          db.habitTable.categoryId, db.habitCategoryTable.id));

  $$HabitCategoryTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager =
        $$HabitCategoryTableTableTableManager($_db, $_db.habitCategoryTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HabitTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitTableTable> {
  $$HabitTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repeatFrequency => $composableBuilder(
      column: $table.repeatFrequency,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackingType => $composableBuilder(
      column: $table.trackingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  $$HabitCategoryTableTableFilterComposer get categoryId {
    final $$HabitCategoryTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.habitCategoryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitCategoryTableTableFilterComposer(
              $db: $db,
              $table: $db.habitCategoryTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitTableTable> {
  $$HabitTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repeatFrequency => $composableBuilder(
      column: $table.repeatFrequency,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackingType => $composableBuilder(
      column: $table.trackingType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  $$HabitCategoryTableTableOrderingComposer get categoryId {
    final $$HabitCategoryTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.habitCategoryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitCategoryTableTableOrderingComposer(
              $db: $db,
              $table: $db.habitCategoryTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitTableTable> {
  $$HabitTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get repeatFrequency => $composableBuilder(
      column: $table.repeatFrequency, builder: (column) => column);

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get trackingType => $composableBuilder(
      column: $table.trackingType, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$HabitCategoryTableTableAnnotationComposer get categoryId {
    final $$HabitCategoryTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.habitCategoryTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$HabitCategoryTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.habitCategoryTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$HabitTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitTableTable,
    HabitTableData,
    $$HabitTableTableFilterComposer,
    $$HabitTableTableOrderingComposer,
    $$HabitTableTableAnnotationComposer,
    $$HabitTableTableCreateCompanionBuilder,
    $$HabitTableTableUpdateCompanionBuilder,
    (HabitTableData, $$HabitTableTableReferences),
    HabitTableData,
    PrefetchHooks Function({bool categoryId})> {
  $$HabitTableTableTableManager(_$AppDatabase db, $HabitTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<String?> repeatFrequency = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            Value<String> trackingType = const Value.absent(),
            Value<int?> quantity = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<int?> progress = const Value.absent(),
            Value<bool?> completed = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitTableCompanion(
            id: id,
            name: name,
            categoryId: categoryId,
            startDate: startDate,
            repeatFrequency: repeatFrequency,
            reminderEnabled: reminderEnabled,
            trackingType: trackingType,
            quantity: quantity,
            unit: unit,
            progress: progress,
            completed: completed,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String categoryId,
            required DateTime startDate,
            Value<String?> repeatFrequency = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            required String trackingType,
            Value<int?> quantity = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<int?> progress = const Value.absent(),
            Value<bool?> completed = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitTableCompanion.insert(
            id: id,
            name: name,
            categoryId: categoryId,
            startDate: startDate,
            repeatFrequency: repeatFrequency,
            reminderEnabled: reminderEnabled,
            trackingType: trackingType,
            quantity: quantity,
            unit: unit,
            progress: progress,
            completed: completed,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$HabitTableTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$HabitTableTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HabitTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitTableTable,
    HabitTableData,
    $$HabitTableTableFilterComposer,
    $$HabitTableTableOrderingComposer,
    $$HabitTableTableAnnotationComposer,
    $$HabitTableTableCreateCompanionBuilder,
    $$HabitTableTableUpdateCompanionBuilder,
    (HabitTableData, $$HabitTableTableReferences),
    HabitTableData,
    PrefetchHooks Function({bool categoryId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitCategoryTableTableTableManager get habitCategoryTable =>
      $$HabitCategoryTableTableTableManager(_db, _db.habitCategoryTable);
  $$HabitTableTableTableManager get habitTable =>
      $$HabitTableTableTableManager(_db, _db.habitTable);
}
