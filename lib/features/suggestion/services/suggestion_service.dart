import '../../../data/domain/models/habit_analysis_input.dart';

abstract class SuggestionService {
  Future<List<dynamic>> generateAISuggestions(HabitAnalysisInput input);
}
