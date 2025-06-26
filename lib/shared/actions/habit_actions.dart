import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../data/controllers/habit_controller.dart';
import '../../data/domain/models/habit.dart';
import '../../data/services/analytics/analytics_service.dart';
import '../widgets/scope_dialog.dart';
import '../widgets/enter_number_dialog.dart';

Future<bool> handleDeleteHabit(
    BuildContext context, WidgetRef ref, Habit habit) async {
  // Get analytics service reference
  final analyticsService = ref.read(analyticsServiceProvider);

  // Track delete UI action
  analyticsService.trackHabitDeleteUIAction(
    habit.id,
    habit.name,
    habit.category.name,
    habit.trackingType.toString(),
  );

  final deleteController = ref.read(habitControllerProvider);
  final habitSeries = await deleteController.getHabitSeries(habit.series?.id);

  if (!context.mounted) return false;

  bool isDeleted = false;

  if (habitSeries == null) {
    // Track confirm dialog shown
    analyticsService.trackHabitDeleteConfirmDialog(habit.id, 'single');

    final confirmed = await confirmDeleteHabitDialog(context);
    if (confirmed == null || confirmed == false) {
      // Track dialog dismissed
      analyticsService.trackHabitDeleteCanceled(
          habit.id, 'confirmation_dialog');
      return false;
    }

    isDeleted = await deleteController.deleteSingleHabit(habit.id, habit.date);
  } else {
    // Track scope dialog shown
    analyticsService.trackHabitDeleteScopeDialog(habit.id, habitSeries.id);

    final actionScope = await showScopeDialog(context, title: 'Delete habit?');
    if (actionScope == null) {
      // Track dialog dismissed
      analyticsService.trackHabitDeleteCanceled(habit.id, 'scope_dialog');
      return false;
    }

    // Track selected scope
    analyticsService.trackHabitDeleteScopeSelected(
      habit.id,
      habitSeries.id,
      actionScope.toString().split('.').last,
    );

    isDeleted = await switch (actionScope) {
      ActionScope.onlyThis =>
        deleteController.handleDeleteOnlyThis(habit, habitSeries),
      ActionScope.all => deleteController.handleDeleteAll(habitSeries),
      ActionScope.thisAndFollowing =>
        deleteController.handleDeleteThisAndFollowing(habit, habitSeries),
    };
  }

  // Track final result
  analyticsService.trackHabitDeleteResult(
    habit.id,
    isDeleted,
    habitSeries != null,
  );

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
  // Get analytics service reference
  final analyticsService = ref.read(analyticsServiceProvider);

  // Track completion toggle UI action
  analyticsService.trackHabitCompletionToggleAction(
    habit.id,
    habit.name,
    (habit.isCompleted ?? false) ? 'completed' : 'incomplete',
    habit.date.toIso8601String().split('T')[0],
  );

  final controller = ref.read(habitControllerProvider);
  final selectedDate = habit.date.toLocal();

  // Check if the date is valid
  if (!isValidDate(selectedDate)) {
    // Track invalid date
    analyticsService.trackHabitCompletionInvalidDate(
      habit.id,
      selectedDate.toIso8601String().split('T')[0],
      'future_date',
    );

    showSnackbar("Cannot record habit for a future date.");
    return false;
  }

  final newValue = !(habit.isCompleted ?? false);

  try {
    await controller.recordHabit(
        habit: habit, isCompleted: newValue, currentValue: null);

    // Track successful UI completion
    analyticsService.trackHabitCompletionToggleSuccess(
      habit.id,
      habit.name,
      newValue ? 'completed' : 'incomplete',
      selectedDate.toIso8601String().split('T')[0],
    );

    return true;
  } catch (e) {
    // Track error in UI layer
    analyticsService.trackHabitCompletionToggleError(
      habit.id,
      habit.name,
      e.toString(),
    );

    showSnackbar("Failed to update habit. Please try again.");
    return false;
  }
}

Future<int?> recordHabitProgress(
    BuildContext context, WidgetRef ref, Habit habit) async {
  // Get analytics service reference
  final analyticsService = ref.read(analyticsServiceProvider);

  // Track progress recording UI action
  analyticsService.trackHabitProgressRecordAction(
    habit.id,
    habit.name,
    habit.currentValue?.toString() ?? '0',
    habit.targetValue?.toString() ?? 'null',
  );

  final selectedDate = habit.date.toLocal();
  // Check if the date is valid
  if (!isValidDate(selectedDate)) {
    // Track invalid date
    analyticsService.trackHabitProgressInvalidDate(
      habit.id,
      selectedDate.toIso8601String().split('T')[0],
      'future_date',
    );

    showSnackbar("Cannot record habit for a future date.");
    return null;
  }

  // Track dialog opened
  analyticsService.trackHabitProgressDialogOpened(
    habit.id,
    habit.name,
    habit.currentValue?.toString() ?? '0',
  );

  final added = await showDialog<int?>(
      context: context, builder: (context) => EnterNumberDialog());

  if (added == null) {
    // Track dialog dismissed without value
    analyticsService.trackHabitProgressDialogCanceled(habit.id, habit.name);
    return habit.currentValue;
  }

  // Track value entered
  analyticsService.trackHabitProgressValueEntered(
    habit.id,
    habit.name,
    added,
  );

  final controller = ref.read(habitControllerProvider);
  final newValue = (habit.currentValue ?? 0) + added;

  try {
    await controller.recordHabit(
        habit: habit,
        currentValue: newValue,
        isCompleted:
            habit.targetValue != null ? newValue >= habit.targetValue! : null);

    // Log successful UI progress update
    analyticsService.trackHabitProgressRecordSuccess(
      habit.id,
      habit.name,
      habit.currentValue?.toString() ?? '0',
      newValue.toString(),
      habit.targetValue?.toString() ?? 'null',
      habit.targetValue != null && newValue >= habit.targetValue!,
    );

    return newValue;
  } catch (e) {
    // Log error in UI layer
    analyticsService.trackHabitProgressRecordError(
      habit.id,
      habit.name,
      e.toString(),
    );

    showSnackbar("Failed to update progress. Please try again.");
    return habit.currentValue;
  }
}
