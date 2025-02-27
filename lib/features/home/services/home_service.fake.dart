import 'home_service.dart';
import '../../../data/models/habit.dart';

class FakeHomeService implements HomeService {
  final List<Habit> _habits = [
    Habit((b) => b
      ..id = 'habit0'
      ..name = 'Morning Run'
      ..category = 'Fitness'
      ..startDate = DateTime.now()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..trackingType = TrackingType.complete),
    Habit((b) => b
      ..id = 'habit1'
      ..name = 'Read a Book'
      ..category = 'Education'
      ..startDate = DateTime.now()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..progress = 2
      ..quantity = 10
      ..unit = 'pages'
      ..trackingType = TrackingType.progress),
    Habit((b) => b
      ..id = 'habit2'
      ..name = 'Meditation'
      ..category = 'Wellness'
      ..startDate = DateTime.now()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..trackingType = TrackingType.complete),
    Habit((b) => b
      ..id = 'habit3'
      ..name = 'Drink Water'
      ..category = 'Health'
      ..startDate = DateTime.now()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..progress = 5
      ..quantity = 10
      ..unit = 'glasses'
      ..trackingType = TrackingType.progress),
    Habit((b) => b
      ..id = 'habit4'
      ..name = 'Practice Coding'
      ..category = 'Skill'
      ..startDate = DateTime.now()
      ..repeatFrequency = RepeatFrequency.daily
      ..reminderEnabled = true
      ..trackingType = TrackingType.complete),
  ];

  @override
  Future<List<Habit>> getHabits() async {
    return _habits;
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
    }
  }
}
