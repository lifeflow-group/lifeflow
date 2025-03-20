// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metric.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PerformanceMetric> _$performanceMetricSerializer =
    new _$PerformanceMetricSerializer();

class _$PerformanceMetricSerializer
    implements StructuredSerializer<PerformanceMetric> {
  @override
  final Iterable<Type> types = const [PerformanceMetric, _$PerformanceMetric];
  @override
  final String wireName = 'PerformanceMetric';

  @override
  Iterable<Object?> serialize(Serializers serializers, PerformanceMetric object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'habitId',
      serializers.serialize(object.habitId,
          specifiedType: const FullType(String)),
      'score',
      serializers.serialize(object.score,
          specifiedType: const FullType(double)),
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(DateTime)),
      'endDate',
      serializers.serialize(object.endDate,
          specifiedType: const FullType(DateTime)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.completionRate;
    if (value != null) {
      result
        ..add('completionRate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.averageProgress;
    if (value != null) {
      result
        ..add('averageProgress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.totalProgress;
    if (value != null) {
      result
        ..add('totalProgress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  PerformanceMetric deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PerformanceMetricBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'habitId':
          result.habitId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'completionRate':
          result.completionRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'averageProgress':
          result.averageProgress = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'totalProgress':
          result.totalProgress = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PerformanceMetric extends PerformanceMetric {
  @override
  final String habitId;
  @override
  final double score;
  @override
  final double? completionRate;
  @override
  final double? averageProgress;
  @override
  final double? totalProgress;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String description;

  factory _$PerformanceMetric(
          [void Function(PerformanceMetricBuilder)? updates]) =>
      (new PerformanceMetricBuilder()..update(updates))._build();

  _$PerformanceMetric._(
      {required this.habitId,
      required this.score,
      this.completionRate,
      this.averageProgress,
      this.totalProgress,
      required this.startDate,
      required this.endDate,
      required this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        habitId, r'PerformanceMetric', 'habitId');
    BuiltValueNullFieldError.checkNotNull(score, r'PerformanceMetric', 'score');
    BuiltValueNullFieldError.checkNotNull(
        startDate, r'PerformanceMetric', 'startDate');
    BuiltValueNullFieldError.checkNotNull(
        endDate, r'PerformanceMetric', 'endDate');
    BuiltValueNullFieldError.checkNotNull(
        description, r'PerformanceMetric', 'description');
  }

  @override
  PerformanceMetric rebuild(void Function(PerformanceMetricBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerformanceMetricBuilder toBuilder() =>
      new PerformanceMetricBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerformanceMetric &&
        habitId == other.habitId &&
        score == other.score &&
        completionRate == other.completionRate &&
        averageProgress == other.averageProgress &&
        totalProgress == other.totalProgress &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, habitId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, completionRate.hashCode);
    _$hash = $jc(_$hash, averageProgress.hashCode);
    _$hash = $jc(_$hash, totalProgress.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PerformanceMetric')
          ..add('habitId', habitId)
          ..add('score', score)
          ..add('completionRate', completionRate)
          ..add('averageProgress', averageProgress)
          ..add('totalProgress', totalProgress)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('description', description))
        .toString();
  }
}

class PerformanceMetricBuilder
    implements Builder<PerformanceMetric, PerformanceMetricBuilder> {
  _$PerformanceMetric? _$v;

  String? _habitId;
  String? get habitId => _$this._habitId;
  set habitId(String? habitId) => _$this._habitId = habitId;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  double? _completionRate;
  double? get completionRate => _$this._completionRate;
  set completionRate(double? completionRate) =>
      _$this._completionRate = completionRate;

  double? _averageProgress;
  double? get averageProgress => _$this._averageProgress;
  set averageProgress(double? averageProgress) =>
      _$this._averageProgress = averageProgress;

  double? _totalProgress;
  double? get totalProgress => _$this._totalProgress;
  set totalProgress(double? totalProgress) =>
      _$this._totalProgress = totalProgress;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  PerformanceMetricBuilder();

  PerformanceMetricBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _habitId = $v.habitId;
      _score = $v.score;
      _completionRate = $v.completionRate;
      _averageProgress = $v.averageProgress;
      _totalProgress = $v.totalProgress;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PerformanceMetric other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PerformanceMetric;
  }

  @override
  void update(void Function(PerformanceMetricBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerformanceMetric build() => _build();

  _$PerformanceMetric _build() {
    final _$result = _$v ??
        new _$PerformanceMetric._(
          habitId: BuiltValueNullFieldError.checkNotNull(
              habitId, r'PerformanceMetric', 'habitId'),
          score: BuiltValueNullFieldError.checkNotNull(
              score, r'PerformanceMetric', 'score'),
          completionRate: completionRate,
          averageProgress: averageProgress,
          totalProgress: totalProgress,
          startDate: BuiltValueNullFieldError.checkNotNull(
              startDate, r'PerformanceMetric', 'startDate'),
          endDate: BuiltValueNullFieldError.checkNotNull(
              endDate, r'PerformanceMetric', 'endDate'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'PerformanceMetric', 'description'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
