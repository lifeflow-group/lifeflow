import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_languages.dart';
import '../../../data/domain/models/language.dart';
import '../../../data/services/analytics/analytics_service.dart';
import 'settings_controller.dart';

// State object for the controller
class LanguageSelectionState {
  final Language selectedLanguage;
  final List<Language> supportedLanguages;

  const LanguageSelectionState({
    required this.selectedLanguage,
    required this.supportedLanguages,
  });

  // Copy with to create a new state object from the current state
  LanguageSelectionState copyWith({
    Language? selectedLanguage,
    List<Language>? supportedLanguages,
  }) {
    return LanguageSelectionState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      supportedLanguages: supportedLanguages ?? this.supportedLanguages,
    );
  }
}

final languageSelectionControllerProvider =
    StateNotifierProvider<LanguageSelectionController, LanguageSelectionState>(
        (ref) {
  return LanguageSelectionController(ref);
});

class LanguageSelectionController
    extends StateNotifier<LanguageSelectionState> {
  final Ref ref;

  LanguageSelectionController(this.ref)
      : super(LanguageSelectionState(
            selectedLanguage: _getInitialLanguage(ref),
            supportedLanguages: AppLanguages.supportedLanguages));

  // Access analytics service
  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);

  // Helper method to get initial language code from settings
  static Language _getInitialLanguage(Ref ref) {
    // Read value from settingsControllerProvider
    final settings = ref.read(settingsControllerProvider);

    // Use value from settings or use default value if settings are not loaded yet
    return settings.maybeWhen(
        data: (data) => data.language,
        orElse: () => AppLanguages.defaultLanguage);
  }

  // Getter for selectedLanguage
  Language get selectedLanguage => state.selectedLanguage;

  // Getter for supportedLanguages
  List<Language> get supportedLanguages => state.supportedLanguages;

  // Temporarily select a language without saving it
  void selectLanguageCode(Language language) {
    if (language != state.selectedLanguage) {
      // Track language selection changed
      _analyticsService.trackLanguageOptionSelected(
        language.languageCode,
        language.languageName,
        state.selectedLanguage.languageCode,
        state.selectedLanguage.languageName,
      );

      state = state.copyWith(selectedLanguage: language);
    } else {
      // Track re-selecting same language
      _analyticsService.trackLanguageOptionReselected(
        language.languageCode,
        language.languageName,
      );
    }
  }

  // Add/remove supported languages (if needed)
  void updateSupportedLanguages(List<Language> languages) {
    _analyticsService.trackSupportedLanguagesUpdated(
      languages.length,
      languages.map((l) => l.languageCode).join(','),
    );

    state = state.copyWith(supportedLanguages: languages);
  }

  // Reload state from settingsController
  void loadInitialState() {
    final settings = ref.read(settingsControllerProvider);

    settings.maybeWhen(
      data: (data) {
        if (data.language != state.selectedLanguage) {
          _analyticsService.trackLanguageSelectionInitialStateLoaded(
            data.language.languageCode,
            data.language.languageName,
            state.supportedLanguages.length,
          );

          state = state.copyWith(selectedLanguage: data.language);
        }
      },
      orElse: () {
        _analyticsService.trackLanguageSelectionDefaultStateUsed(
          AppLanguages.defaultLanguage.languageCode,
          AppLanguages.defaultLanguage.languageName,
        );
      },
    );
  }

  // Track when user confirms their language selection
  void trackLanguageSaved() {
    _analyticsService.trackLanguageSaved(
      state.selectedLanguage.languageCode,
      state.selectedLanguage.languageName,
    );
  }

  // Track when user cancels language selection
  void trackLanguageSelectionCanceled() {
    _analyticsService.trackLanguageSelectionCanceled(
      state.selectedLanguage.languageCode,
      state.selectedLanguage.languageName,
    );
  }

  // Track when all language options are loaded
  void trackLanguageOptionsLoaded() {
    _analyticsService.trackLanguageOptionsLoaded(
      state.supportedLanguages.length,
      state.selectedLanguage.languageCode,
    );
  }
}
