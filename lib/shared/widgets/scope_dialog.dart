import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ActionScope {
  onlyThis, // Edit only this day (create HabitException)
  all, // Edit the entire habit & series (create a new series)
  thisAndFollowing // Edit from the current day onward (split the series)
}

Future<ActionScope?> showScopeDialog(BuildContext context, {String? title}) {
  final l10n = AppLocalizations.of(context)!;
  final dialogTitle = title ?? l10n.scopeDialogDefaultTitle;

  return showDialog<ActionScope>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          dialogTitle,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, ActionScope.onlyThis),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text(l10n.scopeOptionOnlyThis,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(context, ActionScope.thisAndFollowing),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text(l10n.scopeOptionThisAndFuture,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, ActionScope.all),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
            child: Text(l10n.scopeOptionAllInSeries,
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      );
    },
  );
}

Future<bool?> confirmDeleteHabitDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.deleteHabitDialogTitle),
      content: Text(l10n.deleteHabitDialogMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(l10n.cancelButton),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(l10n.deleteButton),
        ),
      ],
    ),
  );
}
