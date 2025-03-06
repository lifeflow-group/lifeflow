import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'performance_metric.g.dart';

abstract class PerformanceMetric
    implements Built<PerformanceMetric, PerformanceMetricBuilder> {
  String get habitId;

  double get score;

  double? get completionRate;

  double? get averageProgress;

  double? get totalProgress;

  DateTime get startDate;

  DateTime get endDate;

  String get description;

  PerformanceMetric._();
  factory PerformanceMetric([void Function(PerformanceMetricBuilder) updates]) =
      _$PerformanceMetric;

  factory PerformanceMetric.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(PerformanceMetric.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(PerformanceMetric.serializer, this)
          as Map<String, dynamic>;

  static Serializer<PerformanceMetric> get serializer =>
      _$performanceMetricSerializer;
}

PerformanceMetric newPerformanceMetric({
  required String habitId,
  double score = 0.0,
  double? completionRate,
  double? averageProgress,
  double? totalProgress,
  required DateTime startDate,
  required DateTime endDate,
}) {
  return PerformanceMetric((b) => b
    ..habitId = habitId
    ..score = score
    ..completionRate = completionRate
    ..averageProgress = averageProgress
    ..totalProgress = totalProgress
    ..startDate = startDate.toUtc()
    ..endDate = endDate.toUtc()
    ..description =
        "Habit performance (ID: $habitId) from ${startDate.toIso8601String()} to ${endDate.toIso8601String()}: ${score.toStringAsFixed(1)}%");
}
