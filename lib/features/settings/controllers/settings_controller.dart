import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/app_settings.dart';
import '../../../data/domain/models/language.dart';
import '../../../data/services/analytics_service.dart';
import '../repositories/settings_repository.dart';
import '../../../data/services/user_service.dart';

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AsyncValue<AppSettings>>((ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final userService = ref.watch(userServiceProvider);
  final analyticsService = ref.watch(analyticsServiceProvider);
  return SettingsController(settingsRepo, userService, analyticsService);
});

class SettingsController extends StateNotifier<AsyncValue<AppSettings>> {
  final SettingsRepository _settingsRepo;
  final UserService _userService;
  final AnalyticsService _analyticsService;
  String? _currentUserId;

  SettingsController(
      this._settingsRepo, this._userService, this._analyticsService)
      : super(const AsyncValue.loading());

  Future<void> loadUserSettings(String userId) async {
    try {
      state = const AsyncValue.loading();
      _currentUserId = userId;

      // Track settings loading started
      _analyticsService.trackSettingsLoadingStarted(userId);

      final settings = await _settingsRepo.getUserSettings(userId);

      // Track settings loaded successfully
      _analyticsService.trackSettingsLoadedSuccessfully(
        userId,
        settings.language.languageCode,
        settings.weekStartDay.toString(),
      );

      state = AsyncValue.data(settings);
    } catch (e) {
      // Track settings loading error
      _analyticsService.trackSettingsLoadingError(
        userId,
        e.toString(),
        e.runtimeType.toString(),
      );

      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> setWeekStartDay(WeekStartDay day) async {
    _currentUserId ??= await _userService.getCurrentUserId();
    if (_currentUserId == null) {
      // Track error: null user ID
      _analyticsService.trackSettingsUpdateError(
        'week_start_day',
        'User ID is null',
      );

      state = AsyncValue.error('User ID is null', StackTrace.current);
      return;
    }

    try {
      // Get current week start day for tracking change
      final currentDay = state.value?.weekStartDay;

      // Track week start day update started
      _analyticsService.trackWeekStartDayUpdateStarted(
        _currentUserId ?? 'unknown',
        currentDay.toString(),
        day.toString(),
      );

      // Optimistic update
      final updatedSettings =
          (state.value ?? AppSettings()).rebuild((b) => b..weekStartDay = day);

      // Persist changes
      await _settingsRepo.saveUserSettings(_currentUserId!, updatedSettings);

      // Track week start day updated successfully
      _analyticsService.trackWeekStartDayUpdatedSuccessfully(
        _currentUserId ?? 'unknown',
        day.toString(),
      );

      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      // Track week start day update error
      _analyticsService.trackWeekStartDayUpdateError(
        _currentUserId ?? 'unknown',
        e.toString(),
        e.runtimeType.toString(),
      );

      // Revert on error or show error
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> setLanguage(Language language) async {
    _currentUserId ??= await _userService.getCurrentUserId();
    if (_currentUserId == null) {
      // Track error: null user ID
      _analyticsService.trackSettingsUpdateError(
        'language',
        'User ID is null',
      );

      state = AsyncValue.error('User ID is null', StackTrace.current);
      return;
    }

    try {
      // Get current language for tracking change
      final currentLanguage = state.value?.language;

      // Track language update started
      _analyticsService.trackLanguageUpdateStarted(
        _currentUserId ?? 'unknown',
        currentLanguage?.languageCode ?? 'unknown',
        language.languageCode,
        currentLanguage?.languageName ?? 'unknown',
        language.languageName,
      );

      // Optimistic update
      final updatedSettings = (state.value ?? AppSettings())
          .rebuild((b) => b..language = language.toBuilder());

      // Persist changes
      await _settingsRepo.saveUserSettings(_currentUserId!, updatedSettings);

      // Track language updated successfully
      _analyticsService.trackLanguageUpdatedSuccessfully(
        _currentUserId ?? 'unknown',
        language.languageCode,
        language.languageName,
      );

      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      // Track language update error
      _analyticsService.trackLanguageUpdateError(
        _currentUserId ?? 'unknown',
        language.languageCode,
        e.toString(),
        e.runtimeType.toString(),
      );

      // Revert on error or show error
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void clearCurrentUser() {
    final previousUserId = _currentUserId;

    // Track user settings cleared
    if (previousUserId != null) {
      _analyticsService.trackUserSettingsCleared(previousUserId);
    }

    _currentUserId = null;
    state = AsyncValue.data(AppSettings()); // Reset to defaults
  }
}
