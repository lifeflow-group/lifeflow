import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/domain/models/habit.dart';
import '../services/drift_home_service.dart';
import '../services/home_service.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final homeService = ref.watch(driftHomeServiceProvider);
  return HomeRepository(homeService);
});

class HomeRepository {
  final HomeService _homeService;

  HomeRepository(this._homeService);

  Future<List<Habit>> getHabitsByDate(DateTime date) async {
    // Fetch the list of habits and categories
    final records = await _homeService.getHabitsWithCategoriesByDate(date);

    // Map each (habit, category) => HabitModel
    return records.map((record) {
      final habitDb = record.$1; // Habit (Drift)
      final categoryDb = record.$2; // HabitCategory (Drift)

      return Habit.fromJson({
        ...habitDb.toJson(),
        'category': categoryDb.toJson(),
      });
    }).toList();
  }
}
