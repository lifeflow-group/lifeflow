import '../../../data/database/app_database.dart';
import '../../../data/domain/models/habit.dart';

abstract class HomeService {
  Future<List<Habit>> getHabits();
  Future<List<(HabitsTableData, HabitCategoriesTableData)>>
      getHabitsWithCategoriesByDate(DateTime date, String userId);
}
