import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_languages.dart';
import '../../../data/domain/models/language.dart';
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
      state = state.copyWith(selectedLanguage: language);
    }
  }

  // Add/remove supported languages (if needed)
  void updateSupportedLanguages(List<Language> languages) {
    state = state.copyWith(supportedLanguages: languages);
  }

  // Reload state from settingsController
  void loadInitialState() {
    final settings = ref.read(settingsControllerProvider);

    settings.maybeWhen(
      data: (data) {
        if (data.language != state.selectedLanguage) {
          state = state.copyWith(selectedLanguage: data.language);
        }
      },
      orElse: () {},
    );
  }
}
