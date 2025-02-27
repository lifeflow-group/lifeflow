import '../../../data/models/habit.dart';

abstract class HomeService {
  Future<List<Habit>> getHabits();
  Future<void> updateHabit(Habit habit);
}
