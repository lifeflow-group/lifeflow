import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit_analysis_input.dart';
import '../../suggestion/services/suggestion_service.dart';

final fakeSuggestionServiceProvider = Provider<SuggestionService>((ref) {
  return FakeSuggestionService();
});

class FakeSuggestionService implements SuggestionService {
  @override
  Future<List<dynamic>> generateAISuggestions(HabitAnalysisInput input) async {
    // Simulate a fake response
    return _fakeApiResponse(DateTime.now());
  }

  // Simulate an API response with 5 JSON items
  List<Map<String, dynamic>> _fakeApiResponse(DateTime time) {
    return [
      {
        "title": "Stay Hydrated Regularly",
        "description":
            "Try setting reminders to drink water every 2 hours. You can place a water bottle on your desk as a visual cue.",
        "habitData": {
          "id": "habit-123",
          "name": "Drink Water",
          "category": {
            "id": "health",
            "label": "Health",
            "iconPath": "assets/icons/health.png"
          },
          "repeatFrequency": "daily",
          "startDate": "2024-03-01T00:00:00Z",
          "untilDate": "2024-06-01T00:00:00Z",
          "reminderEnabled": true,
          "trackingType": "complete",
          "targetValue": 8,
          "unit": "cups",
        },
      },
      {
        "title": "Increase Physical Activity",
        "description":
            "Try setting a reminder for a quick walk every 30 minutes. Physical activity boosts your mood and productivity.",
        "habitData": {
          "id": "habit-124",
          "name": "Walk Breaks",
          "category": {
            "id": "fitness",
            "label": "Fitness",
            "iconPath": "assets/icons/fitness.png"
          },
          "repeatFrequency": "daily",
          "startDate": "2024-03-02T00:00:00Z",
          "untilDate": "2024-06-02T00:00:00Z",
          "reminderEnabled": true,
          "trackingType": "complete",
          "targetValue": 5,
          "unit": "minutes",
        },
      },
      {
        "title": "Work on Mental Health",
        "description":
            "Practice mindfulness daily to reduce stress and improve focus. Set aside time each morning for meditation.",
        "habitData": {
          "id": "habit-125",
          "name": "Meditation",
          "category": {
            "id": "personal_growth",
            "label": "Personal Growth",
            "iconPath": "assets/icons/personal_growth.png"
          },
          "repeatFrequency": "daily",
          "startDate": "2024-03-03T00:00:00Z",
          "untilDate": "2024-06-03T00:00:00Z",
          "reminderEnabled": true,
          "trackingType": "complete",
          "targetValue": 15,
          "unit": "minutes",
        },
      },
      {
        "title": "Sleep Better",
        "description":
            "Ensure 7-8 hours of sleep each night. Try setting a bedtime reminder and create a calming nighttime routine.",
        "habitData": {
          "id": "habit-126",
          "name": "Sleep",
          "category": {
            "id": "health",
            "label": "Health",
            "iconPath": "assets/icons/health.png"
          },
          "repeatFrequency": "daily",
          "startDate": "2024-03-04T00:00:00Z",
          "untilDate": "2024-06-04T00:00:00Z",
          "reminderEnabled": true,
          "trackingType": "complete",
          "targetValue": 8,
          "unit": "hours",
        },
      },
      {
        "title": "Read More Books",
        "description":
            "Set aside time to read 20 pages a day. Reading improves knowledge and mental clarity.",
        "habitData": {
          "id": "habit-127",
          "name": "Reading",
          "category": {
            "id": "education",
            "label": "Education",
            "iconPath": "assets/icons/education.png"
          },
          "repeatFrequency": "daily",
          "startDate": "2024-03-05T00:00:00Z",
          "untilDate": "2024-06-05T00:00:00Z",
          "reminderEnabled": true,
          "trackingType": "progress",
          "targetValue": 20,
          "unit": "pages",
        },
      },
    ];
  }
}
