import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../data/controllers/habit_controller.dart';
import '../../data/domain/models/habit.dart';
import '../../features/home/controllers/home_controller.dart';
import '../widgets/scope_dialog.dart';
import '../widgets/enter_number_dialog.dart';

Future<bool> handleDeleteHabit(
    BuildContext context, WidgetRef ref, Habit habit) async {
  final deleteController = ref.read(habitControllerProvider);
  final habitSeries =
      await deleteController.getHabitSeries(habit.habitSeriesId);

  if (!context.mounted) return false;

  bool isDeleted = false;

  if (habitSeries == null) {
    final confirmed = await confirmDeleteHabitDialog(context);
    if (confirmed == null || confirmed == false) return false;

    isDeleted = await deleteController.deleteSingleHabit(habit.id);
  } else {
    final actionScope = await showScopeDialog(context, title: 'Delete habit?');
    if (actionScope == null) return false;

    isDeleted = await switch (actionScope) {
      ActionScope.onlyThis =>
        deleteController.handleDeleteOnlyThis(habit, habitSeries),
      ActionScope.all => deleteController.handleDeleteAll(habitSeries),
      ActionScope.thisAndFollowing =>
        deleteController.handleDeleteThisAndFollowing(habit, habitSeries),
    };
  }

  if (isDeleted) {
    ref.invalidate(homeControllerProvider);
  }
  showSnackbar(
      isDeleted ? 'Habit deleted successfully!' : 'Failed to delete habit!');

  return isDeleted;
}

// Function to check if selectedDate is today or in the future
bool isValidDate(DateTime selectedDate) {
  final today = DateTime.now();

  return (selectedDate.isBefore(today) ||
      (selectedDate.year == today.year &&
          selectedDate.month == today.month &&
          selectedDate.day == today.day));
}

// Function to display a Snackbar
void showSnackbar(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 2)),
  );
}

Future<bool> recordHabitCompletion(WidgetRef ref, Habit habit) async {
  final controller = ref.read(habitControllerProvider);
  final selectedDate = ref.read(selectedDateProvider).toLocal();

  // Check if the date is valid
  if (!isValidDate(selectedDate)) {
    showSnackbar("Cannot record habit for a future date.");
    return false;
  }

  final newValue = !(habit.isCompleted ?? false);

  await controller.recordHabit(
      habit: habit,
      selectedDate: selectedDate,
      isCompleted: newValue,
      currentValue: null);

  // Invalidate the controller to reload the UI
  ref.invalidate(homeControllerProvider);
  return true;
}

Future<int?> recordHabitProgress(
    BuildContext context, WidgetRef ref, Habit habit) async {
  final selectedDate = ref.read(selectedDateProvider).toLocal();
  // Check if the date is valid
  if (!isValidDate(selectedDate)) {
    showSnackbar("Cannot record habit for a future date.");
    return null;
  }

  // final added = await showAddProgressDialog(context);
  final added = await showDialog<int?>(
      context: context, builder: (context) => EnterNumberDialog());
  if (added == null) return habit.currentValue;

  final controller = ref.read(habitControllerProvider);
  final newValue = (habit.currentValue ?? 0) + added;

  await controller.recordHabit(
      habit: habit,
      selectedDate: selectedDate,
      currentValue: newValue,
      isCompleted:
          habit.targetValue != null ? newValue >= habit.targetValue! : null);

  ref.invalidate(homeControllerProvider);
  return newValue;
}
