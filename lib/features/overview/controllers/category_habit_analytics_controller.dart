import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../data/services/user_service.dart';
import '../../../features/settings/controllers/settings_controller.dart';
import '../presentation/screens/category_habit_analytics_screen.dart';
import '../presentation/widgets/ranked_item_list.dart';
import '../repositories/overview_repository.dart';

class CategoryHabitAnalyticsState {
  final DateTime selectedMonth;
  final List<Habit> habits;
  final CategoryDetailFilterType currentFilter;
  final bool isLoading;
  final String? errorMessage;

  const CategoryHabitAnalyticsState({
    required this.selectedMonth,
    required this.habits,
    this.currentFilter = CategoryDetailFilterType.all,
    this.isLoading = false,
    this.errorMessage,
  });

  CategoryHabitAnalyticsState copyWith({
    DateTime? selectedMonth,
    List<Habit>? habits,
    CategoryDetailFilterType? currentFilter,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CategoryHabitAnalyticsState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      habits: habits ?? this.habits,
      currentFilter: currentFilter ?? this.currentFilter,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final categoryHabitAnalyticsControllerProvider =
    StateNotifierProvider.autoDispose.family<
        CategoryHabitAnalyticsController, // StateNotifier type
        CategoryHabitAnalyticsState, // State type
        ({HabitCategory category, DateTime initialMonth}) // Parameter type
        >((ref, params) {
  final repository = ref.watch(overviewRepositoryProvider);
  final userService = ref.watch(userServiceProvider);
  final analyticsService = ref.watch(analyticsServiceProvider);

  return CategoryHabitAnalyticsController(
    repository,
    userService,
    analyticsService,
    ref,
    params.category,
    params.initialMonth,
  );
});

class CategoryHabitAnalyticsController
    extends StateNotifier<CategoryHabitAnalyticsState> {
  final OverviewRepository _repository;
  final HabitCategory _category;
  final UserService _userService;
  final AnalyticsService _analyticsService;
  final Ref _ref;
  final DateTime _initialMonth;

  CategoryHabitAnalyticsController(
    this._repository,
    this._userService,
    this._analyticsService,
    this._ref,
    this._category,
    this._initialMonth,
  ) : super(
          CategoryHabitAnalyticsState(
            selectedMonth: _initialMonth,
            habits: [],
            isLoading: true,
          ),
        ) {
    // Load data when controller is created
    loadHabitsForMonth(_initialMonth);
  }

  Future<void> loadHabitsForMonth(DateTime month) async {
    // Set loading state
    state = state.copyWith(isLoading: true, errorMessage: null);

    final settingsState = _ref.read(settingsControllerProvider);
    final formattedMonth =
        formatDateWithUserLanguage(settingsState, month, 'yyyy-MM');

    // Track loading started
    _analyticsService.trackCategoryHabitsLoadingStarted(
        _category.name, _category.id, formattedMonth);

    try {
      final userId = await _userService.getCurrentUserId();

      if (userId == null) {
        // Track error - no user logged in
        _analyticsService.trackCategoryHabitsLoadingError(_category.name,
            _category.id, formattedMonth, 'No user logged in', 'NoUserError');

        state = state.copyWith(
          habits: [],
          isLoading: false,
          errorMessage: "No user logged in",
        );
        return;
      }

      // Get habits for the selected month and category
      final categoryHabits = await _repository.habit
          .getHabitsForMonthAndCategory(month, _category.id, userId);

      // Apply current filter
      categoryHabits.sort((a, b) => a.startDate.compareTo(b.startDate));

      // Calculate completion rate for analytics
      double completionRate = _calculateCompletionRate(categoryHabits);

      // Track loading success
      _analyticsService.trackCategoryHabitsLoadedSuccessfully(_category.name,
          _category.id, formattedMonth, categoryHabits.length, completionRate);

      // Update state with new data
      state = state.copyWith(
        selectedMonth: month,
        habits: categoryHabits,
        isLoading: false,
      );
    } catch (e) {
      // Track loading error
      _analyticsService.trackCategoryHabitsLoadingError(_category.name,
          _category.id, formattedMonth, e.toString(), e.runtimeType.toString());

      state = state.copyWith(
        isLoading: false,
        errorMessage: "Error loading habits: $e",
      );
    }
  }

  void changeFilter(CategoryDetailFilterType filter) {
    if (filter == state.currentFilter) return;

    final settingsState = _ref.read(settingsControllerProvider);
    final formattedMonth = formatDateWithUserLanguage(
        settingsState, state.selectedMonth, 'yyyy-MM');

    // Track filter change
    _analyticsService.trackCategoryAnalyticsFilterChanged(
        _category.name,
        _category.id,
        _getFilterName(filter),
        _getFilterName(state.currentFilter),
        formattedMonth,
        state.habits.length);

    // Just update the filter type, don't change the habit list
    state = state.copyWith(currentFilter: filter);
  }

  // Helper method to get filter name for analytics
  String _getFilterName(CategoryDetailFilterType filter) {
    switch (filter) {
      case CategoryDetailFilterType.all:
        return 'all';
      case CategoryDetailFilterType.mostFrequent:
        return 'most_frequent';
      case CategoryDetailFilterType.topPerformed:
        return 'top_performed';
    }
  }

  // Track back navigation
  void trackBackNavigation() {
    final settingsState = _ref.read(settingsControllerProvider);
    final formattedMonth = formatDateWithUserLanguage(
        settingsState, state.selectedMonth, 'yyyy-MM');

    _analyticsService.trackCategoryAnalyticsBackPressed(_category.name,
        _category.id, formattedMonth, _getFilterName(state.currentFilter));
  }

  // Track month picker opened
  void trackMonthPickerOpened() {
    final settingsState = _ref.read(settingsControllerProvider);
    final formattedMonth = formatDateWithUserLanguage(
        settingsState, state.selectedMonth, 'yyyy-MM');

    _analyticsService.trackCategoryAnalyticsMonthPickerOpened(
        formattedMonth, _category.name);
  }

  // Track month selection
  void trackMonthSelected(DateTime selectedMonth) {
    final settingsState = _ref.read(settingsControllerProvider);
    final previousMonth = formatDateWithUserLanguage(
        settingsState, state.selectedMonth, 'yyyy-MM');
    final newMonth =
        formatDateWithUserLanguage(settingsState, selectedMonth, 'yyyy-MM');

    _analyticsService.trackCategoryAnalyticsMonthSelected(
        previousMonth, newMonth, _category.name);
  }

  // Track month picker dismissed
  void trackMonthPickerDismissed() {
    final settingsState = _ref.read(settingsControllerProvider);
    final formattedMonth = formatDateWithUserLanguage(
        settingsState, state.selectedMonth, 'yyyy-MM');

    _analyticsService.trackCategoryAnalyticsMonthPickerDismissed(
        formattedMonth, _category.name);
  }

  // Track reload action
  void trackReload() {
    final settingsState = _ref.read(settingsControllerProvider);
    _analyticsService.trackCategoryAnalyticsReload(
      _category.name,
      _category.id,
      formatDateWithUserLanguage(settingsState, state.selectedMonth, 'yyyy-MM'),
      _getFilterName(state.currentFilter),
    );
  }

  // Method to update selected month
  void changeMonth(DateTime newMonth) {
    if (newMonth.year == state.selectedMonth.year &&
        newMonth.month == state.selectedMonth.month) {
      return;
    }

    loadHabitsForMonth(newMonth.toLocal());
  }

  // Helper methods for stats
  int get totalHabits => state.habits.length;

  double get completionRate => _calculateCompletionRate(state.habits);

  double _calculateCompletionRate(List<Habit> habits) {
    if (habits.isEmpty) return 0;

    final completedCount =
        habits.where((habit) => habit.isCompleted ?? false).length;

    return (completedCount / habits.length) * 100;
  }

  int get completeHabits =>
      state.habits.where((habit) => habit.isCompleted ?? false).length;

  // Updated mostFrequentList getter
  List<RankedItemData> get mostFrequentList {
    if (state.habits.isEmpty) return [];

    // Group habits by name AND habitSeriesId
    final Map<String, List<Habit>> habitsByGroup = {};
    for (var habit in state.habits) {
      // Create a composite key from name and habitSeriesId
      final groupKey = '${habit.name}_${habit.habitSeriesId}';

      if (!habitsByGroup.containsKey(groupKey)) {
        habitsByGroup[groupKey] = [];
      }
      habitsByGroup[groupKey]!.add(habit);
    }

    // Sort by frequency
    final List<MapEntry<String, List<Habit>>> sortedEntries =
        habitsByGroup.entries.toList()
          ..sort((a, b) => b.value.length.compareTo(a.value.length));

    // Create RankedItemData objects
    List<RankedItemData> result = [];
    for (int i = 0; i < sortedEntries.length; i++) {
      final entry = sortedEntries[i];
      final habitList = entry.value;

      // Use the first habit's name and icon - all habits in this group have same name and series
      final habitName = habitList.first.name;
      final iconPath = habitList.first.category.iconPath;
      final count = habitList.length;

      result.add(RankedItemData(
        rank: i + 1,
        iconPath: iconPath,
        habitName: habitName,
        value: '$count',
      ));
    }

    return result;
  }

  // Updated topPerformedList getter
  List<RankedItemData> get topPerformedList {
    if (state.habits.isEmpty) return [];

    // Group habits by name AND habitSeriesId
    final Map<String, List<Habit>> habitsByGroup = {};
    for (var habit in state.habits) {
      // Create a composite key from name and habitSeriesId
      final groupKey = '${habit.name}_${habit.habitSeriesId}';

      if (!habitsByGroup.containsKey(groupKey)) {
        habitsByGroup[groupKey] = [];
      }
      habitsByGroup[groupKey]!.add(habit);
    }

    // Calculate completion rate for each habit group
    final List<MapEntry<String, (double, Habit)>> completionRates = [];

    habitsByGroup.forEach((groupKey, habits) {
      final totalHabits = habits.length;
      final completedCount = habits.where((h) => h.isCompleted ?? false).length;
      final completionRate =
          totalHabits > 0 ? (completedCount / totalHabits) * 100 : 0.0;

      // Store the completion rate and a reference habit from the group
      completionRates.add(MapEntry(groupKey, (completionRate, habits.first)));
    });

    // Sort by completion rate
    completionRates.sort((a, b) => b.value.$1.compareTo(a.value.$1));

    // Create RankedItemData objects
    List<RankedItemData> result = [];
    for (int i = 0; i < completionRates.length; i++) {
      final entry = completionRates[i];
      final completionRate = entry.value.$1;
      final habit = entry.value.$2; // Reference habit from the group

      result.add(RankedItemData(
        rank: i + 1,
        iconPath: habit.category.iconPath,
        habitName: habit.name,
        value: '${completionRate.toInt()}%',
      ));
    }

    return result;
  }
}
