import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/remote/repositories/remote_repositories.dart';
import '../../../data/factories/default_data.dart';
import '../../../data/providers/filter_providers.dart';
import '../../../data/controllers/apply_suggestion_controller.dart';
import '../../../data/domain/models/category.dart';
import '../../../data/domain/models/habit_plan.dart';
import '../../../data/services/analytics/analytics_service.dart';

final habitPlansControllerProvider =
    AsyncNotifierProvider<HabitPlansController, List<HabitPlan>>(() {
  return HabitPlansController();
});

class HabitPlansController extends AsyncNotifier<List<HabitPlan>> {
  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);
  ApplySuggestionController get applySuggestionController =>
      ref.read(applySuggestionControllerProvider);
  RemoteRepositories get _remoteRepositories =>
      ref.read(remoteRepositoriesProvider);

  @override
  Future<List<HabitPlan>> build() async {
    // Listen for changes in selectedCategoryProvider
    ref.listen<Category?>(selectedCategoryProvider, (previous, next) {
      if (previous != next) {
        _analytics.trackHabitPlansCategoryChanged(previous?.name, next?.name);
        ref.invalidateSelf(); // Update results when category changes
      }
    });

    return loadHabitPlans();
  }

  Future<List<HabitPlan>> loadHabitPlans() async {
    _analytics.trackHabitPlansLoading();

    try {
      // Get the selected category
      final selectedCategory = ref.read(selectedCategoryProvider);

      // Pass category ID directly to API instead of filtering client-side
      final plans = await _remoteRepositories.habitPlans
          .getHabitPlans(categoryId: selectedCategory?.id);

      _analytics.trackHabitPlansLoaded(plans.length);
      return plans.isNotEmpty ? plans : getMockHabitPlans();
    } catch (e) {
      _analytics.trackHabitPlansLoadError(e.toString());
      return getMockHabitPlans();
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => loadHabitPlans());
  }

  // Methods for filtering by category
  void filterByCategory(Category category) {
    _analytics.trackHabitPlansCategoryFilterApplied(category.name);
    ref
        .read(selectedCategoryProvider.notifier)
        .updateSelectedCategory(category);
  }

  void clearCategoryFilter() {
    final currentCategory = ref.read(selectedCategoryProvider);
    _analytics.trackHabitPlansCategoryFilterCleared(currentCategory?.name);
    ref.read(selectedCategoryProvider.notifier).clearCategory();
  }

  void updateHabitPlans(List<HabitPlan> updatedPlans) {
    _analytics.trackHabitPlansUpdated(updatedPlans.length);
    state = AsyncData(updatedPlans);
  }
}
