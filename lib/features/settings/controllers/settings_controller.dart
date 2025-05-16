import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/app_settings.dart';
import '../repositories/settings_repository.dart';
import '../../../data/services/user_service.dart';

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AsyncValue<AppSettings>>((ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final userService = ref.watch(userServiceProvider);
  return SettingsController(settingsRepo, userService);
});

class SettingsController extends StateNotifier<AsyncValue<AppSettings>> {
  final SettingsRepository _settingsRepo;
  final UserService _userService;
  String? _currentUserId;

  SettingsController(this._settingsRepo, this._userService)
      : super(const AsyncValue.loading());

  Future<void> loadUserSettings(String userId) async {
    try {
      state = const AsyncValue.loading();
      _currentUserId = userId;

      final settings = await _settingsRepo.getUserSettings(userId);
      state = AsyncValue.data(settings);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> setWeekStartDay(WeekStartDay day) async {
    _currentUserId ??= await _userService.getCurrentUserId();
    if (_currentUserId == null) {
      state = AsyncValue.error('User ID is null', StackTrace.current);
      return;
    }

    try {
      // Optimistic update
      final updatedSettings =
          (state.value ?? AppSettings()).rebuild((b) => b..weekStartDay = day);
      // Persist changes
      await _settingsRepo.saveUserSettings(_currentUserId!, updatedSettings);
      state = AsyncValue.data(updatedSettings);
    } catch (e) {
      // Revert on error or show error
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void clearCurrentUser() {
    _currentUserId = null;
    state = AsyncValue.data(AppSettings()); // Reset to defaults
  }
}
