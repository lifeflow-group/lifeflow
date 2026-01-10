// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => 'Wird geladen...';

  @override
  String errorMessage(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get saveButton => 'Speichern';

  @override
  String get selectButton => 'Auswählen';

  @override
  String get refreshButton => 'Aktualisieren';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get editButton => 'Bearbeiten';

  @override
  String get noData => 'Keine Daten verfügbar';

  @override
  String get retryButton => 'Erneut versuchen';

  @override
  String get orSeparator => 'oder';

  @override
  String get enabledLabel => 'Aktiviert';

  @override
  String get disabledLabel => 'Deaktiviert';

  @override
  String get okButton => 'Ok';

  @override
  String get navHome => 'Startseite';

  @override
  String get navOverview => 'Übersicht';

  @override
  String get navSuggestions => 'Vorschläge';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get loginTitle => 'Mit Konto anmelden';

  @override
  String get usernameHint => 'Benutzername / E-Mail';

  @override
  String get passwordHint => 'Passwort';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get continueAsGuest => 'Als Gast fortfahren';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get continueWithFacebook => 'Mit Facebook fortfahren';

  @override
  String get continueWithGoogle => 'Mit Google fortfahren';

  @override
  String get noAccount => 'Noch keinen Account?';

  @override
  String get signUpButton => 'Registrieren';

  @override
  String get signUpOrLogin => 'Registrieren oder anmelden';

  @override
  String get guestMode => 'Sie befinden sich derzeit im Gastmodus';

  @override
  String get settings => 'Einstellungen';

  @override
  String get changeAppLanguage => 'App-Sprache ändern';

  @override
  String get languageTitle => 'Sprache';

  @override
  String get weekStartsOnTitle => 'Woche beginnt am';

  @override
  String get mondayLabel => 'Montag';

  @override
  String get sundayLabel => 'Sonntag';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get termsOfUse => 'Nutzungsbedingungen';

  @override
  String get termsOfUseTitle => 'Nutzungsbedingungen';

  @override
  String errorLoadingTerms(Object error) {
    return 'Fehler beim Laden der Nutzungsbedingungen: $error';
  }

  @override
  String get languageSelectorTitle => 'Sprache auswählen';

  @override
  String get englishLanguage => 'Englisch';

  @override
  String get vietnameseLanguage => 'Vietnamesisch';

  @override
  String get spanishLanguage => 'Spanisch';

  @override
  String get frenchLanguage => 'Französisch';

  @override
  String get chineseLanguage => 'Chinesisch';

  @override
  String get germanLanguage => 'Deutsch';

  @override
  String get japaneseLanguage => 'Japanisch';

  @override
  String get russianLanguage => 'Russisch';

  @override
  String get hindiLanguage => 'Hindi';

  @override
  String get koreanLanguage => 'Koreanisch';

  @override
  String get createHabitTitle => 'Gewohnheit erstellen';

  @override
  String get editHabitTitle => 'Gewohnheit bearbeiten';

  @override
  String get habitNameLabel => 'Gewohnheitsname';

  @override
  String get noHabitsMessage =>
      'Noch keine Gewohnheiten. Tippen Sie auf \'+\', um Ihre Gewohnheit hinzuzufügen!';

  @override
  String get saveHabitButton => 'Gewohnheit speichern';

  @override
  String repeatsEvery(String frequency) {
    return 'Wiederholt alle $frequency';
  }

  @override
  String get hasReminder => 'Erinnerung';

  @override
  String get noReminder => 'Keine Erinnerung';

  @override
  String get selectCategoryLabel => 'Kategorie auswählen';

  @override
  String get selectACategoryDefault => 'Kategorie auswählen';

  @override
  String get selectDateLabel => 'Datum auswählen';

  @override
  String get timeLabel => 'Zeit';

  @override
  String get repeatLabel => 'Wiederholen';

  @override
  String get trackingTypeLabel => 'Tracking-Typ';

  @override
  String get trackingTypeComplete => 'Abschließen';

  @override
  String get trackingTypeProgress => 'Fortschritt';

  @override
  String get categoryLabel => 'Kategorie';

  @override
  String get dateLabel => 'Datum';

  @override
  String get timeViewLabel => 'Zeit';

  @override
  String get repeatViewLabel => 'Wiederholen';

  @override
  String get reminderLabel => 'Erinnerung';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'Ziel: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'Einheit';

  @override
  String get enableNotificationsLabel => 'Benachrichtigungen aktivieren';

  @override
  String get setProgressGoalDialogTitle => 'Fortschrittsziel festlegen';

  @override
  String get quantityLabel => 'Anzahl';

  @override
  String get unitLabel => 'Einheit';

  @override
  String get updateProgressTitle => 'Fortschritt aktualisieren';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'Wiederholung auswählen';

  @override
  String get noRepeatLabel => 'Keine Wiederholung';

  @override
  String get repeatDaily => 'Täglich';

  @override
  String get repeatWeekly => 'Wöchentlich';

  @override
  String get repeatMonthly => 'Monatlich';

  @override
  String get repeatYearly => 'Jährlich';

  @override
  String get selectCategoryTitle => 'Kategorie auswählen';

  @override
  String get categoryTitle => 'Kategorie';

  @override
  String get othersLabel => 'Andere';

  @override
  String get categoryHealth => 'Gesundheit';

  @override
  String get categoryWork => 'Arbeit';

  @override
  String get categoryPersonalGrowth => 'Persönliches Wachstum';

  @override
  String get categoryHobby => 'Hobby';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryEducation => 'Bildung';

  @override
  String get categoryFinance => 'Finanzen';

  @override
  String get categorySocial => 'Soziales';

  @override
  String get categorySpiritual => 'Spiritualität';

  @override
  String get totalHabits => 'Gesamt';

  @override
  String get completionRate => 'Rate';

  @override
  String get completeHabits => 'Abgeschlossen';

  @override
  String get progressHabits => 'Fortschritt';

  @override
  String get selectMonth => 'Monat auswählen';

  @override
  String get selectMonthTitle => 'Monat auswählen';

  @override
  String errorLoadingChartData(Object error) {
    return 'Fehler beim Laden der Chartdaten: $error';
  }

  @override
  String get noHabitDataMonth =>
      'Keine Gewohnheitsdaten für diesen Monat verfügbar';

  @override
  String get suggestionTitle => 'Optimierungsvorschläge';

  @override
  String get noSuggestionsAvailable =>
      'Derzeit sind keine Vorschläge verfügbar. Schauen Sie später noch einmal nach, um Optimierungsideen zu erhalten!';

  @override
  String get aiRecommendationsFailedMessage =>
      'Konnte KI-Empfehlungen nicht laden';

  @override
  String get tryAgainLaterMessage =>
      'Wir haben derzeit Probleme mit der Verbindung zu unserem Vorschlagssystem. Bitte versuche es später noch einmal oder sieh dir die verfügbaren Pläne an.';

  @override
  String get suggestionLoadingTitle => 'Lass uns Vorschläge ansehen';

  @override
  String get suggestionLoadingDescription =>
      'Deine optimierten Gewohnheitsvorschläge sind auf dich zugeschnitten und umfassen Kategorien wie Gesundheit, Produktivität, Achtsamkeit, Lernen und mehr.';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterMostFrequent => 'Am häufigsten';

  @override
  String get filterTopPerformed => 'Am besten durchgeführt';

  @override
  String noHabitsInCategory(String month) {
    return 'Keine Gewohnheiten in dieser Kategorie für $month';
  }

  @override
  String get noRankedItemsAvailable => 'Keine Einträge verfügbar';

  @override
  String get filterByCategoryLabel => 'Nach Kategorie filtern';

  @override
  String get filterByCategoryTitle => 'Nach Kategorie filtern';

  @override
  String get allCategoriesLabel => 'Alle Kategorien';

  @override
  String get noHabitsInCategoryMessage =>
      'Keine Gewohnheiten in dieser Kategorie gefunden';

  @override
  String get clearFilterTooltip => 'Filter löschen';

  @override
  String get showAllHabitsButton => 'Alle Gewohnheiten anzeigen';

  @override
  String get addProgressTitle => 'Fortschritt hinzufügen';

  @override
  String get enterProgressLabel => 'Geben Sie einen Wert ein';

  @override
  String get enterNumberEmptyError => 'Bitte geben Sie einen Wert ein';

  @override
  String get enterNumberInvalidError => 'Geben Sie eine gültige Zahl ein';

  @override
  String get habitDeletedSuccess => 'Gewohnheit erfolgreich gelöscht!';

  @override
  String get habitDeleteFailed => 'Gewohnheit konnte nicht gelöscht werden!';

  @override
  String get cannotRecordFutureHabit =>
      'Kann Gewohnheit nicht für ein zukünftiges Datum erfassen.';

  @override
  String get failedToUpdateHabit =>
      'Gewohnheit konnte nicht aktualisiert werden. Bitte versuchen Sie es erneut.';

  @override
  String get failedToUpdateProgress =>
      'Fortschritt konnte nicht aktualisiert werden. Bitte versuchen Sie es erneut.';

  @override
  String get scopeDialogDefaultTitle => 'Änderungen anwenden auf...';

  @override
  String get deleteHabitDialogTitle => 'Gewohnheit löschen?';

  @override
  String get deleteHabitDialogMessage =>
      'Sind Sie sicher, dass Sie diese Gewohnheit löschen möchten?';

  @override
  String get scopeOptionOnlyThis => 'Nur diese Gewohnheit';

  @override
  String get scopeOptionThisAndFuture => 'Diese und zukünftige Gewohnheiten';

  @override
  String get scopeOptionAllInSeries => 'Alle Gewohnheiten in dieser Serie';

  @override
  String get themeSelectionTitle => 'Aussehen';

  @override
  String get themeModeLight => 'Hell';

  @override
  String get themeModeDark => 'Dunkel';

  @override
  String get themeModeSystem => 'Geräte-Einstellungen verwenden';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get applySelected => 'Ausgewählte übernehmen';

  @override
  String get habitsApplied => 'Ausgewählte Vorschläge übernommen';

  @override
  String get habitAdded => 'Gewohnheit erfolgreich hinzugefügt';

  @override
  String get habitAddError => 'Gewohnheit konnte nicht hinzugefügt werden';

  @override
  String get applySuggestion => 'Vorschlag übernehmen';

  @override
  String get appliedHabitsSuccessTitle => 'Erfolg!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# Gewohnheiten erfolgreich angewendet',
      one: '1 Gewohnheit erfolgreich angewendet',
      zero: 'Keine Gewohnheiten angewendet',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'Diese Gewohnheiten sind jetzt Teil deiner Routine.';

  @override
  String get backToSuggestionsButton => 'Zurück zu Vorschlägen';

  @override
  String get goToHomeButton => 'Zur Startseite';

  @override
  String get viewDetailsButton => 'Details ansehen';

  @override
  String get appliedHabitsSummaryTitle => 'Angewendete Gewohnheiten';

  @override
  String get aiPicksTab => 'KI-Tipps';

  @override
  String get habitPlansTab => 'Habit-Pläne';

  @override
  String get exploreHabitPlans => 'Habit-Pläne durchsuchen';

  @override
  String habitPlansError(Object error) {
    return 'Fehler beim Laden der Habit-Pläne: $error';
  }

  @override
  String get aboutThisPlan => 'Über diesen Plan';

  @override
  String get includedHabits => 'Enthaltene Habits';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# Gewohnheiten ausgewählt',
      one: '1 Gewohnheit ausgewählt',
      zero: 'Keine Gewohnheiten ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'Keine Internetverbindung';

  @override
  String get noInternetConnectionDescription =>
      'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut. Einige Funktionen sind offline möglicherweise nicht verfügbar.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get viewOfflineContent => 'Verfügbare Inhalte anzeigen';

  @override
  String get personalizedSuggestionsWelcome =>
      'Personalisierte KI-Habit-Vorschläge';

  @override
  String get goalsHint => 'Erzählen Sie mir von Ihren Zielen...';

  @override
  String get personalityLabel => 'Persönlichkeit';

  @override
  String get availableTimeLabel => 'Verfügbare Zeit';

  @override
  String get guidanceLevelLabel => 'Führungslevel';

  @override
  String get selectPersonalityTitle => 'Persönlichkeit auswählen';

  @override
  String get selectAvailableTimeTitle => 'Verfügbare Zeit auswählen';

  @override
  String get selectGuidanceLevelTitle => 'Führungslevel auswählen';

  @override
  String get selectDataSourceTitle => 'Datenquelle auswählen';

  @override
  String get personalityIntroverted => 'Introvertiert';

  @override
  String get personalityExtroverted => 'Extrovertiert';

  @override
  String get personalityDisciplined => 'Diszipliniert';

  @override
  String get personalityCreative => 'Kreativ';

  @override
  String get personalityAnalytical => 'Analytisch';

  @override
  String get timeMorning => 'Morgen';

  @override
  String get timeNoon => 'Mittag';

  @override
  String get timeAfternoon => 'Nachmittag';

  @override
  String get timeEvening => 'Abend';

  @override
  String get timeFlexible => 'Flexibel';

  @override
  String get guidanceSimple => 'Einfach';

  @override
  String get guidanceIntermediate => 'Mittel';

  @override
  String get guidanceAdvanced => 'Fortgeschritten';

  @override
  String get dataSourcePersonalizationOnly => 'Nur Personalisierung';

  @override
  String get dataSourceHabitsOnly => 'Nur Gewohnheiten';

  @override
  String get dataSourceBoth => 'Beides';
}
