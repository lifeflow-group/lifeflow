import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../data/domain/models/app_settings.dart';
import '../../../settings/controllers/settings_controller.dart';
import '../../controllers/home_controller.dart';

class DateSelector extends ConsumerWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final notifier = ref.read(selectedDateProvider.notifier);

    // Get the weekStartDay from settings
    final settingsState = ref.watch(settingsControllerProvider);
    final weekStartDay = settingsState.whenOrNull(
          data: (data) => data.weekStartDay,
        ) ??
        WeekStartDay.monday;

    // Calculate the start of week based on weekStartDay
    final startOfWeek = _calculateStartOfWeek(selectedDate, weekStartDay);

    return Container(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  notifier.updateSelectedDate(
                      selectedDate.subtract(Duration(days: 7)));
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  notifier
                      .updateSelectedDate(selectedDate.add(Duration(days: 7)));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = startOfWeek.add(Duration(days: index));
                final isSelected = date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;

                return GestureDetector(
                  onTap: () => notifier.updateSelectedDate(date),
                  child: Container(
                    width: 45,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat.E().format(date),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                )),
                        SizedBox(height: 5),
                        Text(
                          date.day.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to calculate start of week based on weekStartDay setting
  DateTime _calculateStartOfWeek(DateTime date, WeekStartDay weekStartDay) {
    // weekday in DateTime: 1 = Monday, 2 = Tuesday, ..., 7 = Sunday
    if (weekStartDay == WeekStartDay.monday) {
      // If week starts on Monday (already default in Dart)
      return date.subtract(Duration(days: date.weekday - 1));
    } else {
      // If week starts on Sunday
      return date.weekday == 7
          ? date.subtract(Duration(days: 0)) // Today is Sunday
          : date.subtract(Duration(days: date.weekday));
    }
  }
}
