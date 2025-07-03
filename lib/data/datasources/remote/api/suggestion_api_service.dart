import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../domain/models/ai_suggestion_request_input.dart'; // Thay thế import
import 'api_client.dart';

final suggestionApiServiceProvider = Provider<SuggestionApiService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return SuggestionApiService(apiClient);
});

class SuggestionApiService {
  final ApiClient _client;
  final logger = AppLogger('SuggestionApiService');

  SuggestionApiService(this._client);

  Future<List<dynamic>> generateAISuggestions(
      AISuggestionRequestInput input) async {
    // Call endpoint to generate AI suggestions based on user preferences
    final response =
        await _client.post('/suggestions/analyze', body: input.toJson());

    final List<dynamic> suggestionsJson = response as List<dynamic>;
    logger
        .info('Generated ${suggestionsJson.length} AI suggestions (raw JSON)');

    return suggestionsJson;
  }
}
