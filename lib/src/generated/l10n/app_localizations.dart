import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'LifeFlow'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(Object error);

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @selectButton.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectButton;

  /// No description provided for @refreshButton.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retryButton;

  /// No description provided for @orSeparator.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orSeparator;

  /// No description provided for @enabledLabel.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabledLabel;

  /// No description provided for @disabledLabel.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabledLabel;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get okButton;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get navOverview;

  /// No description provided for @navSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get navSuggestions;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in with Account'**
  String get loginTitle;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username / Email'**
  String get usernameHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueWithFacebook;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpButton;

  /// No description provided for @signUpOrLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign up or log in'**
  String get signUpOrLogin;

  /// No description provided for @guestMode.
  ///
  /// In en, this message translates to:
  /// **'You are currently in guest mode'**
  String get guestMode;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get changeAppLanguage;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @weekStartsOnTitle.
  ///
  /// In en, this message translates to:
  /// **'Week starts on'**
  String get weekStartsOnTitle;

  /// No description provided for @mondayLabel.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get mondayLabel;

  /// No description provided for @sundayLabel.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sundayLabel;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// No description provided for @termsOfUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUseTitle;

  /// No description provided for @errorLoadingTerms.
  ///
  /// In en, this message translates to:
  /// **'Error loading terms: {error}'**
  String errorLoadingTerms(Object error);

  /// No description provided for @languageSelectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelectorTitle;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @vietnameseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnameseLanguage;

  /// No description provided for @spanishLanguage.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanishLanguage;

  /// No description provided for @frenchLanguage.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get frenchLanguage;

  /// No description provided for @chineseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chineseLanguage;

  /// No description provided for @germanLanguage.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get germanLanguage;

  /// No description provided for @japaneseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japaneseLanguage;

  /// No description provided for @russianLanguage.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russianLanguage;

  /// No description provided for @hindiLanguage.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindiLanguage;

  /// No description provided for @koreanLanguage.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get koreanLanguage;

  /// No description provided for @createHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Habit'**
  String get createHabitTitle;

  /// No description provided for @editHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Habit'**
  String get editHabitTitle;

  /// No description provided for @habitNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Habit Name'**
  String get habitNameLabel;

  /// No description provided for @noHabitsMessage.
  ///
  /// In en, this message translates to:
  /// **'No habits yet. Tap \'+\' to add your habit!'**
  String get noHabitsMessage;

  /// No description provided for @saveHabitButton.
  ///
  /// In en, this message translates to:
  /// **'Save Habit'**
  String get saveHabitButton;

  /// No description provided for @repeatsEvery.
  ///
  /// In en, this message translates to:
  /// **'Repeats every {frequency}'**
  String repeatsEvery(String frequency);

  /// No description provided for @hasReminder.
  ///
  /// In en, this message translates to:
  /// **'Has Reminder'**
  String get hasReminder;

  /// No description provided for @noReminder.
  ///
  /// In en, this message translates to:
  /// **'No Reminder'**
  String get noReminder;

  /// No description provided for @selectCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategoryLabel;

  /// No description provided for @selectACategoryDefault.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectACategoryDefault;

  /// No description provided for @selectDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDateLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @repeatLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeatLabel;

  /// No description provided for @trackingTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Tracking Type'**
  String get trackingTypeLabel;

  /// No description provided for @trackingTypeComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get trackingTypeComplete;

  /// No description provided for @trackingTypeProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get trackingTypeProgress;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @timeViewLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeViewLabel;

  /// No description provided for @repeatViewLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeatViewLabel;

  /// No description provided for @reminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminderLabel;

  /// No description provided for @progressGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal: {targetValue} {unit}'**
  String progressGoalLabel(Object targetValue, String unit);

  /// No description provided for @progressGoalUnitDefault.
  ///
  /// In en, this message translates to:
  /// **'unit'**
  String get progressGoalUnitDefault;

  /// No description provided for @enableNotificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotificationsLabel;

  /// No description provided for @setProgressGoalDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Progress Goal'**
  String get setProgressGoalDialogTitle;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @unitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitLabel;

  /// No description provided for @updateProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Progress'**
  String get updateProgressTitle;

  /// No description provided for @progressFormat.
  ///
  /// In en, this message translates to:
  /// **'{current}/{target} {unit}'**
  String progressFormat(int current, int target, String unit);

  /// No description provided for @selectRepeatSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Repeat'**
  String get selectRepeatSheetTitle;

  /// No description provided for @noRepeatLabel.
  ///
  /// In en, this message translates to:
  /// **'No Repeat'**
  String get noRepeatLabel;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get repeatMonthly;

  /// No description provided for @repeatYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get repeatYearly;

  /// No description provided for @selectCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Category'**
  String get selectCategoryTitle;

  /// No description provided for @categoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryTitle;

  /// No description provided for @othersLabel.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get othersLabel;

  /// No description provided for @categoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// No description provided for @categoryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// No description provided for @categoryPersonalGrowth.
  ///
  /// In en, this message translates to:
  /// **'Personal Growth'**
  String get categoryPersonalGrowth;

  /// No description provided for @categoryHobby.
  ///
  /// In en, this message translates to:
  /// **'Hobby'**
  String get categoryHobby;

  /// No description provided for @categoryFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get categoryFitness;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get categoryFinance;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @categorySpiritual.
  ///
  /// In en, this message translates to:
  /// **'Spiritual'**
  String get categorySpiritual;

  /// No description provided for @totalHabits.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalHabits;

  /// No description provided for @completionRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get completionRate;

  /// No description provided for @completeHabits.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get completeHabits;

  /// No description provided for @progressHabits.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressHabits;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonth;

  /// No description provided for @selectMonthTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonthTitle;

  /// No description provided for @errorLoadingChartData.
  ///
  /// In en, this message translates to:
  /// **'Error loading chart data: {error}'**
  String errorLoadingChartData(Object error);

  /// No description provided for @noHabitDataMonth.
  ///
  /// In en, this message translates to:
  /// **'No habit data available for this month'**
  String get noHabitDataMonth;

  /// No description provided for @suggestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimization Suggestions'**
  String get suggestionTitle;

  /// No description provided for @noSuggestionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No suggestions available at the moment. Check back later for optimization ideas!'**
  String get noSuggestionsAvailable;

  /// No description provided for @aiRecommendationsFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to load AI recommendations'**
  String get aiRecommendationsFailedMessage;

  /// No description provided for @tryAgainLaterMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re experiencing issues connecting to our suggestion system. Please try again later or explore available plans.'**
  String get tryAgainLaterMessage;

  /// No description provided for @suggestionLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s see suggestions'**
  String get suggestionLoadingTitle;

  /// No description provided for @suggestionLoadingDescription.
  ///
  /// In en, this message translates to:
  /// **'Your optimized habit suggestions are tailored to you and span categories like Health, Productivity, Mindfulness, Learning, and more.'**
  String get suggestionLoadingDescription;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterMostFrequent.
  ///
  /// In en, this message translates to:
  /// **'Most Frequent'**
  String get filterMostFrequent;

  /// No description provided for @filterTopPerformed.
  ///
  /// In en, this message translates to:
  /// **'Top Performed'**
  String get filterTopPerformed;

  /// No description provided for @noHabitsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No habits in this category for {month}'**
  String noHabitsInCategory(String month);

  /// No description provided for @noRankedItemsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No items available'**
  String get noRankedItemsAvailable;

  /// No description provided for @filterByCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter by Category'**
  String get filterByCategoryLabel;

  /// No description provided for @filterByCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter by Category'**
  String get filterByCategoryTitle;

  /// No description provided for @allCategoriesLabel.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategoriesLabel;

  /// No description provided for @noHabitsInCategoryMessage.
  ///
  /// In en, this message translates to:
  /// **'No habits found in this category'**
  String get noHabitsInCategoryMessage;

  /// No description provided for @clearFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get clearFilterTooltip;

  /// No description provided for @showAllHabitsButton.
  ///
  /// In en, this message translates to:
  /// **'Show All Habits'**
  String get showAllHabitsButton;

  /// No description provided for @addProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Progress'**
  String get addProgressTitle;

  /// No description provided for @enterProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter a value'**
  String get enterProgressLabel;

  /// No description provided for @enterNumberEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get enterNumberEmptyError;

  /// No description provided for @enterNumberInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get enterNumberInvalidError;

  /// No description provided for @habitDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Habit deleted successfully!'**
  String get habitDeletedSuccess;

  /// No description provided for @habitDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete habit!'**
  String get habitDeleteFailed;

  /// No description provided for @cannotRecordFutureHabit.
  ///
  /// In en, this message translates to:
  /// **'Cannot record habit for a future date.'**
  String get cannotRecordFutureHabit;

  /// No description provided for @failedToUpdateHabit.
  ///
  /// In en, this message translates to:
  /// **'Failed to update habit. Please try again.'**
  String get failedToUpdateHabit;

  /// No description provided for @failedToUpdateProgress.
  ///
  /// In en, this message translates to:
  /// **'Failed to update progress. Please try again.'**
  String get failedToUpdateProgress;

  /// No description provided for @scopeDialogDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply changes to...'**
  String get scopeDialogDefaultTitle;

  /// No description provided for @deleteHabitDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete habit?'**
  String get deleteHabitDialogTitle;

  /// No description provided for @deleteHabitDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this habit?'**
  String get deleteHabitDialogMessage;

  /// No description provided for @scopeOptionOnlyThis.
  ///
  /// In en, this message translates to:
  /// **'Only this habit'**
  String get scopeOptionOnlyThis;

  /// No description provided for @scopeOptionThisAndFuture.
  ///
  /// In en, this message translates to:
  /// **'This and future habits'**
  String get scopeOptionThisAndFuture;

  /// No description provided for @scopeOptionAllInSeries.
  ///
  /// In en, this message translates to:
  /// **'All habits in this series'**
  String get scopeOptionAllInSeries;

  /// No description provided for @themeSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeSelectionTitle;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'Use device settings'**
  String get themeModeSystem;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @applySelected.
  ///
  /// In en, this message translates to:
  /// **'Apply Selected'**
  String get applySelected;

  /// No description provided for @habitsApplied.
  ///
  /// In en, this message translates to:
  /// **'Selected suggestions applied'**
  String get habitsApplied;

  /// No description provided for @habitAdded.
  ///
  /// In en, this message translates to:
  /// **'Habit successfully added'**
  String get habitAdded;

  /// No description provided for @habitAddError.
  ///
  /// In en, this message translates to:
  /// **'Failed to add habit'**
  String get habitAddError;

  /// No description provided for @applySuggestion.
  ///
  /// In en, this message translates to:
  /// **'Apply Suggestion'**
  String get applySuggestion;

  /// No description provided for @appliedHabitsSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get appliedHabitsSuccessTitle;

  /// No description provided for @appliedHabitsCountMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No habits applied} =1{1 habit successfully applied} other{{count} habits successfully applied}}'**
  String appliedHabitsCountMessage(int count);

  /// No description provided for @appliedHabitsDescription.
  ///
  /// In en, this message translates to:
  /// **'These habits are now part of your routine.'**
  String get appliedHabitsDescription;

  /// No description provided for @backToSuggestionsButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Suggestions'**
  String get backToSuggestionsButton;

  /// No description provided for @goToHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHomeButton;

  /// No description provided for @viewDetailsButton.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetailsButton;

  /// No description provided for @appliedHabitsSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Applied Habits'**
  String get appliedHabitsSummaryTitle;

  /// No description provided for @aiPicksTab.
  ///
  /// In en, this message translates to:
  /// **'AI Picks'**
  String get aiPicksTab;

  /// No description provided for @habitPlansTab.
  ///
  /// In en, this message translates to:
  /// **'Habit Plans'**
  String get habitPlansTab;

  /// No description provided for @exploreHabitPlans.
  ///
  /// In en, this message translates to:
  /// **'Browse Habit Plans'**
  String get exploreHabitPlans;

  /// No description provided for @habitPlansError.
  ///
  /// In en, this message translates to:
  /// **'Error loading habit plans: {error}'**
  String habitPlansError(Object error);

  /// No description provided for @aboutThisPlan.
  ///
  /// In en, this message translates to:
  /// **'About This Plan'**
  String get aboutThisPlan;

  /// No description provided for @includedHabits.
  ///
  /// In en, this message translates to:
  /// **'Included Habits'**
  String get includedHabits;

  /// No description provided for @habitsSelectedText.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No habits selected} =1{1 habit selected} other{{count} habits selected}}'**
  String habitsSelectedText(int count);

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @noInternetConnectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again. Some features may not be available offline.'**
  String get noInternetConnectionDescription;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @viewOfflineContent.
  ///
  /// In en, this message translates to:
  /// **'View Available Content'**
  String get viewOfflineContent;

  /// No description provided for @personalizedSuggestionsWelcome.
  ///
  /// In en, this message translates to:
  /// **'Personalized AI Habit Suggestions'**
  String get personalizedSuggestionsWelcome;

  /// No description provided for @goalsHint.
  ///
  /// In en, this message translates to:
  /// **'Tell me about your goals...'**
  String get goalsHint;

  /// No description provided for @personalityLabel.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get personalityLabel;

  /// No description provided for @availableTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Available Time'**
  String get availableTimeLabel;

  /// No description provided for @guidanceLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Guidance Level'**
  String get guidanceLevelLabel;

  /// No description provided for @selectPersonalityTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Personality'**
  String get selectPersonalityTitle;

  /// No description provided for @selectAvailableTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Available Time'**
  String get selectAvailableTimeTitle;

  /// No description provided for @selectGuidanceLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Guidance Level'**
  String get selectGuidanceLevelTitle;

  /// No description provided for @selectDataSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Data Source'**
  String get selectDataSourceTitle;

  /// No description provided for @personalityIntroverted.
  ///
  /// In en, this message translates to:
  /// **'Introverted'**
  String get personalityIntroverted;

  /// No description provided for @personalityExtroverted.
  ///
  /// In en, this message translates to:
  /// **'Extroverted'**
  String get personalityExtroverted;

  /// No description provided for @personalityDisciplined.
  ///
  /// In en, this message translates to:
  /// **'Disciplined'**
  String get personalityDisciplined;

  /// No description provided for @personalityCreative.
  ///
  /// In en, this message translates to:
  /// **'Creative'**
  String get personalityCreative;

  /// No description provided for @personalityAnalytical.
  ///
  /// In en, this message translates to:
  /// **'Analytical'**
  String get personalityAnalytical;

  /// No description provided for @timeMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get timeMorning;

  /// No description provided for @timeNoon.
  ///
  /// In en, this message translates to:
  /// **'Noon'**
  String get timeNoon;

  /// No description provided for @timeAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get timeAfternoon;

  /// No description provided for @timeEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get timeEvening;

  /// No description provided for @timeFlexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get timeFlexible;

  /// No description provided for @guidanceSimple.
  ///
  /// In en, this message translates to:
  /// **'Simple'**
  String get guidanceSimple;

  /// No description provided for @guidanceIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get guidanceIntermediate;

  /// No description provided for @guidanceAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get guidanceAdvanced;

  /// No description provided for @dataSourcePersonalizationOnly.
  ///
  /// In en, this message translates to:
  /// **'Personalization Only'**
  String get dataSourcePersonalizationOnly;

  /// No description provided for @dataSourceHabitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Habits Only'**
  String get dataSourceHabitsOnly;

  /// No description provided for @dataSourceBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get dataSourceBoth;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'ja',
        'ko',
        'ru',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
