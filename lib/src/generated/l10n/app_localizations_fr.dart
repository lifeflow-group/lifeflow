// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => 'Chargement...';

  @override
  String errorMessage(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get cancelButton => 'Annuler';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get selectButton => 'Sélectionner';

  @override
  String get refreshButton => 'Actualiser';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get editButton => 'Modifier';

  @override
  String get noData => 'Aucune donnée disponible';

  @override
  String get retryButton => 'Réessayer';

  @override
  String get orSeparator => 'ou';

  @override
  String get enabledLabel => 'Activé';

  @override
  String get disabledLabel => 'Désactivé';

  @override
  String get okButton => 'Ok';

  @override
  String get navHome => 'Accueil';

  @override
  String get navOverview => 'Vue d\'ensemble';

  @override
  String get navSuggestions => 'Suggestions';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get loginTitle => 'Connexion avec le compte';

  @override
  String get usernameHint => 'Nom d\'utilisateur / Email';

  @override
  String get passwordHint => 'Mot de passe';

  @override
  String get loginButton => 'Connexion';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get continueWithFacebook => 'Continuer avec Facebook';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get noAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get signUpButton => 'Inscription';

  @override
  String get signUpOrLogin => 'Inscription ou connexion';

  @override
  String get guestMode => 'Vous êtes actuellement en mode invité';

  @override
  String get settings => 'Paramètres';

  @override
  String get changeAppLanguage => 'Modifier la langue de l\'application';

  @override
  String get languageTitle => 'Langue';

  @override
  String get weekStartsOnTitle => 'La semaine commence le';

  @override
  String get mondayLabel => 'Lundi';

  @override
  String get sundayLabel => 'Dimanche';

  @override
  String get notifications => 'Notifications';

  @override
  String get termsOfUse => 'Conditions d\'utilisation';

  @override
  String get termsOfUseTitle => 'Conditions d\'utilisation';

  @override
  String errorLoadingTerms(Object error) {
    return 'Erreur de chargement des conditions : $error';
  }

  @override
  String get languageSelectorTitle => 'Sélectionner la langue';

  @override
  String get englishLanguage => 'Anglais';

  @override
  String get vietnameseLanguage => 'Vietnamien';

  @override
  String get spanishLanguage => 'Espagnol';

  @override
  String get frenchLanguage => 'Français';

  @override
  String get chineseLanguage => 'Chinois';

  @override
  String get germanLanguage => 'Allemand';

  @override
  String get japaneseLanguage => 'Japonais';

  @override
  String get russianLanguage => 'Russe';

  @override
  String get hindiLanguage => 'Hindi';

  @override
  String get koreanLanguage => 'Coréen';

  @override
  String get createHabitTitle => 'Créer une habitude';

  @override
  String get editHabitTitle => 'Modifier une habitude';

  @override
  String get habitNameLabel => 'Nom de l\'habitude';

  @override
  String get noHabitsMessage =>
      'Aucune habitude pour le moment. Appuyez sur \'+\' pour ajouter votre habitude !';

  @override
  String get saveHabitButton => 'Enregistrer l\'habitude';

  @override
  String repeatsEvery(String frequency) {
    return 'Se répète tous les $frequency';
  }

  @override
  String get hasReminder => 'A un rappel';

  @override
  String get noReminder => 'Aucun rappel';

  @override
  String get selectCategoryLabel => 'Sélectionner une catégorie';

  @override
  String get selectACategoryDefault => 'Sélectionner une catégorie';

  @override
  String get selectDateLabel => 'Sélectionner la date';

  @override
  String get timeLabel => 'Heure';

  @override
  String get repeatLabel => 'Répéter';

  @override
  String get trackingTypeLabel => 'Type de suivi';

  @override
  String get trackingTypeComplete => 'Terminé';

  @override
  String get trackingTypeProgress => 'Progression';

  @override
  String get categoryLabel => 'Catégorie';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeViewLabel => 'Heure';

  @override
  String get repeatViewLabel => 'Répéter';

  @override
  String get reminderLabel => 'Rappel';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'Objectif : $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'unité';

  @override
  String get enableNotificationsLabel => 'Activer les notifications';

  @override
  String get setProgressGoalDialogTitle => 'Définir l\'objectif de progression';

  @override
  String get quantityLabel => 'Quantité';

  @override
  String get unitLabel => 'Unité';

  @override
  String get updateProgressTitle => 'Mettre à jour la progression';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'Sélectionner la répétition';

  @override
  String get noRepeatLabel => 'Pas de répétition';

  @override
  String get repeatDaily => 'Quotidien';

  @override
  String get repeatWeekly => 'Hebdomadaire';

  @override
  String get repeatMonthly => 'Mensuel';

  @override
  String get repeatYearly => 'Annuel';

  @override
  String get selectCategoryTitle => 'Sélectionner une catégorie';

  @override
  String get categoryTitle => 'Catégorie';

  @override
  String get othersLabel => 'Autres';

  @override
  String get categoryHealth => 'Santé';

  @override
  String get categoryWork => 'Travail';

  @override
  String get categoryPersonalGrowth => 'Développement personnel';

  @override
  String get categoryHobby => 'Passe-temps';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryEducation => 'Éducation';

  @override
  String get categoryFinance => 'Finances';

  @override
  String get categorySocial => 'Social';

  @override
  String get categorySpiritual => 'Spirituel';

  @override
  String get totalHabits => 'Total';

  @override
  String get completionRate => 'Taux';

  @override
  String get completeHabits => 'Terminé';

  @override
  String get progressHabits => 'Progression';

  @override
  String get selectMonth => 'Sélectionner le mois';

  @override
  String get selectMonthTitle => 'Sélectionner le mois';

  @override
  String errorLoadingChartData(Object error) {
    return 'Erreur de chargement des données du graphique : $error';
  }

  @override
  String get noHabitDataMonth =>
      'Aucune donnée d\'habitude disponible pour ce mois';

  @override
  String get suggestionTitle => 'Suggestions d\'optimisation';

  @override
  String get noSuggestionsAvailable =>
      'Aucune suggestion disponible pour le moment. Revenez plus tard pour des idées d\'optimisation !';

  @override
  String get aiRecommendationsFailedMessage =>
      'Impossible de charger les recommandations de l\'IA';

  @override
  String get tryAgainLaterMessage =>
      'Nous rencontrons des problèmes de connexion à notre système de suggestions. Veuillez réessayer plus tard ou explorer les offres disponibles.';

  @override
  String get suggestionLoadingTitle => 'Voyons les suggestions';

  @override
  String get suggestionLoadingDescription =>
      'Vos suggestions d\'habitudes optimisées sont personnalisées et couvrent des catégories telles que la santé, la productivité, la pleine conscience, l\'apprentissage, et plus encore.';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterMostFrequent => 'Les plus fréquents';

  @override
  String get filterTopPerformed => 'Meilleurs résultats';

  @override
  String noHabitsInCategory(String month) {
    return 'Aucun habitude dans cette catégorie pour $month';
  }

  @override
  String get noRankedItemsAvailable => 'Aucun élément disponible';

  @override
  String get filterByCategoryLabel => 'Filtrer par catégorie';

  @override
  String get filterByCategoryTitle => 'Filtrer par catégorie';

  @override
  String get allCategoriesLabel => 'Toutes les catégories';

  @override
  String get noHabitsInCategoryMessage =>
      'Aucune habitude trouvée dans cette catégorie';

  @override
  String get clearFilterTooltip => 'Effacer le filtre';

  @override
  String get showAllHabitsButton => 'Afficher toutes les habitudes';

  @override
  String get addProgressTitle => 'Ajouter une progression';

  @override
  String get enterProgressLabel => 'Entrez une valeur';

  @override
  String get enterNumberEmptyError => 'Veuillez entrer une valeur';

  @override
  String get enterNumberInvalidError => 'Entrez un nombre valide';

  @override
  String get habitDeletedSuccess => 'Habitude supprimée avec succès !';

  @override
  String get habitDeleteFailed => 'Échec de la suppression de l’habitude !';

  @override
  String get cannotRecordFutureHabit =>
      'Impossible d’enregistrer une habitude pour une date future.';

  @override
  String get failedToUpdateHabit =>
      'Échec de la mise à jour de l’habitude. Veuillez réessayer.';

  @override
  String get failedToUpdateProgress =>
      'Échec de la mise à jour de la progression. Veuillez réessayer.';

  @override
  String get scopeDialogDefaultTitle => 'Appliquer les modifications à…';

  @override
  String get deleteHabitDialogTitle => 'Supprimer l’habitude ?';

  @override
  String get deleteHabitDialogMessage =>
      'Êtes-vous sûr de vouloir supprimer cette habitude ?';

  @override
  String get scopeOptionOnlyThis => 'Seulement cette habitude';

  @override
  String get scopeOptionThisAndFuture =>
      'Cette habitude et les habitudes futures';

  @override
  String get scopeOptionAllInSeries => 'Toutes les habitudes de cette série';

  @override
  String get themeSelectionTitle => 'Apparence';

  @override
  String get themeModeLight => 'Clair';

  @override
  String get themeModeDark => 'Sombre';

  @override
  String get themeModeSystem => 'Utiliser les paramètres de l\'appareil';

  @override
  String get selectAll => 'Sélectionner tout';

  @override
  String get applySelected => 'Appliquer la sélection';

  @override
  String get habitsApplied => 'Suggestions sélectionnées appliquées';

  @override
  String get habitAdded => 'Habitude ajoutée avec succès';

  @override
  String get habitAddError => 'Échec de l\'ajout de l\'habitude';

  @override
  String get applySuggestion => 'Appliquer la suggestion';

  @override
  String get appliedHabitsSuccessTitle => 'Succès !';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# habitudes appliquées avec succès',
      one: '1 habitude appliquée avec succès',
      zero: 'Aucune habitude appliquée',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'Ces habitudes font désormais partie de votre routine.';

  @override
  String get backToSuggestionsButton => 'Retour aux suggestions';

  @override
  String get goToHomeButton => 'Aller à l’accueil';

  @override
  String get viewDetailsButton => 'Voir les détails';

  @override
  String get appliedHabitsSummaryTitle => 'Habitudes appliquées';

  @override
  String get aiPicksTab => 'Sélections IA';

  @override
  String get habitPlansTab => 'Plans d\'habitudes';

  @override
  String get exploreHabitPlans => 'Parcourir les plans d\'habitudes';

  @override
  String habitPlansError(Object error) {
    return 'Erreur lors du chargement des plans d\'habitudes : $error';
  }

  @override
  String get aboutThisPlan => 'À propos de ce plan';

  @override
  String get includedHabits => 'Habitudes incluses';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# habitudes sélectionnées',
      one: '1 habitude sélectionnée',
      zero: 'Aucune habitude sélectionnée',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'Pas de connexion internet';

  @override
  String get noInternetConnectionDescription =>
      'Veuillez vérifier votre connexion internet et réessayer. Certaines fonctionnalités peuvent ne pas être disponibles hors ligne.';

  @override
  String get retry => 'Réessayer';

  @override
  String get viewOfflineContent => 'Afficher le contenu disponible';

  @override
  String get personalizedSuggestionsWelcome =>
      'Suggestions d\'habitudes personnalisées par IA';

  @override
  String get goalsHint => 'Parlez-moi de vos objectifs…';

  @override
  String get personalityLabel => 'Personnalité';

  @override
  String get availableTimeLabel => 'Heure disponible';

  @override
  String get guidanceLevelLabel => 'Niveau d\'orientation';

  @override
  String get selectPersonalityTitle => 'Sélectionner une personnalité';

  @override
  String get selectAvailableTimeTitle => 'Sélectionner une heure disponible';

  @override
  String get selectGuidanceLevelTitle =>
      'Sélectionner un niveau d\'orientation';

  @override
  String get selectDataSourceTitle => 'Sélectionner une source de données';

  @override
  String get personalityIntroverted => 'Introverti';

  @override
  String get personalityExtroverted => 'Extraverti';

  @override
  String get personalityDisciplined => 'Discipliné';

  @override
  String get personalityCreative => 'Créatif';

  @override
  String get personalityAnalytical => 'Analytique';

  @override
  String get timeMorning => 'Matin';

  @override
  String get timeNoon => 'Midi';

  @override
  String get timeAfternoon => 'Après-midi';

  @override
  String get timeEvening => 'Soir';

  @override
  String get timeFlexible => 'Flexible';

  @override
  String get guidanceSimple => 'Simple';

  @override
  String get guidanceIntermediate => 'Intermédiaire';

  @override
  String get guidanceAdvanced => 'Avancé';

  @override
  String get dataSourcePersonalizationOnly => 'Personnalisation seulement';

  @override
  String get dataSourceHabitsOnly => 'Habitudes seulement';

  @override
  String get dataSourceBoth => 'Les deux';
}
