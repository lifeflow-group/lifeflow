import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for managing terms of use content
final termsOfUseControllerProvider =
    StateNotifierProvider<TermsOfUseController, AsyncValue<String>>((ref) {
  return TermsOfUseController();
});

class TermsOfUseController extends StateNotifier<AsyncValue<String>> {
  TermsOfUseController() : super(const AsyncValue.loading());

  /// Load terms of use content from assets
  Future<void> loadTerms(BuildContext context, {String language = 'en'}) async {
    if (state is! AsyncLoading) {
      // If already loaded, no need to reload
      return;
    }

    try {
      state = const AsyncValue.loading();

      // Load content from asset
      final content = await DefaultAssetBundle.of(context)
          .loadString('assets/terms/terms_$language.md');

      state = AsyncValue.data(content);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
