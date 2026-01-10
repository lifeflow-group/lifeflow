// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => 'Loading...';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get cancelButton => 'Cancel';

  @override
  String get saveButton => 'Save';

  @override
  String get selectButton => 'Select';

  @override
  String get refreshButton => 'Refresh';

  @override
  String get deleteButton => 'Delete';

  @override
  String get editButton => 'Edit';

  @override
  String get noData => 'No data available';

  @override
  String get retryButton => 'Try Again';

  @override
  String get orSeparator => 'or';

  @override
  String get enabledLabel => 'Enabled';

  @override
  String get disabledLabel => 'Disabled';

  @override
  String get okButton => 'Ok';

  @override
  String get navHome => 'Home';

  @override
  String get navOverview => 'Overview';

  @override
  String get navSuggestions => 'Suggestions';

  @override
  String get navSettings => 'Settings';

  @override
  String get loginTitle => 'Log in with Account';

  @override
  String get usernameHint => 'Username / Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Log in';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get signUpOrLogin => 'Sign up or log in';

  @override
  String get guestMode => 'You are currently in guest mode';

  @override
  String get settings => 'Settings';

  @override
  String get changeAppLanguage => 'Change app language';

  @override
  String get languageTitle => 'Language';

  @override
  String get weekStartsOnTitle => 'Week starts on';

  @override
  String get mondayLabel => 'Monday';

  @override
  String get sundayLabel => 'Sunday';

  @override
  String get notifications => 'Notifications';

  @override
  String get termsOfUse => 'Terms of use';

  @override
  String get termsOfUseTitle => 'Terms of Use';

  @override
  String errorLoadingTerms(Object error) {
    return 'Error loading terms: $error';
  }

  @override
  String get languageSelectorTitle => 'Select Language';

  @override
  String get englishLanguage => 'English';

  @override
  String get vietnameseLanguage => 'Vietnamese';

  @override
  String get spanishLanguage => 'Spanish';

  @override
  String get frenchLanguage => 'French';

  @override
  String get chineseLanguage => 'Chinese';

  @override
  String get germanLanguage => 'German';

  @override
  String get japaneseLanguage => 'Japanese';

  @override
  String get russianLanguage => 'Russian';

  @override
  String get hindiLanguage => 'Hindi';

  @override
  String get koreanLanguage => 'Korean';

  @override
  String get createHabitTitle => 'Create Habit';

  @override
  String get editHabitTitle => 'Edit Habit';

  @override
  String get habitNameLabel => 'Habit Name';

  @override
  String get noHabitsMessage => 'No habits yet. Tap \'+\' to add your habit!';

  @override
  String get saveHabitButton => 'Save Habit';

  @override
  String repeatsEvery(String frequency) {
    return 'Repeats every $frequency';
  }

  @override
  String get hasReminder => 'Has Reminder';

  @override
  String get noReminder => 'No Reminder';

  @override
  String get selectCategoryLabel => 'Select Category';

  @override
  String get selectACategoryDefault => 'Select a category';

  @override
  String get selectDateLabel => 'Select Date';

  @override
  String get timeLabel => 'Time';

  @override
  String get repeatLabel => 'Repeat';

  @override
  String get trackingTypeLabel => 'Tracking Type';

  @override
  String get trackingTypeComplete => 'Complete';

  @override
  String get trackingTypeProgress => 'Progress';

  @override
  String get categoryLabel => 'Category';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeViewLabel => 'Time';

  @override
  String get repeatViewLabel => 'Repeat';

  @override
  String get reminderLabel => 'Reminder';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'Goal: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'unit';

  @override
  String get enableNotificationsLabel => 'Enable Notifications';

  @override
  String get setProgressGoalDialogTitle => 'Set Progress Goal';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get unitLabel => 'Unit';

  @override
  String get updateProgressTitle => 'Update Progress';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'Select Repeat';

  @override
  String get noRepeatLabel => 'No Repeat';

  @override
  String get repeatDaily => 'Daily';

  @override
  String get repeatWeekly => 'Weekly';

  @override
  String get repeatMonthly => 'Monthly';

  @override
  String get repeatYearly => 'Yearly';

  @override
  String get selectCategoryTitle => 'Select a Category';

  @override
  String get categoryTitle => 'Category';

  @override
  String get othersLabel => 'Others';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryPersonalGrowth => 'Personal Growth';

  @override
  String get categoryHobby => 'Hobby';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get categorySocial => 'Social';

  @override
  String get categorySpiritual => 'Spiritual';

  @override
  String get totalHabits => 'Total';

  @override
  String get completionRate => 'Rate';

  @override
  String get completeHabits => 'Complete';

  @override
  String get progressHabits => 'Progress';

  @override
  String get selectMonth => 'Select Month';

  @override
  String get selectMonthTitle => 'Select Month';

  @override
  String errorLoadingChartData(Object error) {
    return 'Error loading chart data: $error';
  }

  @override
  String get noHabitDataMonth => 'No habit data available for this month';

  @override
  String get suggestionTitle => 'Optimization Suggestions';

  @override
  String get noSuggestionsAvailable =>
      'No suggestions available at the moment. Check back later for optimization ideas!';

  @override
  String get aiRecommendationsFailedMessage =>
      'Unable to load AI recommendations';

  @override
  String get tryAgainLaterMessage =>
      'We\'re experiencing issues connecting to our suggestion system. Please try again later or explore available plans.';

  @override
  String get suggestionLoadingTitle => 'Let\'s see suggestions';

  @override
  String get suggestionLoadingDescription =>
      'Your optimized habit suggestions are tailored to you and span categories like Health, Productivity, Mindfulness, Learning, and more.';

  @override
  String get filterAll => 'All';

  @override
  String get filterMostFrequent => 'Most Frequent';

  @override
  String get filterTopPerformed => 'Top Performed';

  @override
  String noHabitsInCategory(String month) {
    return 'No habits in this category for $month';
  }

  @override
  String get noRankedItemsAvailable => 'No items available';

  @override
  String get filterByCategoryLabel => 'Filter by Category';

  @override
  String get filterByCategoryTitle => 'Filter by Category';

  @override
  String get allCategoriesLabel => 'All Categories';

  @override
  String get noHabitsInCategoryMessage => 'No habits found in this category';

  @override
  String get clearFilterTooltip => 'Clear filter';

  @override
  String get showAllHabitsButton => 'Show All Habits';

  @override
  String get addProgressTitle => 'Add Progress';

  @override
  String get enterProgressLabel => 'Enter a value';

  @override
  String get enterNumberEmptyError => 'Please enter a value';

  @override
  String get enterNumberInvalidError => 'Enter a valid number';

  @override
  String get habitDeletedSuccess => 'Habit deleted successfully!';

  @override
  String get habitDeleteFailed => 'Failed to delete habit!';

  @override
  String get cannotRecordFutureHabit =>
      'Cannot record habit for a future date.';

  @override
  String get failedToUpdateHabit => 'Failed to update habit. Please try again.';

  @override
  String get failedToUpdateProgress =>
      'Failed to update progress. Please try again.';

  @override
  String get scopeDialogDefaultTitle => 'Apply changes to...';

  @override
  String get deleteHabitDialogTitle => 'Delete habit?';

  @override
  String get deleteHabitDialogMessage =>
      'Are you sure you want to delete this habit?';

  @override
  String get scopeOptionOnlyThis => 'Only this habit';

  @override
  String get scopeOptionThisAndFuture => 'This and future habits';

  @override
  String get scopeOptionAllInSeries => 'All habits in this series';

  @override
  String get themeSelectionTitle => 'Appearance';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get themeModeSystem => 'Use device settings';

  @override
  String get selectAll => 'Select All';

  @override
  String get applySelected => 'Apply Selected';

  @override
  String get habitsApplied => 'Selected suggestions applied';

  @override
  String get habitAdded => 'Habit successfully added';

  @override
  String get habitAddError => 'Failed to add habit';

  @override
  String get applySuggestion => 'Apply Suggestion';

  @override
  String get appliedHabitsSuccessTitle => 'Success!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count habits successfully applied',
      one: '1 habit successfully applied',
      zero: 'No habits applied',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'These habits are now part of your routine.';

  @override
  String get backToSuggestionsButton => 'Back to Suggestions';

  @override
  String get goToHomeButton => 'Go to Home';

  @override
  String get viewDetailsButton => 'View Details';

  @override
  String get appliedHabitsSummaryTitle => 'Applied Habits';

  @override
  String get aiPicksTab => 'AI Picks';

  @override
  String get habitPlansTab => 'Habit Plans';

  @override
  String get exploreHabitPlans => 'Browse Habit Plans';

  @override
  String habitPlansError(Object error) {
    return 'Error loading habit plans: $error';
  }

  @override
  String get aboutThisPlan => 'About This Plan';

  @override
  String get includedHabits => 'Included Habits';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count habits selected',
      one: '1 habit selected',
      zero: 'No habits selected',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get noInternetConnectionDescription =>
      'Please check your internet connection and try again. Some features may not be available offline.';

  @override
  String get retry => 'Retry';

  @override
  String get viewOfflineContent => 'View Available Content';

  @override
  String get personalizedSuggestionsWelcome =>
      'Personalized AI Habit Suggestions';

  @override
  String get goalsHint => 'Tell me about your goals...';

  @override
  String get personalityLabel => 'Personality';

  @override
  String get availableTimeLabel => 'Available Time';

  @override
  String get guidanceLevelLabel => 'Guidance Level';

  @override
  String get selectPersonalityTitle => 'Select Personality';

  @override
  String get selectAvailableTimeTitle => 'Select Available Time';

  @override
  String get selectGuidanceLevelTitle => 'Select Guidance Level';

  @override
  String get selectDataSourceTitle => 'Select Data Source';

  @override
  String get personalityIntroverted => 'Introverted';

  @override
  String get personalityExtroverted => 'Extroverted';

  @override
  String get personalityDisciplined => 'Disciplined';

  @override
  String get personalityCreative => 'Creative';

  @override
  String get personalityAnalytical => 'Analytical';

  @override
  String get timeMorning => 'Morning';

  @override
  String get timeNoon => 'Noon';

  @override
  String get timeAfternoon => 'Afternoon';

  @override
  String get timeEvening => 'Evening';

  @override
  String get timeFlexible => 'Flexible';

  @override
  String get guidanceSimple => 'Simple';

  @override
  String get guidanceIntermediate => 'Intermediate';

  @override
  String get guidanceAdvanced => 'Advanced';

  @override
  String get dataSourcePersonalizationOnly => 'Personalization Only';

  @override
  String get dataSourceHabitsOnly => 'Habits Only';

  @override
  String get dataSourceBoth => 'Both';
}
