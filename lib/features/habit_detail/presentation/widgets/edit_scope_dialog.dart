import 'package:flutter/material.dart';

enum ActionScope {
  onlyThis, // Edit only this day (create HabitException)
  all, // Edit the entire habit & series (create a new series)
  thisAndFollowing // Edit from the current day onward (split the series)
}

// Function to show a dialog for selecting the edit scope
Future<ActionScope?> showEditScopeDialog(BuildContext context) {
  return showDialog<ActionScope>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("Apply changes to..."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Only this instance"),
            onTap: () => Navigator.pop(ctx, ActionScope.onlyThis),
          ),
          ListTile(
            title: Text("This and all following"),
            onTap: () => Navigator.pop(ctx, ActionScope.thisAndFollowing),
          ),
          ListTile(
            title: Text("All instances"),
            onTap: () => Navigator.pop(ctx, ActionScope.all),
          ),
        ],
      ),
    ),
  );
}
