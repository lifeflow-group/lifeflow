import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/logger.dart';
import '../../../data/controllers/apply_suggestion_controller.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_analysis_input.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../data/services/network_connectivity_service.dart';
import '../../../data/services/user_service.dart';
import '../../../data/domain/models/suggestion.dart';
import '../repositories/suggestion_repository.dart';

// Create a class to hold both suggestions and selections
class AIPicksState {
  final List<Suggestion> suggestions;
  final Set<String> selectedIds;
  final bool? hasConnectivity;

  const AIPicksState({
    required this.suggestions,
    required this.selectedIds,
    this.hasConnectivity,
  });

  bool get hasSelections => selectedIds.isNotEmpty;
  int get selectedCount => selectedIds.length;

  bool isAllSelected() {
    return suggestions.isNotEmpty &&
        suggestions.every((s) => selectedIds.contains(s.id));
  }

  AIPicksState copyWith({
    List<Suggestion>? suggestions,
    Set<String>? selectedIds,
    bool? hasConnectivity,
  }) {
    return AIPicksState(
      suggestions: suggestions ?? this.suggestions,
      selectedIds: selectedIds ?? this.selectedIds,
      hasConnectivity: hasConnectivity ?? this.hasConnectivity,
    );
  }
}

final aiPicksControllerProvider =
    AsyncNotifierProvider<AIPicksController, AIPicksState>(() {
  return AIPicksController();
});

class AIPicksController extends AsyncNotifier<AIPicksState> {
  final AppLogger _logger = AppLogger('AIPicksController');

  // Dependencies are accessed within methods via ref
  SuggestionRepository get _repo => ref.read(suggestionRepositoryProvider);
  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);
  UserService get _userService => ref.read(userServiceProvider);
  NetworkConnectivityService get _connectivityService =>
      ref.read(networkConnectivityProvider);
  ApplySuggestionController get _applySuggestionController =>
      ref.read(applySuggestionControllerProvider);

  @override
  FutureOr<AIPicksState> build() async {
    // Check connection before loading data
    final hasConnectivity = await checkConnectivity();

    if (!hasConnectivity) {
      return AIPicksState(
          suggestions: [], selectedIds: {}, hasConnectivity: false);
    }

    final suggestions = await loadSuggestions();
    return AIPicksState(
        suggestions: suggestions, selectedIds: {}, hasConnectivity: true);
  }

  // Add connection checking method
  Future<bool> checkConnectivity() async {
    try {
      final isConnected = await _connectivityService.isConnected();
      _logger.info("Internet connection available for AI Picks: $isConnected");

      if (!isConnected) {
        _analytics.trackNoInternetConnectionForAIPicks();
      }

      return isConnected;
    } catch (e) {
      _logger.error("Error checking connectivity", e);
      return false;
    }
  }

  // Method to update connection status
  Future<void> updateConnectivityStatus() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final hasConnectivity = await checkConnectivity();

    // Update only if there is a change
    if (hasConnectivity != currentState.hasConnectivity) {
      state =
          AsyncData(currentState.copyWith(hasConnectivity: hasConnectivity));
    }
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
      // Check connection before loading data
      final hasConnectivity = await checkConnectivity();
      if (!hasConnectivity) return [];

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
      final suggestions =
          await _repo.remoteSuggestion.generateAISuggestions(input);

      // Clear selections when loading new suggestions
      if (state.value != null) {
        state = AsyncData(state.value!.copyWith(
          suggestions: suggestions,
          selectedIds: {},
          hasConnectivity: true,
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
  Future<List<Habit>> applySelectedSuggestions() async {
    final currentState = state.value;
    if (currentState == null) return [];

    final selectedIds = currentState.selectedIds;
    if (selectedIds.isEmpty) return [];

    final suggestions = currentState.suggestions;
    final selectedSuggestions =
        suggestions.where((s) => selectedIds.contains(s.id)).toList();

    final appliedHabits =
        await _applySuggestionController.applySuggestions(selectedSuggestions);

    // Clear selected suggestions
    clearSelections();

    return appliedHabits;
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
          .where((ex) => ex.habitSeriesId == habit.series?.id)
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
        ..startDate = habit.date.toUtc()
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
    _analytics.trackAIPicksControllerRefreshCalled();

    state = const AsyncValue.loading();
    try {
      // Check connection when refreshing
      final hasConnectivity = await checkConnectivity();

      if (!hasConnectivity) {
        // If no connection, return state with empty list and hasConnectivity = false
        state = AsyncValue.data(AIPicksState(
          suggestions: [],
          selectedIds: {},
          hasConnectivity: false,
        ));
        return;
      }

      final suggestions = await loadSuggestions();
      state = AsyncValue.data(AIPicksState(
        suggestions: suggestions,
        selectedIds: {},
        hasConnectivity: true,
      ));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
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
