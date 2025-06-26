import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'analytics_service_backend.dart';
import 'firebase_analytics_service_backend.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final backend = ref.watch(analyticsServiceBackendProvider);
  return AnalyticsService(backend);
});

class AnalyticsService {
  final AnalyticsServiceBackend _backend;

  AnalyticsService(this._backend);

  // Core methods - delegate to backend
  Future<void> logEvent(String name, Map<String, Object>? parameters) {
    return _backend.logEvent(name, parameters);
  }

  Future<void> logScreenView(String screenName) {
    return _backend.logScreenView(screenName);
  }

  Future<void> setUserId(String? userId) {
    return _backend.setUserId(userId);
  }

  Future<void> setUserProperty(String name, String? value) {
    return _backend.setUserProperty(name, value);
  }

  // Language Selection Events (new)
  Future<void> trackLanguageOptionSelected(String languageCode,
      String languageName, String previousCode, String previousName) async {
    await logEvent('language_option_selected', {
      'language_code': languageCode,
      'language_name': languageName,
      'previous_language_code': previousCode,
      'previous_language_name': previousName
    });
  }

  Future<void> trackLanguageOptionReselected(
      String languageCode, String languageName) async {
    await logEvent('language_option_reselected',
        {'language_code': languageCode, 'language_name': languageName});
  }

  Future<void> trackLanguageSelectionInitialStateLoaded(
      String languageCode, String languageName, int supportedCount) async {
    await logEvent('language_selection_initial_state_loaded', {
      'language_code': languageCode,
      'language_name': languageName,
      'supported_language_count': supportedCount
    });
  }

  Future<void> trackLanguageSelectionDefaultStateUsed(
      String languageCode, String languageName) async {
    await logEvent('language_selection_default_state_used',
        {'language_code': languageCode, 'language_name': languageName});
  }

  Future<void> trackLanguageSaved(
      String languageCode, String languageName) async {
    await logEvent('language_selection_saved', {
      'selected_language': languageCode,
      'selected_language_name': languageName
    });
  }

  Future<void> trackLanguageSelectionCanceled(
      String languageCode, String languageName) async {
    await logEvent('language_selection_canceled', {
      'selected_language': languageCode,
      'selected_language_name': languageName
    });
  }

  Future<void> trackLanguageOptionsLoaded(
      int languageCount, String currentLanguageCode) async {
    await logEvent('language_options_loaded', {
      'language_count': languageCount,
      'current_language': currentLanguageCode
    });
  }

  Future<void> trackSupportedLanguagesUpdated(
      int languageCount, String languages) async {
    await logEvent('supported_languages_updated',
        {'language_count': languageCount, 'languages': languages});
  }

  // Habit Detail Category Events
  Future<void> trackCategorySelectorOpened(String? currentCategory) async {
    await logEvent('category_selector_opened', {
      'from_screen': 'habit_detail',
      'current_category': currentCategory ?? 'none'
    });
  }

  Future<void> trackCategorySelected(String categoryName) async {
    await logEvent('category_selected',
        {'category': categoryName, 'from_screen': 'habit_detail'});
  }

  Future<void> trackCategoryCleared(String? previousCategory) async {
    await logEvent('category_cleared', {
      'from_screen': 'habit_detail',
      'previous_category': previousCategory ?? 'none'
    });
  }

  // Habit Detail Date/Time Events
  Future<void> trackDatePickerOpened(DateTime currentDate) async {
    await logEvent('date_picker_opened', {
      'from_screen': 'habit_detail',
      'current_date': currentDate.toString().split(' ')[0]
    });
  }

  Future<void> trackDateSelected(DateTime pickedDate) async {
    await logEvent('date_selected', {
      'from_screen': 'habit_detail',
      'selected_date': pickedDate.toString().split(' ')[0],
      'days_from_today': pickedDate.difference(DateTime.now()).inDays
    });
  }

  Future<void> trackTimePickerOpened(String currentTime) async {
    await logEvent('time_picker_opened',
        {'from_screen': 'habit_detail', 'current_time': currentTime});
  }

  Future<void> trackTimeSelected(String selectedTime) async {
    await logEvent('time_picker_dismissed',
        {'from_screen': 'habit_detail', 'selected_time': selectedTime});
  }

  // Habit Detail Repeat Frequency Events
  Future<void> trackRepeatFrequencyOpened(String? currentFrequency) async {
    await logEvent('repeat_frequency_selector_opened', {
      'from_screen': 'habit_detail',
      'current_frequency': currentFrequency ?? 'none'
    });
  }

  Future<void> trackRepeatFrequencySelected(String frequency) async {
    await logEvent('repeat_frequency_selected',
        {'from_screen': 'habit_detail', 'frequency': frequency});
  }

  Future<void> trackRepeatFrequencyCleared() async {
    await logEvent('repeat_frequency_cleared', {'from_screen': 'habit_detail'});
  }

  Future<void> trackRepeatFrequencySheetDismissed() async {
    await logEvent(
        'repeat_frequency_sheet_dismissed', {'from_screen': 'habit_detail'});
  }

  Future<void> trackRepeatFrequencyOptionSelected(String frequency) async {
    await logEvent('repeat_frequency_option_selected',
        {'frequency': frequency, 'from_screen': 'habit_detail'});
  }

  Future<void> trackRepeatFrequencyNoneSelected() async {
    await logEvent(
        'repeat_frequency_none_selected', {'from_screen': 'habit_detail'});
  }

  // Habit Detail Tracking Type Events
  Future<void> trackTrackingTypeChanged(String type) async {
    await logEvent(
        'tracking_type_changed', {'type': type, 'from_screen': 'habit_detail'});
  }

  // Habit Detail Progress Goal Events
  Future<void> trackProgressGoalEditRequested(
      int currentValue, String currentUnit) async {
    await logEvent('progress_goal_edit_requested',
        {'current_value': currentValue, 'current_unit': currentUnit});
  }

  Future<void> trackProgressGoalDialogCanceled() async {
    await logEvent(
        'progress_goal_dialog_canceled', {'from_screen': 'habit_detail'});
  }

  Future<void> trackProgressGoalSet(int targetValue, String unitValue) async {
    await logEvent('progress_goal_set', {
      'target_value': targetValue,
      'unit': unitValue,
      'from_screen': 'habit_detail'
    });
  }

  // Habit Detail Reminder Events
  Future<void> trackReminderToggled(bool enabled) async {
    await logEvent('reminder_toggled',
        {'enabled': enabled, 'from_screen': 'habit_detail'});
  }

  Future<void> trackHabitCreated(String habitId, String habitName) async {
    await logEvent(
        'habit_created', {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackHabitUpdated(String habitId, String habitName) async {
    await logEvent(
        'habit_updated', {'habit_id': habitId, 'habit_name': habitName});
  }

  // Habit View Screen Events
  Future<void> trackHabitViewBackPressed(
      String habitId, String habitName) async {
    await logEvent('habit_view_back_pressed',
        {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackProgressUpdateInitiated(String habitId, String habitName,
      int currentValue, int targetValue) async {
    await logEvent('progress_update_initiated', {
      'habit_id': habitId,
      'habit_name': habitName,
      'current_value': currentValue,
      'target_value': targetValue
    });
  }

  Future<void> trackHabitCompletionToggled(
      String habitId, String habitName, bool isCompleted) async {
    await logEvent('habit_completion_toggled_from_view', {
      'habit_id': habitId,
      'habit_name': habitName,
      'new_state': !isCompleted ? 'completed' : 'incomplete'
    });
  }

  Future<void> trackHabitCompletionUpdated(
      String habitId, String habitName, bool isCompleted) async {
    await logEvent('habit_completion_updated_from_view', {
      'habit_id': habitId,
      'habit_name': habitName,
      'is_completed': !isCompleted
    });
  }

  Future<void> trackProgressAddInitiated(String habitId, String habitName,
      int currentValue, int targetValue) async {
    await logEvent('progress_add_initiated_from_view', {
      'habit_id': habitId,
      'habit_name': habitName,
      'current_value': currentValue,
      'target_value': targetValue
    });
  }

  Future<void> trackProgressUpdated(
      String habitId, String habitName, int newValue, int targetValue) async {
    await logEvent('progress_updated_from_view', {
      'habit_id': habitId,
      'habit_name': habitName,
      'new_value': newValue,
      'target_value': targetValue
    });
  }

  Future<void> trackHabitDeleteInitiated(
      String habitId, String habitName) async {
    await logEvent('habit_delete_initiated_from_view',
        {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackHabitDeleted(String habitId, String habitName) async {
    await logEvent('habit_deleted_from_view',
        {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackHabitEditCompleted(String habitId, String habitName) async {
    await logEvent(
        'habit_edit_completed', {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackHabitEditCanceled(String habitId, String habitName) async {
    await logEvent(
        'habit_edit_canceled', {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackProgressUpdateDialogDismissed(
      String habitId, String habitName) async {
    await logEvent('progress_update_dialog_dismissed',
        {'habit_id': habitId, 'habit_name': habitName});
  }

  Future<void> trackProgressValueManuallySet(String habitId, String habitName,
      int oldValue, int newValue, int targetValue) async {
    await logEvent('progress_value_manually_set', {
      'habit_id': habitId,
      'habit_name': habitName,
      'old_value': oldValue,
      'new_value': newValue,
      'target_value': targetValue
    });
  }

  // Category Bottom Sheet Events
  Future<void> trackCategorySheetOpened(String? currentCategory) async {
    await logEvent('category_sheet_opened',
        {'current_category': currentCategory ?? 'none'});
  }

  Future<void> trackCategorySheetDismissedWithoutSelection(
      String? previousCategory) async {
    await logEvent('category_sheet_dismissed_without_selection',
        {'previous_category': previousCategory ?? 'none'});
  }

  Future<void> trackCategoryClearedFromSheet(String? previousCategory) async {
    await logEvent('category_cleared_from_sheet',
        {'previous_category': previousCategory ?? 'none'});
  }

  Future<void> trackCategorySelectedFromSheet(
      String category, String? previousCategory, bool changed) async {
    await logEvent('category_selected_from_sheet', {
      'category': category,
      'previous_category': previousCategory ?? 'none',
      'changed': changed ? 'yes' : 'no'
    });
  }

  Future<void> trackCategorySheetClosedViaXButton(bool hadSelection) async {
    await logEvent('category_sheet_closed_via_x_button',
        {'had_selection': hadSelection ? 'yes' : 'no'});
  }

  Future<void> trackCategoryTappedInSheet(
      String category, bool wasSelected) async {
    await logEvent('category_tapped_in_sheet',
        {'category': category, 'was_selected': wasSelected ? 'yes' : 'no'});
  }

  Future<void> trackCategorySheetCanceledViaButton(bool hadSelection) async {
    await logEvent('category_sheet_canceled_via_button',
        {'had_selection': hadSelection ? 'yes' : 'no'});
  }

  Future<void> trackCategorySheetConfirmed(
      String? selection, bool changed) async {
    await logEvent('category_sheet_confirmed', {
      'selection': selection ?? 'cleared',
      'changed': changed ? 'yes' : 'no'
    });
  }

  // Home Screen Events
  Future<void> trackHomeDateChanged(
      DateTime previousDate, DateTime newDate, int daysDifference) async {
    await logEvent('home_date_changed', {
      'previous_date':
          '${previousDate.year}-${previousDate.month}-${previousDate.day}',
      'new_date': '${newDate.year}-${newDate.month}-${newDate.day}',
      'days_difference': daysDifference
    });
  }

  Future<void> trackHomeCategoryChanged(
      String? previousCategory, String? newCategory) async {
    await logEvent('home_category_changed', {
      'previous_category': previousCategory ?? 'none',
      'new_category': newCategory ?? 'none'
    });
  }

  Future<void> trackHomeHabitsFetching(
      DateTime date, String? categoryFilter) async {
    await logEvent('home_habits_fetching', {
      'date': '${date.year}-${date.month}-${date.day}',
      'category_filter': categoryFilter ?? 'all'
    });
  }

  Future<void> trackHomeHabitsFetched(DateTime date, String? categoryFilter,
      int habitCount, int totalHabits, int completedHabits) async {
    await logEvent('home_habits_fetched', {
      'date': '${date.year}-${date.month}-${date.day}',
      'category_filter': categoryFilter ?? 'all',
      'habit_count': habitCount,
      'total_habits': totalHabits,
      'completed_habits': completedHabits
    });
  }

  Future<void> trackHomeHabitsFetchError(DateTime date, String? categoryFilter,
      String errorType, String errorMessage) async {
    await logEvent('home_habits_fetch_error', {
      'date': '${date.year}-${date.month}-${date.day}',
      'category_filter': categoryFilter ?? 'all',
      'error_type': errorType,
      'error_message': errorMessage
    });
  }

  Future<void> trackHomeNoUserLoggedIn(DateTime date) async {
    await logEvent('home_habits_fetch_error', {
      'error_type': 'no_user_logged_in',
      'date': '${date.year}-${date.month}-${date.day}'
    });
  }

  Future<void> trackHomeCategoryFilterApplied(String category) async {
    await logEvent('category_filter_applied', {'category': category});
  }

  Future<void> trackHomeCategoryFilterCleared(String? previousCategory) async {
    await logEvent('category_filter_cleared',
        {'previous_category': previousCategory ?? 'none'});
  }

  Future<void> trackHomeCategoryFilterOpened(String? currentCategory) async {
    await logEvent('category_filter_opened',
        {'current_category': currentCategory ?? 'none'});
  }

  Future<void> trackHomeHabitViewed(String habitId, String habitName,
      String category, String trackingType) async {
    await logEvent('habit_viewed', {
      'habit_id': habitId,
      'habit_name': habitName,
      'category': category,
      'tracking_type': trackingType
    });
  }

  Future<void> trackHomeHabitDeleteAttempt(
      String habitId, String habitName, String category) async {
    await logEvent('habit_delete_attempt',
        {'habit_id': habitId, 'habit_name': habitName, 'category': category});
  }

  Future<void> trackHomeHabitCreated() async {
    await logEvent('habit_created', {'source': 'home_screen'});
  }

  Future<void> trackHomeEmptyStateAllHabitsClicked() async {
    await logEvent('filter_cleared', {'section': 'home_screen'});
  }

  // DateSelector Events
  Future<void> trackWeekNavigation(String direction) async {
    await logEvent('week_navigation', {'direction': direction});
  }

  Future<void> trackCalendarPickerOpened(String fromDate) async {
    await logEvent('calendar_picker_opened', {'from_date': fromDate});
  }

  Future<void> trackCalendarDateSelected(
      String fromDate, String toDate, int daysDifference) async {
    await logEvent('calendar_date_selected', {
      'from_date': fromDate,
      'to_date': toDate,
      'days_difference': daysDifference
    });
  }

  Future<void> trackCalendarPickerDismissed(String fromDate) async {
    await logEvent('calendar_picker_dismissed', {'from_date': fromDate});
  }

  Future<void> trackTodayButtonClicked(
      String fromDate, int daysDifference) async {
    await logEvent('today_button_clicked',
        {'from_date': fromDate, 'days_difference': daysDifference});
  }

  Future<void> trackWeekChanged(
      int weekOffset, String weekStart, String weekEnd) async {
    await logEvent('week_changed', {
      'week_offset': weekOffset,
      'week_start': weekStart,
      'week_end': weekEnd
    });
  }

  Future<void> trackDaySelected(
      String fromDate, String toDate, String dayOfWeek, bool isToday) async {
    await logEvent('day_selected', {
      'from_date': fromDate,
      'to_date': toDate,
      'day_of_week': dayOfWeek,
      'is_today': isToday
    });
  }

  Future<void> trackWeekJump(
      int fromPage, int toPage, int weekDifference, String targetDate) async {
    await logEvent('week_jump', {
      'from_page': fromPage,
      'to_page': toPage,
      'week_difference': weekDifference,
      'target_date': targetDate
    });
  }

  // HabitItem Events
  Future<void> trackHabitDetailsOpened(String habitId, String habitName,
      String category, String trackingType) async {
    await logEvent('habit_details_opened', {
      'habit_id': habitId,
      'habit_name': habitName,
      'habit_category': category,
      'tracking_type': trackingType
    });
  }

  Future<void> trackHabitCompletionRecorded(
      String habitId, String habitName, bool isCompleted) async {
    await logEvent('habit_completion_recorded', {
      'habit_id': habitId,
      'habit_name': habitName,
      'is_completed': isCompleted
    });
  }

  Future<void> trackHabitProgressInitiated(String habitId, String habitName,
      dynamic currentValue, dynamic targetValue) async {
    await logEvent('habit_progress_initiated', {
      'habit_id': habitId,
      'habit_name': habitName,
      'current_value': currentValue?.toString() ?? 'null',
      'target_value': targetValue?.toString() ?? 'null'
    });
  }

  Future<void> trackHabitProgressRecorded(String habitId, String habitName,
      int newValue, dynamic targetValue) async {
    await logEvent('habit_progress_recorded', {
      'habit_id': habitId,
      'habit_name': habitName,
      'new_value': newValue,
      'target_value': targetValue?.toString() ?? 'null'
    });
  }

  // Login Events
  Future<void> trackPasswordVisibilityToggled(bool isVisible) async {
    await logEvent('password_visibility_toggled', {
      'is_visible': isVisible.toString(),
    });
  }

  Future<void> trackLoginAttempt(String method) async {
    await logEvent('login_attempt', {'method': method});
  }

  Future<void> trackLoginSuccess(String method, String userId) async {
    await logEvent('login_success', {'method': method, 'user_id': userId});
  }

  Future<void> trackLoginError(
      String method, String errorType, String errorMessage) async {
    await logEvent('login_error', {
      'method': method,
      'error_type': errorType,
      'error_message': errorMessage
    });
  }

  Future<void> trackResetPasswordRequested() async {
    await logEvent('reset_password_requested', {});
  }

  Future<void> trackSignUpClicked() async {
    await logEvent('sign_up_clicked', {});
  }

  Future<void> trackSocialLoginClicked(String provider) async {
    await logEvent('social_login_clicked', {'provider': provider});
  }

  // Main Screen Tab Navigation Events
  Future<void> trackTabReselected(String tabName) async {
    await logEvent('tab_reselected', {'tab': tabName});
  }

  Future<void> trackTabChanged(
      String fromTab, String toTab, String method) async {
    await logEvent('tab_changed',
        {'from_tab': fromTab, 'to_tab': toTab, 'method': method});

    // Also log the screen view for the new tab
    await logScreenView(toTab);
  }

  // Overview Events
  Future<void> trackMonthChanged(
      String fromMonth, String toMonth, int monthsDifference) async {
    await logEvent('month_changed', {
      'from_month': fromMonth,
      'to_month': toMonth,
      'months_difference': monthsDifference
    });
  }

  Future<void> trackOverviewStatsNoUser(String month) async {
    await logEvent('overview_stats_no_user', {'month': month});
  }

  Future<void> trackOverviewStatsLoaded(String month, int totalHabits,
      int completedHabits, int completionRate) async {
    await logEvent('overview_stats_loaded', {
      'month': month,
      'total_habits': totalHabits,
      'completed_habits': completedHabits,
      'completion_rate': completionRate
    });
  }

  Future<void> trackChartDataLoaded(
      String month, int totalCategories, int totalHabits) async {
    await logEvent('chart_data_loaded', {
      'month': month,
      'total_categories': totalCategories,
      'total_habits': totalHabits
    });
  }

  Future<void> trackChartEmptyData(String month) async {
    await logEvent('chart_empty_data', {'month': month});
  }

  Future<void> trackOverviewError(String errorMessage, String month) async {
    await logEvent(
        'overview_error', {'error_message': errorMessage, 'month': month});
  }

  Future<void> trackOverviewNextMonth(String fromMonth, String toMonth) async {
    await logEvent(
        'overview_next_month', {'from_month': fromMonth, 'to_month': toMonth});
  }

  Future<void> trackOverviewPreviousMonth(
      String fromMonth, String toMonth) async {
    await logEvent('overview_previous_month',
        {'from_month': fromMonth, 'to_month': toMonth});
  }

  Future<void> trackOverviewMonthPickerOpened(String currentMonth) async {
    await logEvent(
        'overview_month_picker_opened', {'current_month': currentMonth});
  }

  Future<void> trackOverviewMonthSelected(
      String fromMonth, String toMonth, int monthsDifference) async {
    await logEvent('overview_month_selected', {
      'from_month': fromMonth,
      'to_month': toMonth,
      'months_difference': monthsDifference
    });
  }

  Future<void> trackOverviewMonthPickerDismissed(String currentMonth) async {
    await logEvent(
        'overview_month_picker_dismissed', {'current_month': currentMonth});
  }

  Future<void> trackChartSectionTapped(
      String categoryName, double percentage, int sectionIndex) async {
    await logEvent('chart_section_tapped', {
      'category': categoryName,
      'percentage': percentage.toStringAsFixed(1),
      'section_index': sectionIndex,
    });
  }

  Future<void> trackNavigateToCategoryDetail(
      String categoryName, String month, bool fromChart) async {
    await logEvent('chart_navigate_to_category_detail', {
      'category': categoryName,
      'month': month,
      'from_chart': fromChart.toString()
    });
  }

  Future<void> trackReturnFromCategoryDetail(
      String categoryName, String month) async {
    await logEvent('returned_from_category_detail',
        {'category': categoryName, 'month': month});
  }

  // Category Habit Analytics Events
  Future<void> trackCategoryHabitsLoadingStarted(
      String categoryName, String categoryId, String month) async {
    await logEvent('category_habits_loading_started', {
      'category': categoryName,
      'category_id': categoryId,
      'month': month,
    });
  }

  Future<void> trackCategoryHabitsLoadedSuccessfully(
      String categoryName,
      String categoryId,
      String month,
      int habitCount,
      double completionRate) async {
    await logEvent('category_habits_loaded_successfully', {
      'category': categoryName,
      'category_id': categoryId,
      'month': month,
      'habit_count': habitCount,
      'completion_rate': completionRate.round(),
    });
  }

  Future<void> trackCategoryHabitsLoadingError(String categoryName,
      String categoryId, String month, String error, String errorType) async {
    await logEvent('category_habits_loading_error', {
      'category': categoryName,
      'category_id': categoryId,
      'month': month,
      'error': error,
      'error_type': errorType
    });
  }

  Future<void> trackCategoryAnalyticsFilterChanged(
      String categoryName,
      String categoryId,
      String filter,
      String previousFilter,
      String month,
      int habitCount) async {
    await logEvent('category_analytics_filter_changed', {
      'category': categoryName,
      'category_id': categoryId,
      'filter': filter,
      'previous_filter': previousFilter,
      'month': month,
      'habit_count': habitCount,
    });
  }

  Future<void> trackCategoryAnalyticsBackPressed(String categoryName,
      String categoryId, String month, String currentFilter) async {
    await logEvent('category_analytics_back_pressed', {
      'category': categoryName,
      'category_id': categoryId,
      'month': month,
      'current_filter': currentFilter,
    });
  }

  Future<void> trackCategoryAnalyticsMonthPickerOpened(
      String currentMonth, String categoryName) async {
    await logEvent('category_analytics_month_picker_opened', {
      'current_month': currentMonth,
      'category': categoryName,
    });
  }

  Future<void> trackCategoryAnalyticsMonthSelected(
      String previousMonth, String selectedMonth, String categoryName) async {
    await logEvent('category_analytics_month_selected', {
      'previous_month': previousMonth,
      'selected_month': selectedMonth,
      'category': categoryName,
    });
  }

  Future<void> trackCategoryAnalyticsMonthPickerDismissed(
      String currentMonth, String categoryName) async {
    await logEvent('category_analytics_month_picker_dismissed', {
      'current_month': currentMonth,
      'category': categoryName,
    });
  }

  Future<void> trackCategoryAnalyticsReload(String categoryName,
      String categoryId, String month, String filter) async {
    await logEvent('category_analytics_reload', {
      'category': categoryName,
      'category_id': categoryId,
      'month': month,
      'filter': filter,
    });
  }

  // MonthPicker Events
  Future<void> trackMonthPickerDialogOpened(
      String initialDate, String firstDate, String lastDate) async {
    await logEvent('month_picker_dialog_opened', {
      'initial_date': initialDate,
      'first_date': firstDate,
      'last_date': lastDate
    });
  }

  Future<void> trackMonthPickerPreviousYear(int fromYear, int toYear) async {
    await logEvent('month_picker_previous_year',
        {'from_year': fromYear, 'to_year': toYear});
  }

  Future<void> trackMonthPickerNextYear(int fromYear, int toYear) async {
    await logEvent(
        'month_picker_next_year', {'from_year': fromYear, 'to_year': toYear});
  }

  Future<void> trackMonthPickerMonthSelected(
      String previousMonth, String selectedMonth) async {
    await logEvent('month_picker_month_selected',
        {'previous_month': previousMonth, 'selected_month': selectedMonth});
  }

  Future<void> trackMonthPickerCancelled(
      String selectedDate, String initialDate) async {
    await logEvent('month_picker_cancelled',
        {'selected_date': selectedDate, 'initial_date': initialDate});
  }

  Future<void> trackMonthPickerConfirmed(
      String selectedDate, String initialDate, bool changed) async {
    await logEvent('month_picker_confirmed', {
      'selected_date': selectedDate,
      'initial_date': initialDate,
      'changed': changed ? 'yes' : 'no'
    });
  }

  // Settings Events
  Future<void> trackSettingsLoadingStarted(String userId) async {
    await logEvent('settings_loading_started', {'user_id': userId});
  }

  Future<void> trackSettingsLoadedSuccessfully(
      String userId, String language, String weekStartDay) async {
    await logEvent('settings_loaded_successfully', {
      'user_id': userId,
      'language': language,
      'week_start_day': weekStartDay
    });
  }

  Future<void> trackSettingsLoadingError(
      String userId, String error, String errorType) async {
    await logEvent('settings_loading_error',
        {'user_id': userId, 'error': error, 'error_type': errorType});
  }

  Future<void> trackSettingsUpdateError(
      String settingType, String error) async {
    await logEvent(
        'settings_update_error', {'setting_type': settingType, 'error': error});
  }

  // Week Start Day Events
  Future<void> trackWeekStartDayUpdateStarted(
      String userId, String from, String to) async {
    await logEvent('week_start_day_update_started',
        {'user_id': userId, 'from': from, 'to': to});
  }

  Future<void> trackWeekStartDayUpdatedSuccessfully(
      String userId, String newValue) async {
    await logEvent('week_start_day_updated_successfully',
        {'user_id': userId, 'new_value': newValue});
  }

  Future<void> trackWeekStartDayUpdateError(
      String userId, String error, String errorType) async {
    await logEvent('week_start_day_update_error',
        {'user_id': userId, 'error': error, 'error_type': errorType});
  }

  // Language Events
  Future<void> trackLanguageUpdateStarted(String userId, String fromLanguage,
      String toLanguage, String fromName, String toName) async {
    await logEvent('language_update_started', {
      'user_id': userId,
      'from_language': fromLanguage,
      'to_language': toLanguage,
      'from_name': fromName,
      'to_name': toName
    });
  }

  Future<void> trackLanguageUpdatedSuccessfully(
      String userId, String languageCode, String languageName) async {
    await logEvent('language_updated_successfully', {
      'user_id': userId,
      'language_code': languageCode,
      'language_name': languageName
    });
  }

  Future<void> trackLanguageUpdateError(String userId, String languageCode,
      String error, String errorType) async {
    await logEvent('language_update_error', {
      'user_id': userId,
      'language_code': languageCode,
      'error': error,
      'error_type': errorType
    });
  }

  // User Settings Events
  Future<void> trackUserSettingsCleared(String userId) async {
    await logEvent('user_settings_cleared', {'user_id': userId});
  }

  // Settings Screen Events
  Future<void> trackWeekStartSettingTapped(String currentValue) async {
    await logEvent(
        'week_start_setting_tapped', {'current_value': currentValue});
  }

  Future<void> trackWeekStartSelectionCanceled(String currentValue) async {
    await logEvent(
        'week_start_selection_canceled', {'current_value': currentValue});
  }

  Future<void> trackLanguageSettingTapped(
      String currentLanguageCode, String currentLanguageName) async {
    await logEvent('language_setting_tapped', {
      'current_language': currentLanguageCode,
      'current_language_name': currentLanguageName
    });
  }

  Future<void> trackTermsOfUseTapped() async {
    await logEvent('terms_of_use_tapped', {});
  }

  Future<void> trackProfileSignUpOrLoginTapped() async {
    await logEvent('profile_signup_or_login_tapped', {});
  }

  Future<void> trackLogoutButtonTapped(String userId) async {
    await logEvent('logout_button_tapped', {'user_id': userId});
  }

  Future<void> trackDeleteAccountTapped(String userId) async {
    await logEvent('delete_account_tapped', {'user_id': userId});
  }

  // Terms of Use Events
  Future<void> trackTermsOfUseAlreadyLoaded(String language) async {
    await logEvent('terms_of_use_already_loaded', {'language': language});
  }

  Future<void> trackTermsOfUseLoadingStarted(String language) async {
    await logEvent('terms_of_use_loading_started', {'language': language});
  }

  Future<void> trackTermsOfUseLoadedSuccessfully(
      String language, int contentLength, int paragraphs) async {
    await logEvent('terms_of_use_loaded_successfully', {
      'language': language,
      'content_length': contentLength,
      'paragraphs': paragraphs
    });
  }

  Future<void> trackTermsOfUseLoadingError(
      String language, String error, String errorType) async {
    await logEvent('terms_of_use_loading_error',
        {'language': language, 'error': error, 'error_type': errorType});
  }

  Future<void> trackTermsOfUseLinkTapped(String url, bool isExternal) async {
    await logEvent('terms_of_use_link_tapped',
        {'url': url, 'is_external': isExternal ? 'yes' : 'no'});
  }

  Future<void> trackTermsOfUseExited() async {
    await logEvent('terms_of_use_exited', {});
  }

  Future<void> trackTermsOfUseScrollMilestone(int percentage) async {
    await logEvent(
        'terms_of_use_scroll_milestone', {'milestone': '$percentage%'});
  }

  // App Initialization Events
  Future<void> trackAppInitializationStarted() async {
    await logEvent('app_initialization_started', {});
  }

  Future<void> trackUserAuthStateChecked(bool isLoggedIn) async {
    await logEvent(
        'user_auth_state_checked', {'is_logged_in': isLoggedIn ? 'yes' : 'no'});
  }

  Future<void> trackNotificationPayloadChecked(bool hasPayload) async {
    await logEvent('notification_payload_checked',
        {'has_payload': hasPayload ? 'yes' : 'no'});
  }

  Future<void> trackUserSettingsLoadingStarted(String userId) async {
    await logEvent('user_settings_loading_started', {'user_id': userId});
  }

  Future<void> trackUserSettingsLoaded(String userId) async {
    await logEvent('user_settings_loaded', {'user_id': userId});
  }

  Future<void> trackAppInitializationCompleted(int durationMs) async {
    await logEvent('app_initialization_completed', {
      'duration_ms': durationMs,
    });
  }

  Future<void> trackInitialNavigation(
      String destination, bool isLoggedIn, bool fromNotification) async {
    await logEvent('initial_navigation', {
      'destination': destination,
      'is_logged_in': isLoggedIn ? 'yes' : 'no',
      'from_notification': fromNotification ? 'yes' : 'no'
    });
  }

  // Suggestion Data Events
  Future<void> trackSuggestionDataLoadingStarted() async {
    await logEvent('suggestion_data_loading_started', {});
  }

  Future<void> trackSuggestionDataLoadNoUser() async {
    await logEvent('suggestion_data_load_no_user', {});
  }

  Future<void> trackSuggestionDataLoadEmptyInput() async {
    await logEvent('suggestion_data_load_empty_input', {});
  }

  Future<void> trackSuggestionAnalysisInputLoaded(
      int habitCount, int daysAnalyzed) async {
    await logEvent('suggestion_analysis_input_loaded',
        {'habit_count': habitCount, 'days_analyzed': daysAnalyzed});
  }

  Future<void> trackSuggestionDataLoaded(
      int suggestionCount, bool hasSuggestions, bool analysisSuccess) async {
    await logEvent('suggestion_data_loaded', {
      'suggestion_count': suggestionCount,
      'has_suggestions': hasSuggestions ? 'yes' : 'no',
      'analysis_success': analysisSuccess ? 'yes' : 'no'
    });
  }

  Future<void> trackSuggestionDataLoadError(
      String error, String errorType) async {
    await logEvent('suggestion_data_load_error',
        {'error': error, 'error_type': errorType});
  }

  Future<void> trackAIPicksControllerRefreshCalled() async {
    await logEvent('suggestion_controller_refresh_called', {});
  }

  // Suggestion UI Events
  Future<void> trackSuggestionRefreshButtonTapped() async {
    await logEvent('suggestion_refresh_button_tapped', {});
  }

  Future<void> trackSuggestionRetryButtonTapped() async {
    await logEvent('suggestion_retry_button_tapped', {});
  }

  Future<void> trackSuggestionCardTapped(
      int suggestionId, String title, String type) async {
    await logEvent('suggestion_card_tapped',
        {'suggestion_id': suggestionId, 'title': title, 'type': type});
  }

  Future<void> trackSuggestionCardDismissed(
      int suggestionId, String title, String type) async {
    await logEvent('suggestion_card_dismissed',
        {'suggestion_id': suggestionId, 'title': title, 'type': type});
  }

  Future<void> trackSuggestionCardActionTaken(
      int suggestionId, String title, String type, String action) async {
    await logEvent('suggestion_card_action_taken', {
      'suggestion_id': suggestionId,
      'title': title,
      'type': type,
      'action': action
    });
  }

  // Habit Action - Delete Events
  Future<void> trackHabitDeleteUIAction(String habitId, String habitName,
      String category, String trackingType) async {
    await logEvent('habit_delete_ui_action', {
      'habit_id': habitId,
      'habit_name': habitName,
      'category': category,
      'tracking_type': trackingType,
    });
  }

  Future<void> trackHabitDeleteConfirmDialog(
      String habitId, String habitType) async {
    await logEvent('habit_delete_confirm_dialog',
        {'habit_id': habitId, 'habit_type': habitType});
  }

  Future<void> trackHabitDeleteScopeDialog(
      String habitId, String seriesId) async {
    await logEvent('habit_delete_scope_dialog',
        {'habit_id': habitId, 'series_id': seriesId});
  }

  Future<void> trackHabitDeleteCanceled(String habitId, String stage) async {
    await logEvent(
        'habit_delete_canceled', {'habit_id': habitId, 'stage': stage});
  }

  Future<void> trackHabitDeleteScopeSelected(
      String habitId, String seriesId, String scope) async {
    await logEvent('habit_delete_scope_selected',
        {'habit_id': habitId, 'series_id': seriesId, 'scope': scope});
  }

  Future<void> trackHabitDeleteResult(
      String habitId, bool success, bool hasSeries) async {
    await logEvent('habit_delete_result', {
      'habit_id': habitId,
      'success': success.toString(),
      'has_series': hasSeries.toString()
    });
  }

  // Habit Action - Completion Events
  Future<void> trackHabitCompletionToggleAction(String habitId,
      String habitName, String currentState, String date) async {
    await logEvent('habit_completion_toggle_action', {
      'habit_id': habitId,
      'habit_name': habitName,
      'current_state': currentState,
      'date': date
    });
  }

  Future<void> trackHabitCompletionInvalidDate(
      String habitId, String date, String reason) async {
    await logEvent('habit_completion_invalid_date',
        {'habit_id': habitId, 'date': date, 'reason': reason});
  }

  Future<void> trackHabitCompletionToggleSuccess(
      String habitId, String habitName, String newState, String date) async {
    await logEvent('habit_completion_toggle_success', {
      'habit_id': habitId,
      'habit_name': habitName,
      'new_state': newState,
      'date': date
    });
  }

  Future<void> trackHabitCompletionToggleError(
      String habitId, String habitName, String error) async {
    await logEvent('habit_completion_toggle_error',
        {'habit_id': habitId, 'habit_name': habitName, 'error': error});
  }

  // Habit Action - Progress Events
  Future<void> trackHabitProgressRecordAction(String habitId, String habitName,
      String currentValue, String targetValue) async {
    await logEvent('habit_progress_record_action', {
      'habit_id': habitId,
      'habit_name': habitName,
      'current_value': currentValue,
      'target_value': targetValue,
    });
  }

  Future<void> trackHabitProgressInvalidDate(
      String habitId, String date, String reason) async {
    await logEvent('habit_progress_invalid_date',
        {'habit_id': habitId, 'date': date, 'reason': reason});
  }

  Future<void> trackHabitProgressDialogOpened(
      String habitId, String habitName, String currentValue) async {
    await logEvent('habit_progress_dialog_opened', {
      'habit_id': habitId,
      'habit_name': habitName,
      'current_value': currentValue,
    });
  }

  Future<void> trackHabitProgressDialogCanceled(
      String habitId, String habitName) async {
    await logEvent('habit_progress_dialog_canceled', {
      'habit_id': habitId,
      'habit_name': habitName,
    });
  }

  Future<void> trackHabitProgressValueEntered(
      String habitId, String habitName, int amountAdded) async {
    await logEvent('habit_progress_value_entered', {
      'habit_id': habitId,
      'habit_name': habitName,
      'amount_added': amountAdded,
    });
  }

  Future<void> trackHabitProgressRecordSuccess(
      String habitId,
      String habitName,
      String oldValue,
      String newValue,
      String targetValue,
      bool completed) async {
    await logEvent('habit_progress_record_success', {
      'habit_id': habitId,
      'habit_name': habitName,
      'old_value': oldValue,
      'new_value': newValue,
      'target_value': targetValue,
      'completed': completed.toString()
    });
  }

  Future<void> trackHabitProgressRecordError(
      String habitId, String habitName, String error) async {
    await logEvent('habit_progress_record_error',
        {'habit_id': habitId, 'habit_name': habitName, 'error': error});
  }

  // Screen Tracking Events
  Future<void> trackScreenViewed(String screenName, String routeName,
      String previousRoute, Map<String, Object> additionalParams) async {
    final Map<String, Object> eventParams = {
      'screen_name': screenName,
      'route_name': routeName,
      'previous_route': previousRoute,
      ...additionalParams,
    };

    await logEvent('screen_viewed', eventParams);
  }

  Future<void> trackHabitViewScreenOpened(String habitId, String source) async {
    await logEvent(
        'habit_view_screen_opened', {'habit_id': habitId, 'source': source});
  }

  Future<void> trackWebDatabaseCompatibilityIssue(String implementation,
      List<String> missingFeatures, String userAgent) async {
    await logEvent('web_database_compatibility_issue', {
      'implementation': implementation,
      'missing_features': missingFeatures.join(', '),
      'user_agent': userAgent
    });
  }

  /// ===== Suggestion Feature Analytics Events =====

  // Suggestion Screen Events
  Future<void> trackSuggestionsSelectedCount(int selectedCount) async {
    await logEvent('suggestions_apply_clicked', {
      'selected_count': selectedCount,
    });
  }

  Future<void> trackSuggestionsApplied(
      int selectedCount, int appliedCount) async {
    await logEvent('suggestions_applied', {
      'selected_count': selectedCount,
      'applied_count': appliedCount,
      'success_rate':
          appliedCount == 0 ? 0 : (appliedCount / selectedCount * 100).round(),
    });
  }

  Future<void> trackNavigateToAppliedSummary(int habitCount) async {
    await logEvent('navigate_to_applied_summary', {
      'habit_count': habitCount,
    });
  }

  Future<void> trackReturnFromSummaryScreen() async {
    await logEvent('return_from_applied_summary', {});
  }

  Future<void> trackSuggestionsApplyEmptyResult(int selectedCount) async {
    await logEvent('suggestions_apply_empty_result', {
      'selected_count': selectedCount,
    });
  }

  // Suggestion Card Events
  Future<void> trackSuggestionHabitEditStarted(
      String suggestionId, String habitName, String categoryName) async {
    await logEvent('suggestion_habit_edit_started', {
      'suggestion_id': suggestionId,
      'habit_name': habitName,
      'category': categoryName,
    });
  }

  Future<void> trackSuggestionHabitEditCancelled(
      String suggestionId, String habitName) async {
    await logEvent('suggestion_habit_edit_cancelled', {
      'suggestion_id': suggestionId,
      'habit_name': habitName,
    });
  }

  Future<void> trackSuggestionHabitEditInvalidResult(
      String suggestionId, String resultType) async {
    await logEvent('suggestion_habit_edit_invalid_result', {
      'suggestion_id': suggestionId,
      'result_type': resultType,
    });
  }

  Future<void> trackSuggestionHabitEditCompleted(String suggestionId,
      String habitName, String categoryName, bool wasModified) async {
    await logEvent('suggestion_habit_edit_completed', {
      'suggestion_id': suggestionId,
      'habit_name': habitName,
      'category': categoryName,
      'was_modified': wasModified,
    });
  }

  Future<void> trackSuggestionUpdatedInList(
      String suggestionId, String habitName) async {
    await logEvent('suggestion_updated_in_list', {
      'suggestion_id': suggestionId,
      'habit_name': habitName,
    });
  }

  Future<void> trackSuggestionHabitTapFailed(
      String suggestionId, String reason) async {
    await logEvent('suggestion_habit_tap_failed', {
      'suggestion_id': suggestionId,
      'reason': reason,
    });
  }

  Future<void> trackApplySuggestionsProcessing(
      int foundSuggestions, int withHabitData) async {
    await logEvent('apply_suggestions_processing', {
      'found_suggestions': foundSuggestions,
      'with_habit_data': withHabitData,
    });
  }

  Future<void> trackApplySuggestionsNoUser() async {
    await logEvent('apply_suggestions_no_user', {});
  }

  Future<void> trackApplySuggestionCreatingNew(
      String suggestionId, String habitName) async {
    await logEvent('apply_suggestion_creating_new', {
      'suggestion_id': suggestionId,
      'habit_name': habitName,
    });
  }

  Future<void> trackApplySuggestionCreationFailed(
      String suggestionId, String habitName) async {
    await logEvent('apply_suggestion_creation_failed', {
      'suggestion_id': suggestionId,
      'habit_name': habitName,
    });
  }

  Future<void> trackApplySuggestionUpdateFailed(
      String suggestionId, String habitId) async {
    await logEvent('apply_suggestion_update_failed', {
      'suggestion_id': suggestionId,
      'habit_id': habitId,
    });
  }

  Future<void> trackApplySuggestionNoHabitData(
      String suggestionId, String title) async {
    await logEvent('apply_suggestion_no_habit_data', {
      'suggestion_id': suggestionId,
      'title': title,
    });
  }

  Future<void> trackApplySuggestionsCompleted(
      int totalSelected, int successfullyApplied) async {
    await logEvent('apply_suggestions_completed', {
      'total_selected': totalSelected,
      'successfully_applied': successfullyApplied,
      'success_rate': totalSelected == 0
          ? 0
          : (successfullyApplied / totalSelected * 100).round(),
    });
  }

  Future<void> trackSuggestionsListUpdated(
      int previousCount, int newCount) async {
    await logEvent('suggestions_list_updated', {
      'previous_count': previousCount,
      'new_count': newCount,
      'changed': previousCount != newCount,
    });
  }

  // Applied Habits Summary Screen Events
  Future<void> trackAppliedHabitsSummaryViewed(
      int habitCount, String categories, int hasReminders) async {
    await logEvent('applied_habits_summary_viewed', {
      'habit_count': habitCount,
      'categories': categories,
      'has_reminders': hasReminders,
    });
  }

  Future<void> trackAppliedHabitsGoHomeClicked(int habitCount) async {
    await logEvent(
        'applied_habits_go_home_clicked', {'habit_count': habitCount});
  }

  Future<void> trackAppliedHabitsBackToSuggestionsClicked(
      int habitCount) async {
    await logEvent('applied_habits_back_to_suggestions_clicked',
        {'habit_count': habitCount});
  }

  Future<void> trackAppliedHabitViewDetailsClicked(
      String habitId, String habitName, String category) async {
    await logEvent('applied_habit_view_details_clicked', {
      'habit_id': habitId,
      'habit_name': habitName,
      'category': category,
    });
  }

  // Add these methods to the AnalyticsService class
  Future<void> trackHabitPlansLoading() async {
    await logEvent('habit_plans_loading', null);
  }

  Future<void> trackHabitPlansLoaded(int count) async {
    await logEvent('habit_plans_loaded', {'count': count});
  }

  Future<void> trackHabitPlansLoadError(String error) async {
    await logEvent('habit_plans_load_error', {'error': error});
  }

  Future<void> trackHabitPlansRetryButtonTapped() async {
    await logEvent('habit_plans_retry_button_tapped', null);
  }

  Future<void> trackHabitPlansSwitchedFromEmpty() async {
    await logEvent('habit_plans_switched_from_empty_suggestions', null);
  }

  Future<void> trackHabitPlansSwitchedFromError() async {
    await logEvent('habit_plans_switched_from_error', null);
  }

  Future<void> trackHabitPlanSelected(String planId, String planTitle) async {
    await logEvent('habit_plan_selected', {
      'plan_id': planId,
      'plan_title': planTitle,
    });
  }

  Future<void> trackHabitPlanHabitsSelected(String planId, String planTitle,
      int selectedCount, int totalCount) async {
    await logEvent('habit_plan_habits_selected', {
      'plan_id': planId,
      'plan_title': planTitle,
      'selected_count': selectedCount,
      'total_count': totalCount,
      'selection_percentage': (selectedCount / totalCount) * 100,
    });
  }

  Future<void> trackHabitPlanHabitsApplied(
      String planId, int selectedCount, int appliedCount) async {
    await logEvent('habit_plan_habits_applied', {
      'plan_id': planId,
      'selected_count': selectedCount,
      'applied_count': appliedCount,
      'success_rate': (appliedCount / selectedCount) * 100,
    });
  }

  Future<void> trackHabitPlanApplyEmptyResult(
      String planId, int selectedCount) async {
    await logEvent('habit_plan_apply_empty_result', {
      'plan_id': planId,
      'selected_count': selectedCount,
    });
  }

  Future<void> trackHabitPlansCategoryFiltered(String category) async {
    await logEvent('habit_plans_category_filtered', {
      'category': category,
    });
  }

  Future<void> trackHabitPlansCategoryChanged(
      String? previousCategory, String? newCategory) async {
    await logEvent('habit_plans_category_changed', {
      'previous_category': previousCategory ?? 'none',
      'new_category': newCategory ?? 'none',
    });
  }

  Future<void> trackHabitPlansCategoryFilterApplied(String categoryName) async {
    await logEvent('habit_plans_category_filter_applied', {
      'category_name': categoryName,
    });
  }

  Future<void> trackHabitPlansCategoryFilterCleared(
      String? previousCategory) async {
    await logEvent('habit_plans_category_filter_cleared', {
      'previous_category': previousCategory ?? 'none',
    });
  }

  Future<void> trackHabitPlansCategoryFilterOpened(String? categoryName) async {
    await logEvent('habit_plans_category_filter_opened', {
      'category_name': categoryName ?? 'none',
    });
  }

  Future<void> trackHabitPlansEmptyStateAllPlansClicked() async {
    await logEvent('habit_plans_empty_state_all_plans_clicked', {});
  }

  void trackNoInternetConnectionForAIPicks() {
    _backend.logEvent('ai_picks_no_internet_connection', null);
  }

  void trackHabitPlanItemTapped(
      String planId, String habitName, String category) {
    _backend.logEvent('habit_plan_item_tapped', {
      'plan_id': planId,
      'habit_name': habitName,
      'category': category,
    });
  }

  void trackHabitPlansUpdated(int count) {
    _backend.logEvent('habit_plans_updated', {'count': count});
  }

  void trackHabitPlanSuggestionUpdated(
      String planId, String suggestionId, String habitName) {
    _backend.logEvent('habit_plan_suggestion_updated', {
      'plan_id': planId,
      'suggestion_id': suggestionId,
      'habit_name': habitName,
    });
  }
}
