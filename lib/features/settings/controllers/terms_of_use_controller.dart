import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/analytics_service.dart';

/// Provider for managing terms of use content
final termsOfUseControllerProvider =
    StateNotifierProvider<TermsOfUseController, AsyncValue<String>>((ref) {
  return TermsOfUseController(ref);
});

class TermsOfUseController extends StateNotifier<AsyncValue<String>> {
  final Ref _ref;

  TermsOfUseController(this._ref) : super(const AsyncValue.loading());

  /// Get analytics service
  AnalyticsService get _analyticsService => _ref.read(analyticsServiceProvider);

  /// Load terms of use content from assets
  Future<void> loadTerms(BuildContext context, {String language = 'en'}) async {
    if (state is! AsyncLoading) {
      // If already loaded, no need to reload
      _analyticsService.trackTermsOfUseAlreadyLoaded(language);
      return;
    }

    try {
      state = const AsyncValue.loading();
      _analyticsService.trackTermsOfUseLoadingStarted(language);

      // Load content from asset
      final content = await DefaultAssetBundle.of(context)
          .loadString('assets/terms/terms_$language.md');

      // Track successful terms loading with metrics
      _analyticsService.trackTermsOfUseLoadedSuccessfully(
          language, content.length, _countParagraphs(content));

      state = AsyncValue.data(content);
    } catch (e) {
      // Track error in loading terms
      _analyticsService.trackTermsOfUseLoadingError(
          language, e.toString(), e.runtimeType.toString());

      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Helper to count paragraphs in markdown content
  int _countParagraphs(String content) {
    // Simple method to estimate paragraphs by counting double line breaks
    return '\n\n'.allMatches(content).length + 1;
  }
}
