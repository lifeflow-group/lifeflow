// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitCategoriesTableTable extends HabitCategoriesTable
    with TableInfo<$HabitCategoriesTableTable, HabitCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCategoriesTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'habit_categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<HabitCategoriesTableData> instance,
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
  HabitCategoriesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      iconPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_path'])!,
    );
  }

  @override
  $HabitCategoriesTableTable createAlias(String alias) {
    return $HabitCategoriesTableTable(attachedDatabase, alias);
  }
}

class HabitCategoriesTableData extends DataClass
    implements Insertable<HabitCategoriesTableData> {
  final String id;
  final String label;
  final String iconPath;
  const HabitCategoriesTableData(
      {required this.id, required this.label, required this.iconPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['icon_path'] = Variable<String>(iconPath);
    return map;
  }

  HabitCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return HabitCategoriesTableCompanion(
      id: Value(id),
      label: Value(label),
      iconPath: Value(iconPath),
    );
  }

  factory HabitCategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCategoriesTableData(
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

  HabitCategoriesTableData copyWith(
          {String? id, String? label, String? iconPath}) =>
      HabitCategoriesTableData(
        id: id ?? this.id,
        label: label ?? this.label,
        iconPath: iconPath ?? this.iconPath,
      );
  HabitCategoriesTableData copyWithCompanion(
      HabitCategoriesTableCompanion data) {
    return HabitCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCategoriesTableData(')
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
      (other is HabitCategoriesTableData &&
          other.id == this.id &&
          other.label == this.label &&
          other.iconPath == this.iconPath);
}

class HabitCategoriesTableCompanion
    extends UpdateCompanion<HabitCategoriesTableData> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> iconPath;
  final Value<int> rowid;
  const HabitCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitCategoriesTableCompanion.insert({
    required String id,
    required String label,
    required String iconPath,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        label = Value(label),
        iconPath = Value(iconPath);
  static Insertable<HabitCategoriesTableData> custom({
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

  HabitCategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<String>? iconPath,
      Value<int>? rowid}) {
    return HabitCategoriesTableCompanion(
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
    return (StringBuffer('HabitCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('iconPath: $iconPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTableTable extends HabitsTable
    with TableInfo<$HabitsTableTable, HabitsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
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
          'REFERENCES habit_categories_table (id)'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _habitSeriesIdMeta =
      const VerificationMeta('habitSeriesId');
  @override
  late final GeneratedColumn<String> habitSeriesId = GeneratedColumn<String>(
      'habit_series_id', aliasedName, true,
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
  static const VerificationMeta _targetValueMeta =
      const VerificationMeta('targetValue');
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
      'target_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currentValueMeta =
      const VerificationMeta('currentValue');
  @override
  late final GeneratedColumn<int> currentValue = GeneratedColumn<int>(
      'current_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        categoryId,
        startDate,
        habitSeriesId,
        reminderEnabled,
        trackingType,
        targetValue,
        currentValue,
        unit,
        isCompleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits_table';
  @override
  VerificationContext validateIntegrity(Insertable<HabitsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
    if (data.containsKey('habit_series_id')) {
      context.handle(
          _habitSeriesIdMeta,
          habitSeriesId.isAcceptableOrUnknown(
              data['habit_series_id']!, _habitSeriesIdMeta));
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
    if (data.containsKey('target_value')) {
      context.handle(
          _targetValueMeta,
          targetValue.isAcceptableOrUnknown(
              data['target_value']!, _targetValueMeta));
    }
    if (data.containsKey('current_value')) {
      context.handle(
          _currentValueMeta,
          currentValue.isAcceptableOrUnknown(
              data['current_value']!, _currentValueMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      habitSeriesId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_series_id']),
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reminder_enabled'])!,
      trackingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tracking_type'])!,
      targetValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_value']),
      currentValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_value']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed']),
    );
  }

  @override
  $HabitsTableTable createAlias(String alias) {
    return $HabitsTableTable(attachedDatabase, alias);
  }
}

class HabitsTableData extends DataClass implements Insertable<HabitsTableData> {
  final String id;
  final String userId;
  final String name;
  final String categoryId;
  final DateTime startDate;
  final String? habitSeriesId;
  final bool reminderEnabled;
  final String trackingType;
  final int? targetValue;
  final int? currentValue;
  final String? unit;
  final bool? isCompleted;
  const HabitsTableData(
      {required this.id,
      required this.userId,
      required this.name,
      required this.categoryId,
      required this.startDate,
      this.habitSeriesId,
      required this.reminderEnabled,
      required this.trackingType,
      this.targetValue,
      this.currentValue,
      this.unit,
      this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || habitSeriesId != null) {
      map['habit_series_id'] = Variable<String>(habitSeriesId);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['tracking_type'] = Variable<String>(trackingType);
    if (!nullToAbsent || targetValue != null) {
      map['target_value'] = Variable<int>(targetValue);
    }
    if (!nullToAbsent || currentValue != null) {
      map['current_value'] = Variable<int>(currentValue);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || isCompleted != null) {
      map['is_completed'] = Variable<bool>(isCompleted);
    }
    return map;
  }

  HabitsTableCompanion toCompanion(bool nullToAbsent) {
    return HabitsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      categoryId: Value(categoryId),
      startDate: Value(startDate),
      habitSeriesId: habitSeriesId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitSeriesId),
      reminderEnabled: Value(reminderEnabled),
      trackingType: Value(trackingType),
      targetValue: targetValue == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue),
      currentValue: currentValue == null && nullToAbsent
          ? const Value.absent()
          : Value(currentValue),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      isCompleted: isCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isCompleted),
    );
  }

  factory HabitsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      habitSeriesId: serializer.fromJson<String?>(json['habitSeriesId']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      trackingType: serializer.fromJson<String>(json['trackingType']),
      targetValue: serializer.fromJson<int?>(json['targetValue']),
      currentValue: serializer.fromJson<int?>(json['currentValue']),
      unit: serializer.fromJson<String?>(json['unit']),
      isCompleted: serializer.fromJson<bool?>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'habitSeriesId': serializer.toJson<String?>(habitSeriesId),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'trackingType': serializer.toJson<String>(trackingType),
      'targetValue': serializer.toJson<int?>(targetValue),
      'currentValue': serializer.toJson<int?>(currentValue),
      'unit': serializer.toJson<String?>(unit),
      'isCompleted': serializer.toJson<bool?>(isCompleted),
    };
  }

  HabitsTableData copyWith(
          {String? id,
          String? userId,
          String? name,
          String? categoryId,
          DateTime? startDate,
          Value<String?> habitSeriesId = const Value.absent(),
          bool? reminderEnabled,
          String? trackingType,
          Value<int?> targetValue = const Value.absent(),
          Value<int?> currentValue = const Value.absent(),
          Value<String?> unit = const Value.absent(),
          Value<bool?> isCompleted = const Value.absent()}) =>
      HabitsTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        startDate: startDate ?? this.startDate,
        habitSeriesId:
            habitSeriesId.present ? habitSeriesId.value : this.habitSeriesId,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        trackingType: trackingType ?? this.trackingType,
        targetValue: targetValue.present ? targetValue.value : this.targetValue,
        currentValue:
            currentValue.present ? currentValue.value : this.currentValue,
        unit: unit.present ? unit.value : this.unit,
        isCompleted: isCompleted.present ? isCompleted.value : this.isCompleted,
      );
  HabitsTableData copyWithCompanion(HabitsTableCompanion data) {
    return HabitsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      habitSeriesId: data.habitSeriesId.present
          ? data.habitSeriesId.value
          : this.habitSeriesId,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      trackingType: data.trackingType.present
          ? data.trackingType.value
          : this.trackingType,
      targetValue:
          data.targetValue.present ? data.targetValue.value : this.targetValue,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
      unit: data.unit.present ? data.unit.value : this.unit,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('startDate: $startDate, ')
          ..write('habitSeriesId: $habitSeriesId, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('trackingType: $trackingType, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentValue: $currentValue, ')
          ..write('unit: $unit, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      categoryId,
      startDate,
      habitSeriesId,
      reminderEnabled,
      trackingType,
      targetValue,
      currentValue,
      unit,
      isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.startDate == this.startDate &&
          other.habitSeriesId == this.habitSeriesId &&
          other.reminderEnabled == this.reminderEnabled &&
          other.trackingType == this.trackingType &&
          other.targetValue == this.targetValue &&
          other.currentValue == this.currentValue &&
          other.unit == this.unit &&
          other.isCompleted == this.isCompleted);
}

class HabitsTableCompanion extends UpdateCompanion<HabitsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<DateTime> startDate;
  final Value<String?> habitSeriesId;
  final Value<bool> reminderEnabled;
  final Value<String> trackingType;
  final Value<int?> targetValue;
  final Value<int?> currentValue;
  final Value<String?> unit;
  final Value<bool?> isCompleted;
  final Value<int> rowid;
  const HabitsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.habitSeriesId = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.trackingType = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsTableCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required String categoryId,
    required DateTime startDate,
    this.habitSeriesId = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    required String trackingType,
    this.targetValue = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name),
        categoryId = Value(categoryId),
        startDate = Value(startDate),
        trackingType = Value(trackingType);
  static Insertable<HabitsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<DateTime>? startDate,
    Expression<String>? habitSeriesId,
    Expression<bool>? reminderEnabled,
    Expression<String>? trackingType,
    Expression<int>? targetValue,
    Expression<int>? currentValue,
    Expression<String>? unit,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (startDate != null) 'start_date': startDate,
      if (habitSeriesId != null) 'habit_series_id': habitSeriesId,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (trackingType != null) 'tracking_type': trackingType,
      if (targetValue != null) 'target_value': targetValue,
      if (currentValue != null) 'current_value': currentValue,
      if (unit != null) 'unit': unit,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? categoryId,
      Value<DateTime>? startDate,
      Value<String?>? habitSeriesId,
      Value<bool>? reminderEnabled,
      Value<String>? trackingType,
      Value<int?>? targetValue,
      Value<int?>? currentValue,
      Value<String?>? unit,
      Value<bool?>? isCompleted,
      Value<int>? rowid}) {
    return HabitsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      startDate: startDate ?? this.startDate,
      habitSeriesId: habitSeriesId ?? this.habitSeriesId,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      trackingType: trackingType ?? this.trackingType,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
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
    if (habitSeriesId.present) {
      map['habit_series_id'] = Variable<String>(habitSeriesId.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (trackingType.present) {
      map['tracking_type'] = Variable<String>(trackingType.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<int>(currentValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('startDate: $startDate, ')
          ..write('habitSeriesId: $habitSeriesId, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('trackingType: $trackingType, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentValue: $currentValue, ')
          ..write('unit: $unit, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitSeriesTableTable extends HabitSeriesTable
    with TableInfo<$HabitSeriesTableTable, HabitSeriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitSeriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _untilDateMeta =
      const VerificationMeta('untilDate');
  @override
  late final GeneratedColumn<DateTime> untilDate = GeneratedColumn<DateTime>(
      'until_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _repeatFrequencyMeta =
      const VerificationMeta('repeatFrequency');
  @override
  late final GeneratedColumn<String> repeatFrequency = GeneratedColumn<String>(
      'repeat_frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, habitId, startDate, untilDate, repeatFrequency];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_series_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<HabitSeriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('until_date')) {
      context.handle(_untilDateMeta,
          untilDate.isAcceptableOrUnknown(data['until_date']!, _untilDateMeta));
    }
    if (data.containsKey('repeat_frequency')) {
      context.handle(
          _repeatFrequencyMeta,
          repeatFrequency.isAcceptableOrUnknown(
              data['repeat_frequency']!, _repeatFrequencyMeta));
    } else if (isInserting) {
      context.missing(_repeatFrequencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitSeriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitSeriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      untilDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}until_date']),
      repeatFrequency: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}repeat_frequency'])!,
    );
  }

  @override
  $HabitSeriesTableTable createAlias(String alias) {
    return $HabitSeriesTableTable(attachedDatabase, alias);
  }
}

class HabitSeriesTableData extends DataClass
    implements Insertable<HabitSeriesTableData> {
  final String id;
  final String userId;
  final String habitId;
  final DateTime startDate;
  final DateTime? untilDate;
  final String repeatFrequency;
  const HabitSeriesTableData(
      {required this.id,
      required this.userId,
      required this.habitId,
      required this.startDate,
      this.untilDate,
      required this.repeatFrequency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['habit_id'] = Variable<String>(habitId);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || untilDate != null) {
      map['until_date'] = Variable<DateTime>(untilDate);
    }
    map['repeat_frequency'] = Variable<String>(repeatFrequency);
    return map;
  }

  HabitSeriesTableCompanion toCompanion(bool nullToAbsent) {
    return HabitSeriesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      habitId: Value(habitId),
      startDate: Value(startDate),
      untilDate: untilDate == null && nullToAbsent
          ? const Value.absent()
          : Value(untilDate),
      repeatFrequency: Value(repeatFrequency),
    );
  }

  factory HabitSeriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitSeriesTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      habitId: serializer.fromJson<String>(json['habitId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      untilDate: serializer.fromJson<DateTime?>(json['untilDate']),
      repeatFrequency: serializer.fromJson<String>(json['repeatFrequency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'habitId': serializer.toJson<String>(habitId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'untilDate': serializer.toJson<DateTime?>(untilDate),
      'repeatFrequency': serializer.toJson<String>(repeatFrequency),
    };
  }

  HabitSeriesTableData copyWith(
          {String? id,
          String? userId,
          String? habitId,
          DateTime? startDate,
          Value<DateTime?> untilDate = const Value.absent(),
          String? repeatFrequency}) =>
      HabitSeriesTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        habitId: habitId ?? this.habitId,
        startDate: startDate ?? this.startDate,
        untilDate: untilDate.present ? untilDate.value : this.untilDate,
        repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      );
  HabitSeriesTableData copyWithCompanion(HabitSeriesTableCompanion data) {
    return HabitSeriesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      untilDate: data.untilDate.present ? data.untilDate.value : this.untilDate,
      repeatFrequency: data.repeatFrequency.present
          ? data.repeatFrequency.value
          : this.repeatFrequency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitSeriesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('habitId: $habitId, ')
          ..write('startDate: $startDate, ')
          ..write('untilDate: $untilDate, ')
          ..write('repeatFrequency: $repeatFrequency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, habitId, startDate, untilDate, repeatFrequency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitSeriesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.habitId == this.habitId &&
          other.startDate == this.startDate &&
          other.untilDate == this.untilDate &&
          other.repeatFrequency == this.repeatFrequency);
}

class HabitSeriesTableCompanion extends UpdateCompanion<HabitSeriesTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> habitId;
  final Value<DateTime> startDate;
  final Value<DateTime?> untilDate;
  final Value<String> repeatFrequency;
  final Value<int> rowid;
  const HabitSeriesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.habitId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.untilDate = const Value.absent(),
    this.repeatFrequency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitSeriesTableCompanion.insert({
    required String id,
    required String userId,
    required String habitId,
    required DateTime startDate,
    this.untilDate = const Value.absent(),
    required String repeatFrequency,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        habitId = Value(habitId),
        startDate = Value(startDate),
        repeatFrequency = Value(repeatFrequency);
  static Insertable<HabitSeriesTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? habitId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? untilDate,
    Expression<String>? repeatFrequency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (habitId != null) 'habit_id': habitId,
      if (startDate != null) 'start_date': startDate,
      if (untilDate != null) 'until_date': untilDate,
      if (repeatFrequency != null) 'repeat_frequency': repeatFrequency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitSeriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? habitId,
      Value<DateTime>? startDate,
      Value<DateTime?>? untilDate,
      Value<String>? repeatFrequency,
      Value<int>? rowid}) {
    return HabitSeriesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      habitId: habitId ?? this.habitId,
      startDate: startDate ?? this.startDate,
      untilDate: untilDate ?? this.untilDate,
      repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (untilDate.present) {
      map['until_date'] = Variable<DateTime>(untilDate.value);
    }
    if (repeatFrequency.present) {
      map['repeat_frequency'] = Variable<String>(repeatFrequency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitSeriesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('habitId: $habitId, ')
          ..write('startDate: $startDate, ')
          ..write('untilDate: $untilDate, ')
          ..write('repeatFrequency: $repeatFrequency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitExceptionsTableTable extends HabitExceptionsTable
    with TableInfo<$HabitExceptionsTableTable, HabitExceptionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitExceptionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _habitSeriesIdMeta =
      const VerificationMeta('habitSeriesId');
  @override
  late final GeneratedColumn<String> habitSeriesId = GeneratedColumn<String>(
      'habit_series_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSkippedMeta =
      const VerificationMeta('isSkipped');
  @override
  late final GeneratedColumn<bool> isSkipped = GeneratedColumn<bool>(
      'is_skipped', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_skipped" IN (0, 1))'),
      defaultValue: const Constant(false));
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
  static const VerificationMeta _targetValueMeta =
      const VerificationMeta('targetValue');
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
      'target_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currentValueMeta =
      const VerificationMeta('currentValue');
  @override
  late final GeneratedColumn<int> currentValue = GeneratedColumn<int>(
      'current_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        habitSeriesId,
        date,
        isSkipped,
        reminderEnabled,
        targetValue,
        currentValue,
        isCompleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_exceptions_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<HabitExceptionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_series_id')) {
      context.handle(
          _habitSeriesIdMeta,
          habitSeriesId.isAcceptableOrUnknown(
              data['habit_series_id']!, _habitSeriesIdMeta));
    } else if (isInserting) {
      context.missing(_habitSeriesIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_skipped')) {
      context.handle(_isSkippedMeta,
          isSkipped.isAcceptableOrUnknown(data['is_skipped']!, _isSkippedMeta));
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
          _reminderEnabledMeta,
          reminderEnabled.isAcceptableOrUnknown(
              data['reminder_enabled']!, _reminderEnabledMeta));
    }
    if (data.containsKey('target_value')) {
      context.handle(
          _targetValueMeta,
          targetValue.isAcceptableOrUnknown(
              data['target_value']!, _targetValueMeta));
    }
    if (data.containsKey('current_value')) {
      context.handle(
          _currentValueMeta,
          currentValue.isAcceptableOrUnknown(
              data['current_value']!, _currentValueMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitExceptionsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitExceptionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      habitSeriesId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}habit_series_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isSkipped: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_skipped'])!,
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reminder_enabled'])!,
      targetValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_value']),
      currentValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_value']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed']),
    );
  }

  @override
  $HabitExceptionsTableTable createAlias(String alias) {
    return $HabitExceptionsTableTable(attachedDatabase, alias);
  }
}

class HabitExceptionsTableData extends DataClass
    implements Insertable<HabitExceptionsTableData> {
  final String id;
  final String habitSeriesId;
  final DateTime date;
  final bool isSkipped;
  final bool reminderEnabled;
  final int? targetValue;
  final int? currentValue;
  final bool? isCompleted;
  const HabitExceptionsTableData(
      {required this.id,
      required this.habitSeriesId,
      required this.date,
      required this.isSkipped,
      required this.reminderEnabled,
      this.targetValue,
      this.currentValue,
      this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_series_id'] = Variable<String>(habitSeriesId);
    map['date'] = Variable<DateTime>(date);
    map['is_skipped'] = Variable<bool>(isSkipped);
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    if (!nullToAbsent || targetValue != null) {
      map['target_value'] = Variable<int>(targetValue);
    }
    if (!nullToAbsent || currentValue != null) {
      map['current_value'] = Variable<int>(currentValue);
    }
    if (!nullToAbsent || isCompleted != null) {
      map['is_completed'] = Variable<bool>(isCompleted);
    }
    return map;
  }

  HabitExceptionsTableCompanion toCompanion(bool nullToAbsent) {
    return HabitExceptionsTableCompanion(
      id: Value(id),
      habitSeriesId: Value(habitSeriesId),
      date: Value(date),
      isSkipped: Value(isSkipped),
      reminderEnabled: Value(reminderEnabled),
      targetValue: targetValue == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue),
      currentValue: currentValue == null && nullToAbsent
          ? const Value.absent()
          : Value(currentValue),
      isCompleted: isCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isCompleted),
    );
  }

  factory HabitExceptionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitExceptionsTableData(
      id: serializer.fromJson<String>(json['id']),
      habitSeriesId: serializer.fromJson<String>(json['habitSeriesId']),
      date: serializer.fromJson<DateTime>(json['date']),
      isSkipped: serializer.fromJson<bool>(json['isSkipped']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      targetValue: serializer.fromJson<int?>(json['targetValue']),
      currentValue: serializer.fromJson<int?>(json['currentValue']),
      isCompleted: serializer.fromJson<bool?>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitSeriesId': serializer.toJson<String>(habitSeriesId),
      'date': serializer.toJson<DateTime>(date),
      'isSkipped': serializer.toJson<bool>(isSkipped),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'targetValue': serializer.toJson<int?>(targetValue),
      'currentValue': serializer.toJson<int?>(currentValue),
      'isCompleted': serializer.toJson<bool?>(isCompleted),
    };
  }

  HabitExceptionsTableData copyWith(
          {String? id,
          String? habitSeriesId,
          DateTime? date,
          bool? isSkipped,
          bool? reminderEnabled,
          Value<int?> targetValue = const Value.absent(),
          Value<int?> currentValue = const Value.absent(),
          Value<bool?> isCompleted = const Value.absent()}) =>
      HabitExceptionsTableData(
        id: id ?? this.id,
        habitSeriesId: habitSeriesId ?? this.habitSeriesId,
        date: date ?? this.date,
        isSkipped: isSkipped ?? this.isSkipped,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        targetValue: targetValue.present ? targetValue.value : this.targetValue,
        currentValue:
            currentValue.present ? currentValue.value : this.currentValue,
        isCompleted: isCompleted.present ? isCompleted.value : this.isCompleted,
      );
  HabitExceptionsTableData copyWithCompanion(
      HabitExceptionsTableCompanion data) {
    return HabitExceptionsTableData(
      id: data.id.present ? data.id.value : this.id,
      habitSeriesId: data.habitSeriesId.present
          ? data.habitSeriesId.value
          : this.habitSeriesId,
      date: data.date.present ? data.date.value : this.date,
      isSkipped: data.isSkipped.present ? data.isSkipped.value : this.isSkipped,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      targetValue:
          data.targetValue.present ? data.targetValue.value : this.targetValue,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitExceptionsTableData(')
          ..write('id: $id, ')
          ..write('habitSeriesId: $habitSeriesId, ')
          ..write('date: $date, ')
          ..write('isSkipped: $isSkipped, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentValue: $currentValue, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitSeriesId, date, isSkipped,
      reminderEnabled, targetValue, currentValue, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitExceptionsTableData &&
          other.id == this.id &&
          other.habitSeriesId == this.habitSeriesId &&
          other.date == this.date &&
          other.isSkipped == this.isSkipped &&
          other.reminderEnabled == this.reminderEnabled &&
          other.targetValue == this.targetValue &&
          other.currentValue == this.currentValue &&
          other.isCompleted == this.isCompleted);
}

class HabitExceptionsTableCompanion
    extends UpdateCompanion<HabitExceptionsTableData> {
  final Value<String> id;
  final Value<String> habitSeriesId;
  final Value<DateTime> date;
  final Value<bool> isSkipped;
  final Value<bool> reminderEnabled;
  final Value<int?> targetValue;
  final Value<int?> currentValue;
  final Value<bool?> isCompleted;
  final Value<int> rowid;
  const HabitExceptionsTableCompanion({
    this.id = const Value.absent(),
    this.habitSeriesId = const Value.absent(),
    this.date = const Value.absent(),
    this.isSkipped = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitExceptionsTableCompanion.insert({
    required String id,
    required String habitSeriesId,
    required DateTime date,
    this.isSkipped = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        habitSeriesId = Value(habitSeriesId),
        date = Value(date);
  static Insertable<HabitExceptionsTableData> custom({
    Expression<String>? id,
    Expression<String>? habitSeriesId,
    Expression<DateTime>? date,
    Expression<bool>? isSkipped,
    Expression<bool>? reminderEnabled,
    Expression<int>? targetValue,
    Expression<int>? currentValue,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitSeriesId != null) 'habit_series_id': habitSeriesId,
      if (date != null) 'date': date,
      if (isSkipped != null) 'is_skipped': isSkipped,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (targetValue != null) 'target_value': targetValue,
      if (currentValue != null) 'current_value': currentValue,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitExceptionsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? habitSeriesId,
      Value<DateTime>? date,
      Value<bool>? isSkipped,
      Value<bool>? reminderEnabled,
      Value<int?>? targetValue,
      Value<int?>? currentValue,
      Value<bool?>? isCompleted,
      Value<int>? rowid}) {
    return HabitExceptionsTableCompanion(
      id: id ?? this.id,
      habitSeriesId: habitSeriesId ?? this.habitSeriesId,
      date: date ?? this.date,
      isSkipped: isSkipped ?? this.isSkipped,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitSeriesId.present) {
      map['habit_series_id'] = Variable<String>(habitSeriesId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isSkipped.present) {
      map['is_skipped'] = Variable<bool>(isSkipped.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<int>(currentValue.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitExceptionsTableCompanion(')
          ..write('id: $id, ')
          ..write('habitSeriesId: $habitSeriesId, ')
          ..write('date: $date, ')
          ..write('isSkipped: $isSkipped, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentValue: $currentValue, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitCategoriesTableTable habitCategoriesTable =
      $HabitCategoriesTableTable(this);
  late final $HabitsTableTable habitsTable = $HabitsTableTable(this);
  late final $HabitSeriesTableTable habitSeriesTable =
      $HabitSeriesTableTable(this);
  late final $HabitExceptionsTableTable habitExceptionsTable =
      $HabitExceptionsTableTable(this);
  late final HabitDao habitDao = HabitDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final HabitSeriesDao habitSeriesDao =
      HabitSeriesDao(this as AppDatabase);
  late final HabitExceptionDao habitExceptionDao =
      HabitExceptionDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        habitCategoriesTable,
        habitsTable,
        habitSeriesTable,
        habitExceptionsTable
      ];
}

typedef $$HabitCategoriesTableTableCreateCompanionBuilder
    = HabitCategoriesTableCompanion Function({
  required String id,
  required String label,
  required String iconPath,
  Value<int> rowid,
});
typedef $$HabitCategoriesTableTableUpdateCompanionBuilder
    = HabitCategoriesTableCompanion Function({
  Value<String> id,
  Value<String> label,
  Value<String> iconPath,
  Value<int> rowid,
});

final class $$HabitCategoriesTableTableReferences extends BaseReferences<
    _$AppDatabase, $HabitCategoriesTableTable, HabitCategoriesTableData> {
  $$HabitCategoriesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitsTableTable, List<HabitsTableData>>
      _habitsTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.habitsTable,
              aliasName: $_aliasNameGenerator(
                  db.habitCategoriesTable.id, db.habitsTable.categoryId));

  $$HabitsTableTableProcessedTableManager get habitsTableRefs {
    final manager = $$HabitsTableTableTableManager($_db, $_db.habitsTable)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HabitCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCategoriesTableTable> {
  $$HabitCategoriesTableTableFilterComposer({
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

  Expression<bool> habitsTableRefs(
      Expression<bool> Function($$HabitsTableTableFilterComposer f) f) {
    final $$HabitsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitsTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableTableFilterComposer(
              $db: $db,
              $table: $db.habitsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCategoriesTableTable> {
  $$HabitCategoriesTableTableOrderingComposer({
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

class $$HabitCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCategoriesTableTable> {
  $$HabitCategoriesTableTableAnnotationComposer({
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

  Expression<T> habitsTableRefs<T extends Object>(
      Expression<T> Function($$HabitsTableTableAnnotationComposer a) f) {
    final $$HabitsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitsTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.habitsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitCategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitCategoriesTableTable,
    HabitCategoriesTableData,
    $$HabitCategoriesTableTableFilterComposer,
    $$HabitCategoriesTableTableOrderingComposer,
    $$HabitCategoriesTableTableAnnotationComposer,
    $$HabitCategoriesTableTableCreateCompanionBuilder,
    $$HabitCategoriesTableTableUpdateCompanionBuilder,
    (HabitCategoriesTableData, $$HabitCategoriesTableTableReferences),
    HabitCategoriesTableData,
    PrefetchHooks Function({bool habitsTableRefs})> {
  $$HabitCategoriesTableTableTableManager(
      _$AppDatabase db, $HabitCategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCategoriesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCategoriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> iconPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitCategoriesTableCompanion(
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
              HabitCategoriesTableCompanion.insert(
            id: id,
            label: label,
            iconPath: iconPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitCategoriesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({habitsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitsTableRefs) db.habitsTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitsTableRefs)
                    await $_getPrefetchedData<HabitCategoriesTableData,
                            $HabitCategoriesTableTable, HabitsTableData>(
                        currentTable: table,
                        referencedTable: $$HabitCategoriesTableTableReferences
                            ._habitsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HabitCategoriesTableTableReferences(db, table, p0)
                                .habitsTableRefs,
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

typedef $$HabitCategoriesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $HabitCategoriesTableTable,
        HabitCategoriesTableData,
        $$HabitCategoriesTableTableFilterComposer,
        $$HabitCategoriesTableTableOrderingComposer,
        $$HabitCategoriesTableTableAnnotationComposer,
        $$HabitCategoriesTableTableCreateCompanionBuilder,
        $$HabitCategoriesTableTableUpdateCompanionBuilder,
        (HabitCategoriesTableData, $$HabitCategoriesTableTableReferences),
        HabitCategoriesTableData,
        PrefetchHooks Function({bool habitsTableRefs})>;
typedef $$HabitsTableTableCreateCompanionBuilder = HabitsTableCompanion
    Function({
  required String id,
  required String userId,
  required String name,
  required String categoryId,
  required DateTime startDate,
  Value<String?> habitSeriesId,
  Value<bool> reminderEnabled,
  required String trackingType,
  Value<int?> targetValue,
  Value<int?> currentValue,
  Value<String?> unit,
  Value<bool?> isCompleted,
  Value<int> rowid,
});
typedef $$HabitsTableTableUpdateCompanionBuilder = HabitsTableCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String> categoryId,
  Value<DateTime> startDate,
  Value<String?> habitSeriesId,
  Value<bool> reminderEnabled,
  Value<String> trackingType,
  Value<int?> targetValue,
  Value<int?> currentValue,
  Value<String?> unit,
  Value<bool?> isCompleted,
  Value<int> rowid,
});

final class $$HabitsTableTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTableTable, HabitsTableData> {
  $$HabitsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitCategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.habitCategoriesTable.createAlias($_aliasNameGenerator(
          db.habitsTable.categoryId, db.habitCategoriesTable.id));

  $$HabitCategoriesTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager =
        $$HabitCategoriesTableTableTableManager($_db, $_db.habitCategoriesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HabitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTableTable> {
  $$HabitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitSeriesId => $composableBuilder(
      column: $table.habitSeriesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackingType => $composableBuilder(
      column: $table.trackingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentValue => $composableBuilder(
      column: $table.currentValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  $$HabitCategoriesTableTableFilterComposer get categoryId {
    final $$HabitCategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.habitCategoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitCategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.habitCategoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTableTable> {
  $$HabitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitSeriesId => $composableBuilder(
      column: $table.habitSeriesId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackingType => $composableBuilder(
      column: $table.trackingType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentValue => $composableBuilder(
      column: $table.currentValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  $$HabitCategoriesTableTableOrderingComposer get categoryId {
    final $$HabitCategoriesTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.habitCategoriesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$HabitCategoriesTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.habitCategoriesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$HabitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTableTable> {
  $$HabitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get habitSeriesId => $composableBuilder(
      column: $table.habitSeriesId, builder: (column) => column);

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<String> get trackingType => $composableBuilder(
      column: $table.trackingType, builder: (column) => column);

  GeneratedColumn<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => column);

  GeneratedColumn<int> get currentValue => $composableBuilder(
      column: $table.currentValue, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  $$HabitCategoriesTableTableAnnotationComposer get categoryId {
    final $$HabitCategoriesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.habitCategoriesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$HabitCategoriesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.habitCategoriesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$HabitsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTableTable,
    HabitsTableData,
    $$HabitsTableTableFilterComposer,
    $$HabitsTableTableOrderingComposer,
    $$HabitsTableTableAnnotationComposer,
    $$HabitsTableTableCreateCompanionBuilder,
    $$HabitsTableTableUpdateCompanionBuilder,
    (HabitsTableData, $$HabitsTableTableReferences),
    HabitsTableData,
    PrefetchHooks Function({bool categoryId})> {
  $$HabitsTableTableTableManager(_$AppDatabase db, $HabitsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<String?> habitSeriesId = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            Value<String> trackingType = const Value.absent(),
            Value<int?> targetValue = const Value.absent(),
            Value<int?> currentValue = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<bool?> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsTableCompanion(
            id: id,
            userId: userId,
            name: name,
            categoryId: categoryId,
            startDate: startDate,
            habitSeriesId: habitSeriesId,
            reminderEnabled: reminderEnabled,
            trackingType: trackingType,
            targetValue: targetValue,
            currentValue: currentValue,
            unit: unit,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            required String categoryId,
            required DateTime startDate,
            Value<String?> habitSeriesId = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            required String trackingType,
            Value<int?> targetValue = const Value.absent(),
            Value<int?> currentValue = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<bool?> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsTableCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            categoryId: categoryId,
            startDate: startDate,
            habitSeriesId: habitSeriesId,
            reminderEnabled: reminderEnabled,
            trackingType: trackingType,
            targetValue: targetValue,
            currentValue: currentValue,
            unit: unit,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitsTableTableReferences(db, table, e)
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
                        $$HabitsTableTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$HabitsTableTableReferences._categoryIdTable(db).id,
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

typedef $$HabitsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitsTableTable,
    HabitsTableData,
    $$HabitsTableTableFilterComposer,
    $$HabitsTableTableOrderingComposer,
    $$HabitsTableTableAnnotationComposer,
    $$HabitsTableTableCreateCompanionBuilder,
    $$HabitsTableTableUpdateCompanionBuilder,
    (HabitsTableData, $$HabitsTableTableReferences),
    HabitsTableData,
    PrefetchHooks Function({bool categoryId})>;
typedef $$HabitSeriesTableTableCreateCompanionBuilder
    = HabitSeriesTableCompanion Function({
  required String id,
  required String userId,
  required String habitId,
  required DateTime startDate,
  Value<DateTime?> untilDate,
  required String repeatFrequency,
  Value<int> rowid,
});
typedef $$HabitSeriesTableTableUpdateCompanionBuilder
    = HabitSeriesTableCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> habitId,
  Value<DateTime> startDate,
  Value<DateTime?> untilDate,
  Value<String> repeatFrequency,
  Value<int> rowid,
});

class $$HabitSeriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitSeriesTableTable> {
  $$HabitSeriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get untilDate => $composableBuilder(
      column: $table.untilDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repeatFrequency => $composableBuilder(
      column: $table.repeatFrequency,
      builder: (column) => ColumnFilters(column));
}

class $$HabitSeriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitSeriesTableTable> {
  $$HabitSeriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get untilDate => $composableBuilder(
      column: $table.untilDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repeatFrequency => $composableBuilder(
      column: $table.repeatFrequency,
      builder: (column) => ColumnOrderings(column));
}

class $$HabitSeriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitSeriesTableTable> {
  $$HabitSeriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get untilDate =>
      $composableBuilder(column: $table.untilDate, builder: (column) => column);

  GeneratedColumn<String> get repeatFrequency => $composableBuilder(
      column: $table.repeatFrequency, builder: (column) => column);
}

class $$HabitSeriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitSeriesTableTable,
    HabitSeriesTableData,
    $$HabitSeriesTableTableFilterComposer,
    $$HabitSeriesTableTableOrderingComposer,
    $$HabitSeriesTableTableAnnotationComposer,
    $$HabitSeriesTableTableCreateCompanionBuilder,
    $$HabitSeriesTableTableUpdateCompanionBuilder,
    (
      HabitSeriesTableData,
      BaseReferences<_$AppDatabase, $HabitSeriesTableTable,
          HabitSeriesTableData>
    ),
    HabitSeriesTableData,
    PrefetchHooks Function()> {
  $$HabitSeriesTableTableTableManager(
      _$AppDatabase db, $HabitSeriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitSeriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitSeriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitSeriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> habitId = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> untilDate = const Value.absent(),
            Value<String> repeatFrequency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitSeriesTableCompanion(
            id: id,
            userId: userId,
            habitId: habitId,
            startDate: startDate,
            untilDate: untilDate,
            repeatFrequency: repeatFrequency,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String habitId,
            required DateTime startDate,
            Value<DateTime?> untilDate = const Value.absent(),
            required String repeatFrequency,
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitSeriesTableCompanion.insert(
            id: id,
            userId: userId,
            habitId: habitId,
            startDate: startDate,
            untilDate: untilDate,
            repeatFrequency: repeatFrequency,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitSeriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitSeriesTableTable,
    HabitSeriesTableData,
    $$HabitSeriesTableTableFilterComposer,
    $$HabitSeriesTableTableOrderingComposer,
    $$HabitSeriesTableTableAnnotationComposer,
    $$HabitSeriesTableTableCreateCompanionBuilder,
    $$HabitSeriesTableTableUpdateCompanionBuilder,
    (
      HabitSeriesTableData,
      BaseReferences<_$AppDatabase, $HabitSeriesTableTable,
          HabitSeriesTableData>
    ),
    HabitSeriesTableData,
    PrefetchHooks Function()>;
typedef $$HabitExceptionsTableTableCreateCompanionBuilder
    = HabitExceptionsTableCompanion Function({
  required String id,
  required String habitSeriesId,
  required DateTime date,
  Value<bool> isSkipped,
  Value<bool> reminderEnabled,
  Value<int?> targetValue,
  Value<int?> currentValue,
  Value<bool?> isCompleted,
  Value<int> rowid,
});
typedef $$HabitExceptionsTableTableUpdateCompanionBuilder
    = HabitExceptionsTableCompanion Function({
  Value<String> id,
  Value<String> habitSeriesId,
  Value<DateTime> date,
  Value<bool> isSkipped,
  Value<bool> reminderEnabled,
  Value<int?> targetValue,
  Value<int?> currentValue,
  Value<bool?> isCompleted,
  Value<int> rowid,
});

class $$HabitExceptionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitExceptionsTableTable> {
  $$HabitExceptionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitSeriesId => $composableBuilder(
      column: $table.habitSeriesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSkipped => $composableBuilder(
      column: $table.isSkipped, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentValue => $composableBuilder(
      column: $table.currentValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));
}

class $$HabitExceptionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitExceptionsTableTable> {
  $$HabitExceptionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitSeriesId => $composableBuilder(
      column: $table.habitSeriesId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSkipped => $composableBuilder(
      column: $table.isSkipped, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentValue => $composableBuilder(
      column: $table.currentValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$HabitExceptionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitExceptionsTableTable> {
  $$HabitExceptionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitSeriesId => $composableBuilder(
      column: $table.habitSeriesId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isSkipped =>
      $composableBuilder(column: $table.isSkipped, builder: (column) => column);

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => column);

  GeneratedColumn<int> get currentValue => $composableBuilder(
      column: $table.currentValue, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);
}

class $$HabitExceptionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitExceptionsTableTable,
    HabitExceptionsTableData,
    $$HabitExceptionsTableTableFilterComposer,
    $$HabitExceptionsTableTableOrderingComposer,
    $$HabitExceptionsTableTableAnnotationComposer,
    $$HabitExceptionsTableTableCreateCompanionBuilder,
    $$HabitExceptionsTableTableUpdateCompanionBuilder,
    (
      HabitExceptionsTableData,
      BaseReferences<_$AppDatabase, $HabitExceptionsTableTable,
          HabitExceptionsTableData>
    ),
    HabitExceptionsTableData,
    PrefetchHooks Function()> {
  $$HabitExceptionsTableTableTableManager(
      _$AppDatabase db, $HabitExceptionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitExceptionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitExceptionsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitExceptionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> habitSeriesId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isSkipped = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            Value<int?> targetValue = const Value.absent(),
            Value<int?> currentValue = const Value.absent(),
            Value<bool?> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitExceptionsTableCompanion(
            id: id,
            habitSeriesId: habitSeriesId,
            date: date,
            isSkipped: isSkipped,
            reminderEnabled: reminderEnabled,
            targetValue: targetValue,
            currentValue: currentValue,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String habitSeriesId,
            required DateTime date,
            Value<bool> isSkipped = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            Value<int?> targetValue = const Value.absent(),
            Value<int?> currentValue = const Value.absent(),
            Value<bool?> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitExceptionsTableCompanion.insert(
            id: id,
            habitSeriesId: habitSeriesId,
            date: date,
            isSkipped: isSkipped,
            reminderEnabled: reminderEnabled,
            targetValue: targetValue,
            currentValue: currentValue,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitExceptionsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $HabitExceptionsTableTable,
        HabitExceptionsTableData,
        $$HabitExceptionsTableTableFilterComposer,
        $$HabitExceptionsTableTableOrderingComposer,
        $$HabitExceptionsTableTableAnnotationComposer,
        $$HabitExceptionsTableTableCreateCompanionBuilder,
        $$HabitExceptionsTableTableUpdateCompanionBuilder,
        (
          HabitExceptionsTableData,
          BaseReferences<_$AppDatabase, $HabitExceptionsTableTable,
              HabitExceptionsTableData>
        ),
        HabitExceptionsTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitCategoriesTableTableTableManager get habitCategoriesTable =>
      $$HabitCategoriesTableTableTableManager(_db, _db.habitCategoriesTable);
  $$HabitsTableTableTableManager get habitsTable =>
      $$HabitsTableTableTableManager(_db, _db.habitsTable);
  $$HabitSeriesTableTableTableManager get habitSeriesTable =>
      $$HabitSeriesTableTableTableManager(_db, _db.habitSeriesTable);
  $$HabitExceptionsTableTableTableManager get habitExceptionsTable =>
      $$HabitExceptionsTableTableTableManager(_db, _db.habitExceptionsTable);
}
