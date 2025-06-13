import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/core/utils/helpers.dart';

import '../../../data/controllers/habit_controller.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_analysis_input.dart';
import '../../../data/domain/models/habit_category.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/domain/models/habit_series.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../data/services/notifications/mobile_notification_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/domain/models/suggestion.dart';
import '../repositories/suggestion_repository.dart';

// Create a class to hold both suggestions and selections
class SuggestionsState {
  final List<Suggestion> suggestions;
  final Set<String> selectedIds;

  const SuggestionsState({
    required this.suggestions,
    required this.selectedIds,
  });

  bool get hasSelections => selectedIds.isNotEmpty;
  int get selectedCount => selectedIds.length;

  bool isAllSelected() {
    return suggestions.isNotEmpty &&
        suggestions.every((s) => selectedIds.contains(s.id));
  }

  SuggestionsState copyWith({
    List<Suggestion>? suggestions,
    Set<String>? selectedIds,
  }) {
    return SuggestionsState(
      suggestions: suggestions ?? this.suggestions,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }
}

final suggestionControllerProvider =
    AsyncNotifierProvider<SuggestionController, SuggestionsState>(() {
  return SuggestionController(MobileNotificationService());
});

class SuggestionController extends AsyncNotifier<SuggestionsState> {
  SuggestionController(this._notification);

  final MobileNotificationService _notification;

  // Dependencies are accessed within methods via ref
  SuggestionRepository get _repo => ref.read(suggestionRepositoryProvider);
  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);
  HabitController get _habitController => ref.read(habitControllerProvider);
  UserService get _userService => ref.read(userServiceProvider);

  @override
  FutureOr<SuggestionsState> build() async {
    final suggestions = await loadSuggestions();
    return SuggestionsState(suggestions: suggestions, selectedIds: {});
  }

  // Selection management methods
  void toggleSuggestion(String suggestionId) {
    final currentState = state.value;
    if (currentState == null) return;

    final selectedIds = Set<String>.from(currentState.selectedIds);
    if (selectedIds.contains(suggestionId)) {
      selectedIds.remove(suggestionId);
    } else {
      selectedIds.add(suggestionId);
    }

    state = AsyncData(currentState.copyWith(selectedIds: selectedIds));
  }

  void toggleAll(bool isSelected) {
    final currentState = state.value;
    if (currentState == null) return;

    final Set<String> selectedIds =
        isSelected ? currentState.suggestions.map((s) => s.id).toSet() : {};

    state = AsyncData(currentState.copyWith(selectedIds: selectedIds));
  }

  void clearSelections() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(selectedIds: {}));
  }

  bool isSuggestionSelected(String suggestionId) {
    return state.value?.selectedIds.contains(suggestionId) ?? false;
  }

  // Rest of your methods
  Future<List<Suggestion>> loadSuggestions() async {
    _analytics.trackSuggestionDataLoadingStarted();

    try {
      // Get habit analysis input
      final time = DateTime.now();
      final userId = await _userService.getCurrentUserId();
      if (userId == null) {
        _analytics.trackSuggestionDataLoadNoUser();
        return [];
      }

      final input = await _getHabitAnalysisInput(
          DateTimeRange(start: time.subtract(Duration(days: 30)), end: time),
          userId);

      if (input == null) {
        _analytics.trackSuggestionDataLoadEmptyInput();
        return [];
      }

      _analytics.trackSuggestionAnalysisInputLoaded(input.habits.length, 30);

      // Send data for analysis and generate suggestions
      final suggestions = await _repo.analyzeHabits(input);

      // Clear selections when loading new suggestions
      if (state.value != null) {
        state = AsyncData(state.value!.copyWith(
          suggestions: suggestions,
          selectedIds: {},
        ));
      }

      _analytics.trackSuggestionDataLoaded(
          suggestions.length, suggestions.isNotEmpty, true);

      return suggestions;
    } catch (e) {
      // Log errors in controller
      _analytics.trackSuggestionDataLoadError(
          e.toString(), e.runtimeType.toString());
      rethrow;
    }
  }

  // Apply selected suggestions
  Future<List<HabitData>> applySelectedSuggestions() async {
    final currentState = state.value;
    if (currentState == null) return [];

    final selectedIds = currentState.selectedIds;
    if (selectedIds.isEmpty) {
      _analytics.trackApplySuggestionsEmptySelection();
      return [];
    }

    _analytics.trackApplySuggestionsStarted(selectedIds.length);

    final suggestions = currentState.suggestions;
    final selectedSuggestions =
        suggestions.where((s) => selectedIds.contains(s.id)).toList();

    final appliedHabits = <HabitData>[];

    // Get current user ID
    final userId =
        await _userService.getCurrentUserId(); // Use injected service
    if (userId == null) return [];

    for (final suggestion in selectedSuggestions) {
      final habitData = suggestion.habitData;
      if (habitData != null) {
        // Track individual suggestion application attempt
        _analytics.trackApplySuggestionAttempt(
            suggestion.id, habitData.name, habitData.category.name);

        // Check if a similar habit already exists
        final existingHabit = await _repo.habit.getHabit(habitData.id);

        if (existingHabit != null) {
          // Track updating existing habit
          _analytics.trackApplySuggestionUpdatingExisting(
              suggestion.id, existingHabit.id, existingHabit.name);

          // Update existing habit with suggestion data
          final updatedHabit =
              await _updateExistingHabit(existingHabit, habitData);
          if (updatedHabit != null) {
            appliedHabits.add(habitData);
          }
        } else {
          // Create new habit from suggestion
          final newHabit = await _createHabit(habitData, userId);
          if (newHabit != null) {
            appliedHabits.add(habitData);
          }
        }
      }
    }

    // Clear selected suggestions
    clearSelections();

    // Log final results
    _analytics.trackApplySuggestionsCompleted(
        selectedSuggestions.length, appliedHabits.length);

    return appliedHabits;
  }

  Future<Habit?> _createHabit(HabitData habitData, String? userId) async {
    if (userId == null) return null;
    HabitSeries? habitSeries;
    return await _repo.transaction(() async {
      // 1. Convert to Habit model
      final habit = habitDataToHabit(habitData, userId);

      // 2. Build optional series if repeat frequency is provided
      if (habitData.repeatFrequency != null) {
        habitSeries = _buildHabitSeriesFromData(habit, habitData);

        if (habitSeries != null) {
          await _repo.habitSeries.createHabitSeries(habitSeries!);

          // Update the habit with the series ID
          final updatedHabit =
              habit.rebuild((b) => b..habitSeriesId = habitSeries!.id);

          // 3. Create habit
          await _repo.habit.createHabit(updatedHabit);
          return updatedHabit;
        }
      }

      // 3. Create habit
      await _repo.habit.createHabit(habit);
      return habit;
    }).then((habit) async {
      // 4. Handle reminder if enabled
      if (habit.reminderEnabled == true) {
        await _notification.scheduleRecurringReminders(habit, habitSeries);
      }

      return habit;
    });
  }

  /// Updates an existing habit with data from a suggestion
  Future<Habit?> _updateExistingHabit(
      Habit existingHabit, HabitData habitData) async {
    final oldSeries =
        await _repo.habitSeries.getHabitSeries(existingHabit.habitSeriesId);
    Habit? newHabit = habitDataToHabit(habitData, existingHabit.userId);

    final newSeries = _buildHabitSeriesFromData(existingHabit, habitData);
    newHabit = newHabit.rebuild((b) => b..habitSeriesId = newSeries?.id);

    // If there is no old series → simply update or create a new series
    if (oldSeries == null) {
      final success = await _repo.transaction(() async {
        if (newSeries != null) {
          await _repo.habitSeries.createHabitSeries(newSeries);
        }
        await _repo.habit.updateHabit(newHabit!);
        return true;
      });

      if (success) {
        await _notification.cancelNotification(generateNotificationId(
            existingHabit.startDate,
            habitId: existingHabit.id));

        final needReschedule = newHabit.reminderEnabled == true &&
            (newHabit != existingHabit || newSeries != null);

        if (needReschedule) {
          await _notification.scheduleRecurringReminders(newHabit, newSeries,
              excludedDatesUtc: await _habitController
                  .getExcludedDatesForSeries(newSeries?.id));
        }
      }

      return newHabit;
    }

    // If there are changes → ask the user for the edit scope
    if (newHabit != existingHabit) {
      // ActionScope.thisAndFollowing
      newHabit = await _habitController.handleThisAndFollowing(
          oldSeries, newHabit, newSeries, DateTime.now());
    }

    return newHabit;
  }

  HabitSeries? _buildHabitSeriesFromData(Habit habit, HabitData habitData) {
    // Only build series if a repeat frequency is provided
    if (habitData.repeatFrequency == null) return null;

    return HabitSeries((b) => b
      ..id = generateNewId('series')
      ..habitId = habit.id
      ..userId = habit.userId
      ..repeatFrequency = habitData.repeatFrequency
      ..startDate = habitData.startDate
      ..untilDate = habitData.untilDate);
  }

  Future<HabitAnalysisInput?> _getHabitAnalysisInput(
      DateTimeRange range, String userId) async {
    // Fetch data from HabitsService
    final habits = await _repo.habit.getHabitsDateRange(range, userId);
    final habitSeries =
        await _repo.habitSeries.getHabitSeriesDateRange(range, userId);
    final seriesIds = habitSeries.map((s) => s.id).toList();
    final habitExceptions = await _repo.habitException
        .getHabitExceptionsDateRange(range, seriesIds);

    // Convert data into HabitData
    final habitDataList = await Future.wait(habits.map((habit) async {
      final series = habitSeries.firstWhereOrNull((s) => s.habitId == habit.id);
      final exceptions = habitExceptions
          .where((ex) => ex.habitSeriesId == habit.habitSeriesId)
          .toList();

      return HabitData((p0) => p0
        ..id = habit.id
        ..name = habit.name
        ..category = habit.category.toBuilder()
        ..trackingType = habit.trackingType
        ..reminderEnabled = habit.reminderEnabled
        ..targetValue = habit.targetValue
        ..unit = habit.unit
        ..repeatFrequency = series?.repeatFrequency
        ..startDate = habit.startDate.toUtc()
        ..untilDate = series?.untilDate?.toUtc()
        ..exceptions = ListBuilder<HabitException>(exceptions));
    }).toList());

    return HabitAnalysisInput((b) => b
      ..userId = userId
      ..startDate = range.start
      ..endDate = range.end
      ..habits.replace(habitDataList));
  }

  Future<void> refresh() async {
    _analytics.trackSuggestionControllerRefreshCalled();

    // We want to invalidate the entire state,
    // this will run build() again which reloads the suggestions
    // and clears the selections
    ref.invalidateSelf();
  }

  // Update the updateSuggestions method to preserve selections
  void updateSuggestions(List<Suggestion> updatedSuggestions) {
    final currentState = state.value;
    if (currentState == null) return;

    final previousCount = currentState.suggestions.length;

    _analytics.trackSuggestionsListUpdated(
        previousCount, updatedSuggestions.length);

    state = AsyncData(currentState.copyWith(
      suggestions: updatedSuggestions,
      // Keep the same selections
    ));
  }
}

// Add this to your SuggestionController class
Future<List<Suggestion>> loadMockSuggestions() async {
  // Simulate loading delay
  await Future.delayed(const Duration(seconds: 1));

  // Sample category data
  final healthCategory = HabitCategory((b) => b
    ..id = "category_1"
    ..name = "Health"
    ..colorHex = "#4CAF50"
    ..iconPath = "assets/icons/health.png");

  final workCategory = HabitCategory((b) => b
    ..id = "category_2"
    ..name = "Work"
    ..colorHex = "#2196F3"
    ..iconPath = "assets/icons/work.png");

  final hobbyCategory = HabitCategory((b) => b
    ..id = "category_3"
    ..name = "Hobby"
    ..colorHex = "#9C27B0"
    ..iconPath = "assets/icons/hobby.png");

  final educationCategory = HabitCategory((b) => b
    ..id = "category_4"
    ..name = "Education"
    ..colorHex = "#FFC107"
    ..iconPath = "assets/icons/education.png");

  // Generate fake suggestions
  return [
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Morning Meditation"
      ..description =
          "Starting your day with a 10-minute meditation has been shown to reduce stress and improve focus. Based on your sleep pattern, this would be most effective right after waking up."
      ..habitData = HabitData((h) => h
        ..id = generateNewId('habit')
        ..name = "Morning Meditation"
        ..category = hobbyCategory.toBuilder()
        ..trackingType = TrackingType.complete
        ..targetValue = 0
        ..unit = ""
        ..reminderEnabled = true
        ..repeatFrequency = RepeatFrequency.daily
        ..startDate = DateTime.now()
        ..exceptions = ListBuilder<HabitException>([])).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Water Intake Tracking"
      ..description =
          "Your completion rate for drinking water is inconsistent. Consider tracking your daily water intake to maintain proper hydration throughout the day."
      ..habitData = HabitData((h) => h
        ..id = generateNewId('habit')
        ..name = "Drink Water"
        ..category = healthCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 8
        ..unit = "glasses"
        ..reminderEnabled = true
        ..repeatFrequency = RepeatFrequency.daily
        ..startDate = DateTime.now()
        ..exceptions = ListBuilder<HabitException>([])).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Deep Work Sessions"
      ..description =
          "Based on your productivity patterns, scheduling 90-minute deep work sessions in the morning could improve your work output significantly."
      ..habitData = HabitData((h) => h
        ..id = generateNewId('habit')
        ..name = "Deep Work Session"
        ..category = workCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 90
        ..unit = "minutes"
        ..reminderEnabled = true
        ..repeatFrequency = RepeatFrequency.daily
        ..startDate = DateTime.now().add(const Duration(days: 1))
        ..exceptions = ListBuilder<HabitException>([])).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Weekly Learning Goal"
      ..description =
          "Setting aside time each week for learning could help you achieve your personal development goals. Try dedicating 3 hours per week to a specific skill."
      ..habitData = HabitData((h) => h
        ..id = generateNewId('habit')
        ..name = "Learning Time"
        ..category = educationCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 180
        ..unit = "minutes"
        ..reminderEnabled = false
        ..repeatFrequency = RepeatFrequency.weekly
        ..startDate = DateTime.now()
        ..exceptions = ListBuilder<HabitException>([])).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Evening Reflection"
      ..description =
          "Taking time to reflect on your day can improve self-awareness and help process emotions. Consider adding a 5-minute evening reflection to your routine."
      ..habitData = HabitData((h) => h
        ..id = generateNewId('habit')
        ..name = "Evening Reflection"
        ..category = hobbyCategory.toBuilder()
        ..trackingType = TrackingType.complete
        ..targetValue = 0
        ..unit = ""
        ..reminderEnabled = true
        ..repeatFrequency = RepeatFrequency.daily
        ..startDate = DateTime.now()
        ..exceptions = ListBuilder<HabitException>([])).toBuilder()),
  ];
}
