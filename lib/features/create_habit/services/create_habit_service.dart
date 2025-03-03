import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/habit.dart';

final createHabitServiceProvider = Provider<CreateHabitService>((ref) {
  return CreateHabitService();
});

class CreateHabitService {
  Future<Habit?> saveHabit(Habit habit) async {
    debugPrint('Saving habit: $habit');
    return habit;
  }
}
