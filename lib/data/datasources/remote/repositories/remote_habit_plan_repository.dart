import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../domain/models/habit_plan.dart';
import '../api/habit_plan_api_service.dart';

final remoteHabitPlanRepositoryProvider =
    Provider<RemoteHabitPlanRepository>((ref) {
  final habitPlanApiService = ref.read(habitPlanApiServiceProvider);
  return RemoteHabitPlanRepository(habitPlanApiService);
});

class RemoteHabitPlanRepository {
  final HabitPlanApiService _apiService;
  final logger = AppLogger('RemoteHabitPlanRepository');

  RemoteHabitPlanRepository(this._apiService);

  Future<List<HabitPlan>> getHabitPlans({String? categoryId}) async {
    // Get JSON data from API service
    final plansJson = await _apiService.getHabitPlans(categoryId: categoryId);

    // Convert from JSON to model
    final plans = plansJson
        .map((json) => HabitPlan.fromJson(json as Map<String, dynamic>))
        .toList();

    logger.info('Converted ${plans.length} JSON objects to HabitPlan models');
    return plans;
  }

  Future<HabitPlan> getHabitPlan(String id) async {
    // Get JSON data from API service
    final planJson = await _apiService.getHabitPlan(id);

    // Convert from JSON to model
    final plan = HabitPlan.fromJson(planJson);

    logger.info('Converted JSON to HabitPlan model: ${plan.id}');
    return plan;
  }

  Future<List<HabitPlan>> getHabitPlansByCategory(String categoryId) async {
    // Get JSON data from API service
    final plansJson = await _apiService.getHabitPlansByCategory(categoryId);

    // Convert from JSON to model
    final plans = plansJson
        .map((json) => HabitPlan.fromJson(json as Map<String, dynamic>))
        .toList();

    logger.info(
        'Converted ${plans.length} JSON objects to HabitPlan models for category $categoryId');
    return plans;
  }
}
