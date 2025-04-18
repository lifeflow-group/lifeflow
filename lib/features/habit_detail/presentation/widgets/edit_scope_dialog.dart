import 'package:flutter/material.dart';

enum EditScope {
  onlyThis, // Edit only this day (create HabitException)
  all, // Edit the entire habit & series (create a new series)
  thisAndFollowing // Edit from the current day onward (split the series)
}

// Function to show a dialog for selecting the edit scope
Future<EditScope?> showEditScopeDialog(BuildContext context) {
  return showDialog<EditScope>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("Apply changes to..."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Only this instance"),
            onTap: () => Navigator.pop(ctx, EditScope.onlyThis),
          ),
          ListTile(
            title: Text("This and all following"),
            onTap: () => Navigator.pop(ctx, EditScope.thisAndFollowing),
          ),
          ListTile(
            title: Text("All instances"),
            onTap: () => Navigator.pop(ctx, EditScope.all),
          ),
        ],
      ),
    ),
  );
}
