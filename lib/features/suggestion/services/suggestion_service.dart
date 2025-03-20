import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../../../data/domain/models/habit.dart';
import '../../../data/domain/models/performance_metric.dart';
import '../../../data/domain/models/suggestion.dart';

final suggestionServiceProvider = Provider<SuggestionService>((ref) {
  return SuggestionService();
});

class SuggestionService {
  // Send Habit + PerformanceMetric data to API and receive a list of suggestions
  Future<List<Suggestion>> generateAISuggestions(
      List<Habit> habits, List<PerformanceMetric> metrics) async {
    final habitData = habits.map((habit) => habit.toJson()).toList();
    final metricData = metrics.map((metric) => metric.toJson()).toList();

    // Create request body
    final Map<String, dynamic> requestBody = {
      "habits": habitData,
      "performanceMetrics": metricData,
    };
    debugPrint(
        'requestBody: habits: ${requestBody['habits'].length}, performanceMetrics: ${requestBody['performanceMetrics'].length}');

    // Send request to the mock API after waiting for 1 second
    await Future.delayed(Duration(seconds: 1));

    // Convert JSON response to a list of Suggestion
    final jsonData = _fakeApiResponse(DateTime.now().toUtc());
    final List<Suggestion> suggestions =
        jsonData.map((data) => Suggestion.fromJson(data)).toList();

    return suggestions;
  }
}

List<Map<String, dynamic>> _fakeApiResponse(DateTime time) {
  return [
    {
      "icon": "🎯",
      "title":
          "You usually run 3 days a week. Try increasing to 4 days to improve your fitness.",
      "description":
          "Research shows that increasing the frequency of running can improve endurance and help the body better adapt to physical activity.",
      "habit": {
        "id": "habit1",
        "name": "Evening Run",
        "category": {
          "id": "fitness",
          "label": "Fitness",
          "iconPath": "assets/icons/fitness.png"
        },
        "startDate": time.microsecondsSinceEpoch,
        "reminderEnabled": true,
        "trackingType": "progress",
        "repeatFrequency": "weekly",
        "quantity": 4,
        "unit": "sessions",
        "progress": 0
      }
    },
    {
      "icon": "🔥",
      "title":
          "You enjoy relaxing activities. How about adding 5 minutes of meditation every morning?",
      "description":
          "Morning meditation helps reduce stress, increase focus, and create a positive mindset for the day.",
      "habit": {
        "id": "habit2",
        "name": "Morning Meditation",
        "category": {
          "id": "spiritual",
          "label": "Spiritual",
          "iconPath": "assets/icons/spiritual.png"
        },
        "startDate": time.microsecondsSinceEpoch,
        "reminderEnabled": true,
        "trackingType": "progress",
        "repeatFrequency": "daily",
        "quantity": 5,
        "unit": "minutes",
        "progress": 0
      }
    },
    {
      "icon": "🚀",
      "title":
          "Your training is inconsistent. Set a fixed schedule to maintain motivation.",
      "description":
          "Planning your workouts helps form sustainable habits, reduces the risk of quitting, and maintains long-term motivation.",
      "habit": {
        "id": "habit3",
        "name": "Workout Routine",
        "category": {
          "id": "fitness",
          "label": "Fitness",
          "iconPath": "assets/icons/fitness.png"
        },
        "startDate": time.microsecondsSinceEpoch,
        "reminderEnabled": true,
        "trackingType": "complete",
        "repeatFrequency": "weekly",
        // "customRepeatDays": ["Monday", "Wednesday", "Friday"]
      }
    },
    {
      "icon": "🍏",
      "title":
          "You don't drink enough water daily. Try drinking 8 glasses of water each day.",
      "description":
          "Staying hydrated helps your body function better, improves skin, and supports digestion.",
      "habit": {
        "id": "habit4",
        "name": "Drink Water",
        "category": {
          "id": "health",
          "label": "Health",
          "iconPath": "assets/icons/health.png"
        },
        "startDate": time.microsecondsSinceEpoch,
        "reminderEnabled": true,
        "trackingType": "progress",
        "repeatFrequency": "daily",
        "quantity": 8,
        "unit": "glasses",
        "progress": 0,
      }
    },
    {
      "icon": "🌙",
      "title":
          "You don't get enough sleep. Set a fixed bedtime to improve your health.",
      "description":
          "A sufficient sleep of 7-8 hours helps you stay alert, enhances memory, and boosts work performance.",
      "habit": {
        "id": "habit5",
        "name": "Fixed Bedtime",
        "category": {
          "id": "wellness",
          "label": "Wellness",
          "iconPath": "assets/icons/health.png"
        },
        "startDate": time
            .toLocal()
            .copyWith(hour: 22, minute: 30)
            .toUtc()
            .microsecondsSinceEpoch,
        "reminderEnabled": true,
        "trackingType": "complete",
        "repeatFrequency": "daily",
      }
    }
  ];
}
