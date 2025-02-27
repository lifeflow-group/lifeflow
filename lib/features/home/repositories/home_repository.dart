import '../../../data/models/habit.dart';
import '../services/home_service.dart';

class HomeRepository {
  final HomeService _homeService;

  HomeRepository(this._homeService);

  Future<List<Habit>> getHabits() {
    return _homeService.getHabits();
  }

  Future<void> updateHabit(Habit habit) {
    return _homeService.updateHabit(habit);
  }
}
