import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/database/database_provider.dart';

final createHabitServiceProvider = Provider<CreateHabitService>((ref) {
  final repo = ref.read(appDatabaseProvider);
  return CreateHabitService(repo);
});

class CreateHabitService {
  final AppDatabase _database;
  CreateHabitService(this._database);

  Future<void> saveHabit(HabitTableCompanion habit) async {
    if (habit.name.value.isEmpty) {
      throw Exception("Habit name is required");
    }
    await _database.habitDao.insertHabit(habit);
  }
}
