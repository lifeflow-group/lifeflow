import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dao/category_dao.dart';
import 'dao/habit_dao.dart';
import 'tables/habits.dart';
import 'tables/habit_categories.dart';

part 'app_database.g.dart';

@DriftDatabase(
    tables: [HabitTable, HabitCategoryTable], daos: [HabitDao, CategoryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  HabitDao get habitDao => HabitDao(this);

  @override
  CategoryDao get categoryDao => CategoryDao(this);
}

LazyDatabase _openConnection() {
  // Mobile (Android/iOS/macOS)
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lifeflow.sqlite'));
    return NativeDatabase(file);
  });
}
