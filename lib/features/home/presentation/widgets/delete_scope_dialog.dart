import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../data/domain/models/habit.dart';
import '../../../habit_detail/presentation/widgets/edit_scope_dialog.dart';
import '../../controllers/habit_delete_controller.dart';
import '../../controllers/home_controller.dart';

Future<bool> handleDeleteHabit(
    BuildContext context, WidgetRef ref, Habit habit) async {
  final deleteController = ref.read(habitDeleteControllerProvider);
  final habitSeries =
      await deleteController.getHabitSeries(habit.habitSeriesId);

  if (!context.mounted) return false;

  bool isDeleted = false;

  if (habitSeries == null) {
    final confirmed = await confirmDeleteHabitDialog(context);
    if (confirmed == null || confirmed == false) return false;

    isDeleted = await deleteController.deleteSingleHabit(habit.id);
  } else {
    final actionScope = await showDeleteScopeDialog(context);
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
  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(isDeleted
          ? 'Habit deleted successfully!'
          : 'Failed to delete habit!')));

  return isDeleted;
}

Future<ActionScope?> showDeleteScopeDialog(BuildContext context) {
  return showDialog<ActionScope>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Delete habit?',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, ActionScope.onlyThis),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text('Delete this habit',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, ActionScope.thisAndFollowing),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text('Delete this and future habits',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, ActionScope.all),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text('Delete all habits in this series',
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      );
    },
  );
}

Future<bool?> confirmDeleteHabitDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete habit?'),
      content: const Text('Are you sure you want to delete this habit?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
