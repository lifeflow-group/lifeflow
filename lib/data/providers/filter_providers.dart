import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/category.dart';

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>(
        (ref) => SelectedDateNotifier());

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier([DateTime? initialDate])
      : super(initialDate ?? DateTime.now());

  void updateSelectedDate(DateTime newDate) {
    state = newDate;
  }
}

final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategoryNotifier, Category?>(
        (ref) => SelectedCategoryNotifier());

class SelectedCategoryNotifier extends StateNotifier<Category?> {
  SelectedCategoryNotifier() : super(null);

  void updateSelectedCategory(Category? category) {
    state = category;
  }

  void clearCategory() {
    state = null;
  }
}
