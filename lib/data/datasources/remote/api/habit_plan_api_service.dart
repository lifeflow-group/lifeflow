import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import 'api_client.dart';

final habitPlanApiServiceProvider = Provider<HabitPlanApiService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return HabitPlanApiService(apiClient);
});

class HabitPlanApiService {
  final ApiClient _client;
  final logger = AppLogger('HabitPlanApiService');

  HabitPlanApiService(this._client);

  /// Get all habit plans - returns raw JSON data
  Future<List<dynamic>> getHabitPlans(
      {String? categoryId, int skip = 0, int limit = 100}) async {
    final queryParams = <String, dynamic>{
      'skip': skip,
      'limit': limit,
    };
    if (categoryId != null) {
      queryParams['category_id'] = categoryId;
    }

    final response =
        await _client.get('/habit-plans/', queryParams: queryParams);

    final List<dynamic> plansJson = response as List<dynamic>;
    logger.info('Fetched ${plansJson.length} habit plans (raw JSON)');
    return plansJson;
  }

  /// Get a specific habit plan by ID - returns raw JSON data
  Future<Map<String, dynamic>> getHabitPlan(String planId) async {
    final response = await _client.get('/habit-plans/$planId');
    logger.info('Fetched habit plan $planId (raw JSON)');
    return response as Map<String, dynamic>;
  }

  /// Get habit plans by category
  Future<List<dynamic>> getHabitPlansByCategory(String categoryId) async {
    return getHabitPlans(categoryId: categoryId);
  }
}
