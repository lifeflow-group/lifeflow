import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/services/analytics/analytics_service.dart';
import '../../../../src/generated/l10n/app_localizations.dart';
import '../../../settings/controllers/settings_controller.dart';

class MonthPicker extends ConsumerStatefulWidget {
  // Change to ConsumerStatefulWidget
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const MonthPicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  ConsumerState<MonthPicker> createState() =>
      _MonthPickerState(); // Change to ConsumerState
}

class _MonthPickerState extends ConsumerState<MonthPicker> {
  // Change to ConsumerState
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;

    // Log picker opened
    Future.microtask(() {
      final analyticsService = ref.read(analyticsServiceProvider);
      final settingsState = ref.watch(settingsControllerProvider);
      analyticsService.trackMonthPickerDialogOpened(
          formatDateWithUserLanguage(
              settingsState, widget.initialDate, 'yyyy-MM'),
          formatDateWithUserLanguage(
              settingsState, widget.firstDate, 'yyyy-MM'),
          formatDateWithUserLanguage(
              settingsState, widget.lastDate, 'yyyy-MM'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final analyticsService = ref.read(analyticsServiceProvider);
    final currentYear = selectedDate.year;
    final currentMonth = selectedDate.month;
    final settingsState = ref.watch(settingsControllerProvider);

    return AlertDialog(
      title: Center(
          child:
              Text(l10n.selectMonthTitle, style: theme.textTheme.titleMedium)),
      content: SizedBox(
        width: 300,
        height: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Year display and navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () {
                    final newDate = DateTime(currentYear - 1, currentMonth, 1);
                    if (newDate.isAfter(widget.firstDate) ||
                        isSameYearMonth(newDate, widget.firstDate)) {
                      // Log year changed
                      analyticsService.trackMonthPickerPreviousYear(
                          currentYear, currentYear - 1);

                      setState(() => selectedDate = newDate);
                    }
                  },
                ),
                Text(
                  currentYear.toString(),
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    final newDate = DateTime(currentYear + 1, currentMonth, 1);
                    if (newDate.isBefore(widget.lastDate) ||
                        isSameYearMonth(newDate, widget.lastDate)) {
                      // Log year changed
                      analyticsService.trackMonthPickerNextYear(
                          currentYear, currentYear + 1);

                      setState(() => selectedDate = newDate);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Month grid
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final month = index + 1;
                  final monthDate = DateTime(currentYear, month, 1);
                  final isSelected = month == currentMonth;
                  final isDisabled = isMonthDisabled(monthDate);

                  return InkWell(
                    onTap: isDisabled
                        ? null
                        : () {
                            // Log month selection
                            if (month != currentMonth) {
                              analyticsService.trackMonthPickerMonthSelected(
                                  formatDateWithUserLanguage(
                                      settingsState, selectedDate, 'yyyy-MM'),
                                  formatDateWithUserLanguage(
                                      settingsState,
                                      DateTime(currentYear, month, 1),
                                      'yyyy-MM'));
                            }

                            setState(() =>
                                selectedDate = DateTime(currentYear, month, 1));
                          },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colorScheme.primary : null,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? null
                            : Border.all(color: theme.dividerColor),
                      ),
                      child: Center(
                        child: Text(
                          formatDateWithUserLanguage(settingsState,
                              DateTime(currentYear, month), 'MMM'),
                          style: TextStyle(
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : isDisabled
                                    ? theme.disabledColor
                                    : theme.colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Log cancel button pressed
            analyticsService.trackMonthPickerCancelled(
                formatDateWithUserLanguage(
                    settingsState, selectedDate, 'yyyy-MM'),
                formatDateWithUserLanguage(
                    settingsState, widget.initialDate, 'yyyy-MM'));

            context.pop();
          },
          child: Text(l10n.cancelButton),
        ),
        TextButton(
          onPressed: () {
            // Log confirm button pressed
            analyticsService.trackMonthPickerConfirmed(
                formatDateWithUserLanguage(
                    settingsState, selectedDate, 'yyyy-MM'),
                formatDateWithUserLanguage(
                    settingsState, widget.initialDate, 'yyyy-MM'),
                selectedDate.toString() != widget.initialDate.toString());

            context.pop(selectedDate);
          },
          child: Text(l10n.selectButton),
        ),
      ],
    );
  }

  bool isMonthDisabled(DateTime date) {
    final firstYear = widget.firstDate.year;
    final firstMonth = widget.firstDate.month;
    final lastYear = widget.lastDate.year;
    final lastMonth = widget.lastDate.month;

    // Check if date is before firstDate or after lastDate
    if (date.year < firstYear ||
        (date.year == firstYear && date.month < firstMonth)) {
      return true;
    }
    if (date.year > lastYear ||
        (date.year == lastYear && date.month > lastMonth)) {
      return true;
    }
    return false;
  }

  bool isSameYearMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
}

// Helper function to show the month picker dialog
Future<DateTime?> showMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  firstDate ??= DateTime(initialDate.year - 5, 1);
  lastDate ??= DateTime(initialDate.year + 5, 12, 31);

  return showDialog<DateTime>(
      context: context,
      builder: (context) => MonthPicker(
            initialDate: initialDate,
            firstDate: firstDate!,
            lastDate: lastDate!,
          ));
}
