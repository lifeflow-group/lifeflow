import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeflow/data/domain/models/habit.dart';

import '../../../data/database/app_database.dart';
import '../../../data/database/database_provider.dart';
import 'home_service.dart';

// DriftHomeService will now receive guestId from guestIdProvider
final driftHomeServiceProvider = Provider<DriftHomeService>((ref) {
  final repo = ref.read(appDatabaseProvider);
  return DriftHomeService(repo);
});

class DriftHomeService implements HomeService {
  DriftHomeService(this._database);
  final AppDatabase _database;

  @override
  Future<List<(HabitsTableData, HabitCategoriesTableData)>>
      getHabitsWithCategoriesByDate(DateTime date, String userId) async {
    final records =
        await _database.habitDao.getHabitsWithCategoriesByDate(date, userId);
    return records;
  }

  @override
  Future<List<Habit>> getHabits() {
    throw UnimplementedError();
  }
}
