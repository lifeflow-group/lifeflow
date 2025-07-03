import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/logger.dart';
import '../../../data/controllers/apply_suggestion_controller.dart';
import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/habit_analysis.dart';
import '../../../data/domain/models/habit_exception.dart';
import '../../../data/domain/models/ai_suggestion_request_input.dart';
import '../../../data/domain/models/personalization_context.dart';
import '../../../data/factories/model_factories.dart';
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
  final bool submitted;
  final AISuggestionRequestInput? aiSuggestionRequestInput;

  const AIPicksState({
    required this.suggestions,
    required this.selectedIds,
    this.hasConnectivity,
    this.aiSuggestionRequestInput,
    this.submitted = false, // default
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
    AISuggestionRequestInput? aiSuggestionRequestInput,
    bool? submitted,
  }) {
    return AIPicksState(
      suggestions: suggestions ?? this.suggestions,
      selectedIds: selectedIds ?? this.selectedIds,
      hasConnectivity: hasConnectivity ?? this.hasConnectivity,
      aiSuggestionRequestInput:
          aiSuggestionRequestInput ?? this.aiSuggestionRequestInput,
      submitted: submitted ?? this.submitted,
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
    try {
      final userId = await _userService.getCurrentUserId();
      if (userId == null) {
        _analytics.trackSuggestionDataLoadNoUser();
        throw Exception("User not logged in. Please log in to continue.");
      }

      // Check connection before loading data
      final hasConnectivity = await checkConnectivity();

      final habitAnalysis = await _getHabitAnalysis(
        DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 30)),
            end: DateTime.now()),
        userId,
      );

      final aiSuggestionRequestInput =
          newAISuggestionRequestInput(habitAnalysis: habitAnalysis);

      // At this point, there's no need to load suggestions yet, just initialize the initial state
      return AIPicksState(
          suggestions: [],
          selectedIds: {},
          hasConnectivity: hasConnectivity,
          aiSuggestionRequestInput: aiSuggestionRequestInput,
          submitted: false);
    } catch (e, stack) {
      _logger.error("Error initializing AI Picks", e);
      state = AsyncValue.error(e, stack);
      rethrow;
    }
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
    try {
      final suggestions = await _repo.remoteSuggestion
          .generateAISuggestions(state.value!.aiSuggestionRequestInput!);

      _analytics.trackSuggestionDataLoaded(
          suggestions.length, suggestions.isNotEmpty, true);

      return suggestions;
    } catch (e) {
      _analytics.trackSuggestionDataLoadError(
          e.toString(), e.runtimeType.toString());
      _logger.error("Error loading AI suggestions", e);
      return [];
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

  Future<HabitAnalysis?> _getHabitAnalysis(
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

    return HabitAnalysis((b) => b
      ..startDate = range.start
      ..endDate = range.end
      ..habits.replace(habitDataList));
  }

  Future<void> refresh() async {
    _analytics.trackAIPicksControllerRefreshCalled();

    final currentState = state.value;
    if (currentState == null || currentState.aiSuggestionRequestInput == null) {
      return;
    }

    state = const AsyncValue.loading();
    try {
      // Check connection when refreshing
      final hasConnectivity = await checkConnectivity();

      if (!hasConnectivity) {
        // If no connection, return state with empty list and hasConnectivity = false
        state = AsyncValue.data(currentState.copyWith(
          suggestions: [],
          selectedIds: {},
          hasConnectivity: false,
        ));
        return;
      }

      final suggestions = await loadSuggestions();
      state = AsyncValue.data(currentState.copyWith(
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

  void invalidateSelf() {
    ref.invalidateSelf();
  }

  void setSubmitted(bool value) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncData(currentState.copyWith(submitted: value));
  }

  void updatePersonalization({
    String? goals,
    PersonalityType? personalityType,
    TimePreference? timePreference,
    GuidanceLevel? guidanceLevel,
    DataSourceType? dataSourceType,
  }) {
    final currentState = state.value;
    if (currentState == null) return;

    final builder = currentState.aiSuggestionRequestInput?.toBuilder() ??
        newAISuggestionRequestInput().toBuilder();

    // Update dataSourceType at the AISuggestionRequestInput level
    if (dataSourceType != null) builder.dataSourceType = dataSourceType;

    // Update fields in PersonalizationContext
    builder.personalizationContext.update((contextBuilder) {
      if (goals != null) contextBuilder.goals = goals;
      if (personalityType != null) {
        contextBuilder.personalityType = personalityType;
      }
      if (timePreference != null) {
        contextBuilder.timePreference = timePreference;
      }
      if (guidanceLevel != null) contextBuilder.guidanceLevel = guidanceLevel;
    });

    state = AsyncData(
        currentState.copyWith(aiSuggestionRequestInput: builder.build()));
  }
}
