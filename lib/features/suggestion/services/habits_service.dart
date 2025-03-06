import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/habit.dart';

final habitsServiceProvider = Provider((ref) => HabitsService());

class HabitsService {
  Future<List<Habit>> fetchHabitsForCurrentMonth(
      {required DateTime time}) async {
    // Send request to the mock API after waiting for 1 second
    await Future.delayed(Duration(seconds: 1));
    // Simulate sending API request
    final response = jsonEncode(_fakeApiResponse(time.toUtc()));

    List<dynamic> jsonData = jsonDecode(response);
    return jsonData.map((habitJson) => Habit.fromJson(habitJson)).toList();
  }
}

// Simulated API: Returns a list of habits based on the input time
List<Map<String, dynamic>> _fakeApiResponse(DateTime time) {
  return [
    {
      "id": "habit0",
      "name": "Morning Run",
      "category": {
        "id": "health",
        "label": "Health",
        "iconPath": "assets/icons/health.png"
      },
      "startDate": time.microsecondsSinceEpoch,
      "reminderEnabled": true,
      "trackingType": "complete",
      "repeatFrequency": "daily"
    },
    {
      "id": "habit1",
      "name": "Read a Book",
      "category": {
        "id": "personal_growth",
        "label": "Personal Growth",
        "iconPath": "assets/icons/personal_growth.png"
      },
      "startDate": time.microsecondsSinceEpoch,
      "reminderEnabled": true,
      "trackingType": "progress",
      "repeatFrequency": "daily",
      "quantity": 10,
      "unit": "pages",
      "progress": 2
    },
    {
      "id": "habit2",
      "name": "Meditation",
      "category": {
        "id": "personal_growth",
        "label": "Personal Growth",
        "iconPath": "assets/icons/personal_growth.png"
      },
      "startDate": time.microsecondsSinceEpoch,
      "reminderEnabled": true,
      "trackingType": "complete",
      "repeatFrequency": "daily"
    },
    {
      "id": "habit3",
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
      "quantity": 10,
      "unit": "glasses",
      "progress": 5
    },
    {
      "id": "habit4",
      "name": "Practice Coding",
      "category": {
        "id": "work",
        "label": "Work",
        "iconPath": "assets/icons/work.png"
      },
      "startDate": time.microsecondsSinceEpoch,
      "reminderEnabled": true,
      "trackingType": "complete",
      "repeatFrequency": "daily"
    }
  ];
}
