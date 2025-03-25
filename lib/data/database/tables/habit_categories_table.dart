import 'package:drift/drift.dart';

class HabitCategoriesTable extends Table {
  TextColumn get id => text()(); // UUID or fixed id for default categories
  TextColumn get label => text()(); // Display name
  TextColumn get iconPath => text()(); // Asset/icon path

  @override
  Set<Column> get primaryKey => {id};
}
