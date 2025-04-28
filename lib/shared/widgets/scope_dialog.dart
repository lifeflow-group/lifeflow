import 'package:flutter/material.dart';

enum ActionScope {
  onlyThis, // Edit only this day (create HabitException)
  all, // Edit the entire habit & series (create a new series)
  thisAndFollowing // Edit from the current day onward (split the series)
}

Future<ActionScope?> showScopeDialog(BuildContext context,
    {String title = 'Apply changes to...'}) {
  return showDialog<ActionScope>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(title,
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
            child: Text('Only this habit',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, ActionScope.thisAndFollowing),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text('This and future habits',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, ActionScope.all),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text('All habits in this series',
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
