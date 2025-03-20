import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/data/domain/models/habit.dart';

import '../../../data/database/app_database.dart';
import '../../../data/database/database_provider.dart';
import 'home_service.dart';

final driftHomeServiceProvider = Provider<HomeService>((ref) {
  final repo = ref.read(appDatabaseProvider);
  return DriftHomeService(repo);
});

class DriftHomeService implements HomeService {
  final AppDatabase _database;

  DriftHomeService(this._database);

  @override
  Future<List<(HabitTableData, HabitCategoryTableData)>>
      getHabitsWithCategoriesByDate(DateTime date) async {
    final records =
        await _database.habitDao.getHabitsWithCategoriesByDate(date);
    return records;
  }

  @override
  Future<List<Habit>> getHabits() {
    throw UnimplementedError();
  }
}
