import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../domain/models/ai_suggestion_request_input.dart';
import '../../../domain/models/suggestion.dart';
import '../api/suggestion_api_service.dart';

final remoteSuggestionRepositoryProvider =
    Provider<RemoteSuggestionRepository>((ref) {
  final suggestionApiService = ref.read(suggestionApiServiceProvider);
  return RemoteSuggestionRepository(suggestionApiService);
});

class RemoteSuggestionRepository {
  final SuggestionApiService _apiService;
  final logger = AppLogger('RemoteSuggestionRepository');

  RemoteSuggestionRepository(this._apiService);

  /// Generate AI suggestions based on user preferences
  Future<List<Suggestion>> generateAISuggestions(
      AISuggestionRequestInput input) async {
    // Get JSON data from API service
    final suggestionsJson = await _apiService.generateAISuggestions(input);

    // Convert from JSON to model
    final suggestions = suggestionsJson
        .map((json) => Suggestion.fromJson(json as Map<String, dynamic>))
        .toList();

    logger.info(
        'Converted ${suggestions.length} AI suggestion JSON objects to models');
    return suggestions;
  }
}
