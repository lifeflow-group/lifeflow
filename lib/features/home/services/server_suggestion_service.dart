import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/api/api_service.dart';
import '../../../data/domain/models/habit_analysis_input.dart';
import '../../suggestion/services/suggestion_service.dart';

final serverSuggestionServiceProvider = Provider<SuggestionService>((ref) {
  return ServerSuggestionService();
});

class ServerSuggestionService implements SuggestionService {
  @override
  Future<List<dynamic>> generateAISuggestions(HabitAnalysisInput input) async {
    final jsonData = await ApiService.generateAISuggestions(input);
    return jsonData;
  }
}
