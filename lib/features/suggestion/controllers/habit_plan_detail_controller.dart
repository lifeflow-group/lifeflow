import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/domain/models/habit.dart';
import '../../../../data/domain/models/habit_plan.dart';
import '../../../../data/domain/models/suggestion.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../data/controllers/apply_suggestion_controller.dart';

class HabitPlanDetailState {
  final HabitPlan plan;
  final Set<String> selectedIds;

  const HabitPlanDetailState({
    required this.plan,
    required this.selectedIds,
  });

  bool get hasSelections => selectedIds.isNotEmpty;
  int get selectedCount => selectedIds.length;

  bool isAllSelected() {
    return plan.suggestions.isNotEmpty &&
        plan.suggestions.every((s) => selectedIds.contains(s.id));
  }

  List<Suggestion> get selectedSuggestions {
    return plan.suggestions
        .where((suggestion) => selectedIds.contains(suggestion.id))
        .toList();
  }

  HabitPlanDetailState copyWith({
    HabitPlan? plan,
    Set<String>? selectedIds,
  }) {
    return HabitPlanDetailState(
      plan: plan ?? this.plan,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }
}

// Provides the controller via provider, with plan as a parameter
final habitPlanDetailControllerProvider = StateNotifierProvider.family<
    HabitPlanDetailController, HabitPlanDetailState, HabitPlan>(
  (ref, plan) => HabitPlanDetailController(ref, plan),
);

class HabitPlanDetailController extends StateNotifier<HabitPlanDetailState> {
  final Ref _ref;

  HabitPlanDetailController(this._ref, HabitPlan plan)
      : super(HabitPlanDetailState(plan: plan, selectedIds: {}));

  AnalyticsService get _analytics => _ref.read(analyticsServiceProvider);
  ApplySuggestionController get applySuggestionController =>
      _ref.read(applySuggestionControllerProvider);

  // Selection management
  void toggleHabitSelection(String suggestionId) {
    final selectedIds = Set<String>.from(state.selectedIds);
    if (selectedIds.contains(suggestionId)) {
      selectedIds.remove(suggestionId);
    } else {
      selectedIds.add(suggestionId);
    }
    state = state.copyWith(selectedIds: selectedIds);
  }

  void toggleAll(bool selectAll) {
    final selectedIds = selectAll
        ? state.plan.suggestions.map((s) => s.id).toSet()
        : <String>{};
    state = state.copyWith(selectedIds: selectedIds);
  }

  void clearSelections() {
    state = state.copyWith(selectedIds: {});
  }

  // Update a specific suggestion's habit in the plan
  void updateSuggestion(String suggestionId, Habit updatedHabit) {
    final updatedSuggestions = state.plan.suggestions.map((suggestion) {
      if (suggestion.id == suggestionId && suggestion.habit != null) {
        return suggestion.rebuild((b) => b..habit = updatedHabit.toBuilder());
      }
      return suggestion;
    }).toList();

    final updatedPlan =
        state.plan.rebuild((b) => b..suggestions.replace(updatedSuggestions));

    _analytics.trackHabitPlanSuggestionUpdated(
        state.plan.id, suggestionId, updatedHabit.name);

    state = state.copyWith(plan: updatedPlan);
  }

  // Apply selected suggestions
  Future<List<Habit>> applySelectedSuggestions() async {
    final selectedSuggestions = state.selectedSuggestions;

    if (selectedSuggestions.isEmpty) {
      return [];
    }

    _analytics.trackHabitPlanHabitsSelected(
      state.plan.id,
      state.plan.title,
      state.selectedCount,
      state.plan.suggestions.length,
    );

    final appliedHabits =
        await applySuggestionController.applySuggestions(selectedSuggestions);

    _analytics.trackHabitPlanHabitsApplied(
      state.plan.id,
      selectedSuggestions.length,
      appliedHabits.length,
    );

    // Clear selections after applying
    clearSelections();

    return appliedHabits;
  }
}
