// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'लाइफ़फ़्लो';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String errorMessage(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get cancelButton => 'रद्द करें';

  @override
  String get saveButton => 'सहेजें';

  @override
  String get selectButton => 'चुनें';

  @override
  String get refreshButton => 'ताज़ा करें';

  @override
  String get deleteButton => 'हटाएँ';

  @override
  String get editButton => 'संपादित करें';

  @override
  String get noData => 'कोई डेटा उपलब्ध नहीं है';

  @override
  String get retryButton => 'फिर से कोशिश करें';

  @override
  String get orSeparator => 'या';

  @override
  String get enabledLabel => 'सक्रिय';

  @override
  String get disabledLabel => 'निष्क्रिय';

  @override
  String get okButton => 'ठीक है';

  @override
  String get navHome => 'होम';

  @override
  String get navOverview => 'अवलोकन';

  @override
  String get navSuggestions => 'सुझाव';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get loginTitle => 'खाते से लॉग इन करें';

  @override
  String get usernameHint => 'उपयोगकर्ता नाम / ईमेल';

  @override
  String get passwordHint => 'पासवर्ड';

  @override
  String get loginButton => 'लॉग इन करें';

  @override
  String get continueAsGuest => 'अतिथि के रूप में जारी रखें';

  @override
  String get forgotPassword => 'अपना पासवर्ड भूल गए?';

  @override
  String get continueWithFacebook => 'फेसबुक के साथ जारी रखें';

  @override
  String get continueWithGoogle => 'गूगल के साथ जारी रखें';

  @override
  String get noAccount => 'खाता नहीं है?';

  @override
  String get signUpButton => 'साइन अप करें';

  @override
  String get signUpOrLogin => 'साइन अप करें या लॉग इन करें';

  @override
  String get guestMode => 'आप वर्तमान में अतिथि मोड में हैं';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get changeAppLanguage => 'ऐप भाषा बदलें';

  @override
  String get languageTitle => 'भाषा';

  @override
  String get weekStartsOnTitle => 'सप्ताह शुरू होता है';

  @override
  String get mondayLabel => 'सोमवार';

  @override
  String get sundayLabel => 'रविवार';

  @override
  String get notifications => 'सूचनाएँ';

  @override
  String get termsOfUse => 'उपयोग की शर्तें';

  @override
  String get termsOfUseTitle => 'उपयोग की शर्तें';

  @override
  String errorLoadingTerms(Object error) {
    return 'शर्तें लोड करने में त्रुटि: $error';
  }

  @override
  String get languageSelectorTitle => 'भाषा चुनें';

  @override
  String get englishLanguage => 'अंग्रेज़ी';

  @override
  String get vietnameseLanguage => 'वियतनामी';

  @override
  String get spanishLanguage => 'स्पेनिश';

  @override
  String get frenchLanguage => 'फ़्रेंच';

  @override
  String get chineseLanguage => 'चीनी';

  @override
  String get germanLanguage => 'जर्मन';

  @override
  String get japaneseLanguage => 'जापानी';

  @override
  String get russianLanguage => 'रूसी';

  @override
  String get hindiLanguage => 'हिंदी';

  @override
  String get koreanLanguage => 'कोरियाई';

  @override
  String get createHabitTitle => 'आदत बनाएँ';

  @override
  String get editHabitTitle => 'आदत संपादित करें';

  @override
  String get habitNameLabel => 'आदत का नाम';

  @override
  String get noHabitsMessage =>
      'अभी तक कोई आदत नहीं है। अपनी आदत जोड़ने के लिए \'+\' पर टैप करें!';

  @override
  String get saveHabitButton => 'आदत सहेजें';

  @override
  String repeatsEvery(String frequency) {
    return '$frequency पर दोहराता है';
  }

  @override
  String get hasReminder => 'रिमाइंडर है';

  @override
  String get noReminder => 'कोई रिमाइंडर नहीं';

  @override
  String get selectCategoryLabel => 'श्रेणी चुनें';

  @override
  String get selectACategoryDefault => 'एक श्रेणी चुनें';

  @override
  String get selectDateLabel => 'तिथि चुनें';

  @override
  String get timeLabel => 'समय';

  @override
  String get repeatLabel => 'दोहराएँ';

  @override
  String get trackingTypeLabel => 'ट्रैकिंग प्रकार';

  @override
  String get trackingTypeComplete => 'पूर्ण';

  @override
  String get trackingTypeProgress => 'प्रगति';

  @override
  String get categoryLabel => 'श्रेणी';

  @override
  String get dateLabel => 'तिथि';

  @override
  String get timeViewLabel => 'समय';

  @override
  String get repeatViewLabel => 'दोहराएँ';

  @override
  String get reminderLabel => 'रिमाइंडर';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'लक्ष्य: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'इकाई';

  @override
  String get enableNotificationsLabel => 'सूचनाएँ सक्षम करें';

  @override
  String get setProgressGoalDialogTitle => 'प्रगति लक्ष्य निर्धारित करें';

  @override
  String get quantityLabel => 'मात्रा';

  @override
  String get unitLabel => 'इकाई';

  @override
  String get updateProgressTitle => 'प्रगति अपडेट करें';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'दोहराएँ चुनें';

  @override
  String get noRepeatLabel => 'कोई दोहराव नहीं';

  @override
  String get repeatDaily => 'दैनिक';

  @override
  String get repeatWeekly => 'साप्ताहिक';

  @override
  String get repeatMonthly => 'मासिक';

  @override
  String get repeatYearly => 'वार्षिक';

  @override
  String get selectCategoryTitle => 'एक श्रेणी चुनें';

  @override
  String get categoryTitle => 'श्रेणी';

  @override
  String get othersLabel => 'अन्य';

  @override
  String get categoryHealth => 'स्वास्थ्य';

  @override
  String get categoryWork => 'कार्य';

  @override
  String get categoryPersonalGrowth => 'व्यक्तिगत विकास';

  @override
  String get categoryHobby => 'शौक';

  @override
  String get categoryFitness => 'फिटनेस';

  @override
  String get categoryEducation => 'शिक्षा';

  @override
  String get categoryFinance => 'वित्त';

  @override
  String get categorySocial => 'सामाजिक';

  @override
  String get categorySpiritual => 'आध्यात्मिक';

  @override
  String get totalHabits => 'कुल';

  @override
  String get completionRate => 'दर';

  @override
  String get completeHabits => 'पूर्ण';

  @override
  String get progressHabits => 'प्रगति';

  @override
  String get selectMonth => 'महीना चुनें';

  @override
  String get selectMonthTitle => 'महीना चुनें';

  @override
  String errorLoadingChartData(Object error) {
    return 'चार्ट डेटा लोड करने में त्रुटि: $error';
  }

  @override
  String get noHabitDataMonth => 'इस महीने के लिए कोई आदत डेटा उपलब्ध नहीं है';

  @override
  String get suggestionTitle => 'ऑप्टिमाइज़ेशन सुझाव';

  @override
  String get noSuggestionsAvailable =>
      'इस समय कोई सुझाव उपलब्ध नहीं हैं। अनुकूलन विचारों के लिए बाद में फिर से देखें!';

  @override
  String get aiRecommendationsFailedMessage => 'AI अनुशंसाएँ लोड नहीं हो सकीं';

  @override
  String get tryAgainLaterMessage =>
      'हमारे सुझाव सिस्टम से कनेक्ट करने में समस्या आ रही है। कृपया बाद में फिर से कोशिश करें या उपलब्ध प्लान देखें।';

  @override
  String get suggestionLoadingTitle => 'आइए सुझाव देखें';

  @override
  String get suggestionLoadingDescription =>
      'आपके अनुकूलित आदत सुझाव आपके लिए तैयार किए गए हैं और स्वास्थ्य, उत्पादकता, दिमाग़ की शांति, सीखने और बहुत कुछ जैसी श्रेणियों में फैले हुए हैं।';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterMostFrequent => 'सबसे अधिक बार';

  @override
  String get filterTopPerformed => 'शीर्ष प्रदर्शन किया गया';

  @override
  String noHabitsInCategory(String month) {
    return 'इस श्रेणी में $month के लिए कोई आदतें नहीं हैं';
  }

  @override
  String get noRankedItemsAvailable => 'कोई आइटम उपलब्ध नहीं है';

  @override
  String get filterByCategoryLabel => 'श्रेणी द्वारा फ़िल्टर करें';

  @override
  String get filterByCategoryTitle => 'श्रेणी द्वारा फ़िल्टर करें';

  @override
  String get allCategoriesLabel => 'सभी श्रेणियाँ';

  @override
  String get noHabitsInCategoryMessage => 'इस श्रेणी में कोई आदत नहीं मिली';

  @override
  String get clearFilterTooltip => 'फ़िल्टर साफ़ करें';

  @override
  String get showAllHabitsButton => 'सभी आदतें दिखाएँ';

  @override
  String get addProgressTitle => 'प्रगति जोड़ें';

  @override
  String get enterProgressLabel => 'मान दर्ज करें';

  @override
  String get enterNumberEmptyError => 'कृपया कोई मान दर्ज करें';

  @override
  String get enterNumberInvalidError => 'एक मान्य संख्या दर्ज करें';

  @override
  String get habitDeletedSuccess => 'आदत सफलतापूर्वक हटा दी गई!';

  @override
  String get habitDeleteFailed => 'आदत हटाने में विफल!';

  @override
  String get cannotRecordFutureHabit =>
      'भविष्य की तिथि के लिए आदत रिकॉर्ड नहीं कर सकते।';

  @override
  String get failedToUpdateHabit =>
      'आदत अपडेट करने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String get failedToUpdateProgress =>
      'प्रगति अपडेट करने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String get scopeDialogDefaultTitle => 'परिवर्तन लागू करें...';

  @override
  String get deleteHabitDialogTitle => 'आदत हटाएँ?';

  @override
  String get deleteHabitDialogMessage =>
      'क्या आप वास्तव में इस आदत को हटाना चाहते हैं?';

  @override
  String get scopeOptionOnlyThis => 'केवल यह आदत';

  @override
  String get scopeOptionThisAndFuture => 'यह और भविष्य की आदतें';

  @override
  String get scopeOptionAllInSeries => 'इस श्रृंखला की सभी आदतें';

  @override
  String get themeSelectionTitle => 'रूप-रंग';

  @override
  String get themeModeLight => 'प्रकाश';

  @override
  String get themeModeDark => 'अंधकार';

  @override
  String get themeModeSystem => 'डिवाइस सेटिंग्स का प्रयोग करें';

  @override
  String get selectAll => 'सभी का चयन करें';

  @override
  String get applySelected => 'चयनित लागू करें';

  @override
  String get habitsApplied => 'चयनित सुझाव लागू किए गए';

  @override
  String get habitAdded => 'आदत सफलतापूर्वक जोड़ी गई';

  @override
  String get habitAddError => 'आदत जोड़ने में विफल';

  @override
  String get applySuggestion => 'सुझाव लागू करें';

  @override
  String get appliedHabitsSuccessTitle => 'सफल!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count आदतें सफलतापूर्वक लागू की गईं',
      one: '1 आदत सफलतापूर्वक लागू की गई',
      zero: 'कोई आदत लागू नहीं की गई',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'ये आदतें अब आपकी दिनचर्या का हिस्सा हैं।';

  @override
  String get backToSuggestionsButton => 'सुझावों पर वापस जाएँ';

  @override
  String get goToHomeButton => 'होम पर जाएँ';

  @override
  String get viewDetailsButton => 'विस्तृत जानकारी देखें';

  @override
  String get appliedHabitsSummaryTitle => 'लागू आदतें';

  @override
  String get aiPicksTab => 'AI Picks';

  @override
  String get habitPlansTab => 'अभ्यस्त योजनाएँ';

  @override
  String get exploreHabitPlans => 'अभ्यस्त योजनाएँ ब्राउज़ करें';

  @override
  String habitPlansError(Object error) {
    return 'अभ्यस्त योजनाएँ लोड करने में त्रुटि: $error';
  }

  @override
  String get aboutThisPlan => 'इस योजना के बारे में';

  @override
  String get includedHabits => 'शामिल आदतें';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count आदतें चुनी गईं',
      one: '1 आदत चुनी गई',
      zero: 'कोई आदत नहीं चुनी गई',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'इंटरनेट कनेक्शन नहीं है';

  @override
  String get noInternetConnectionDescription =>
      'कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें। कुछ सुविधाएँ ऑफ़लाइन उपलब्ध नहीं हो सकती हैं।';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get viewOfflineContent => 'उपलब्ध सामग्री देखें';

  @override
  String get personalizedSuggestionsWelcome => 'व्यक्तिगत AI आदत सुझाव';

  @override
  String get goalsHint => 'मुझे अपने लक्ष्यों के बारे में बताएं...';

  @override
  String get personalityLabel => 'व्यक्तित्व';

  @override
  String get availableTimeLabel => 'उपलब्ध समय';

  @override
  String get guidanceLevelLabel => 'निर्देशन स्तर';

  @override
  String get selectPersonalityTitle => 'व्यक्तित्व चुनें';

  @override
  String get selectAvailableTimeTitle => 'उपलब्ध समय चुनें';

  @override
  String get selectGuidanceLevelTitle => 'निर्देशन स्तर चुनें';

  @override
  String get selectDataSourceTitle => 'डेटा स्रोत चुनें';

  @override
  String get personalityIntroverted => 'अंतर्मुखी';

  @override
  String get personalityExtroverted => 'बहिर्मुखी';

  @override
  String get personalityDisciplined => 'अनुशासित';

  @override
  String get personalityCreative => 'रचनात्मक';

  @override
  String get personalityAnalytical => 'विश्लेषणात्मक';

  @override
  String get timeMorning => 'सुबह';

  @override
  String get timeNoon => 'दोपहर';

  @override
  String get timeAfternoon => 'दोपहर';

  @override
  String get timeEvening => 'शाम';

  @override
  String get timeFlexible => 'लचीला';

  @override
  String get guidanceSimple => 'सरल';

  @override
  String get guidanceIntermediate => 'मध्यम';

  @override
  String get guidanceAdvanced => 'उन्नत';

  @override
  String get dataSourcePersonalizationOnly => 'केवल वैयक्तिकरण';

  @override
  String get dataSourceHabitsOnly => 'केवल आदतें';

  @override
  String get dataSourceBoth => 'दोनों';
}
