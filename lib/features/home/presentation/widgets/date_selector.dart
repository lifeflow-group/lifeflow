import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/domain/models/app_settings.dart';
import '../../../settings/controllers/settings_controller.dart';
import '../../controllers/home_controller.dart';

class DateSelector extends ConsumerStatefulWidget {
  const DateSelector({super.key});

  @override
  ConsumerState<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends ConsumerState<DateSelector> {
  late PageController _pageController;
  final int _initialPage = 500;
  late DateTime _baseDate;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    _baseDate = DateTime.now();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateWeek(bool isNext) {
    if (isNext) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider);
    final notifier = ref.read(selectedDateProvider.notifier);
    final now = DateTime.now();

    // Get the weekStartDay from settings
    final settingsState = ref.watch(settingsControllerProvider);
    final weekStartDay =
        settingsState.whenOrNull(data: (data) => data.weekStartDay) ??
            WeekStartDay.monday;

    return Container(
      color: theme.primaryColor.withAlpha(50),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 100,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: theme.colorScheme.onSurface),
                    onPressed: () => _navigateWeek(false),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      _goToWeekOf(pickedDate);
                    }
                  },
                  child: Text(
                    formatDateWithUserLanguage(ref, selectedDate, 'MMMM yyyy'),
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => _goToWeekOf(now),
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.transparent),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: WidgetStateProperty.all(Size.zero),
                            visualDensity: VisualDensity.compact,
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              side: BorderSide(
                                  color: theme.colorScheme.onSurface, width: 1),
                            ))),
                        child: Text(now.day.toString(),
                            style: theme.textTheme.titleSmall
                                ?.copyWith(color: theme.colorScheme.onSurface)),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward,
                            color: theme.colorScheme.onSurface),
                        onPressed: () => _navigateWeek(true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {});

                final weekOffset = page - _initialPage;
                final baseWeekStart =
                    _calculateStartOfWeek(_baseDate, weekStartDay);
                final newWeekStart =
                    baseWeekStart.add(Duration(days: weekOffset * 7));
                final newWeekEnd = newWeekStart.add(Duration(days: 6));

                // If the selected date is not in the new week, update it
                if (selectedDate.isBefore(newWeekStart) ||
                    selectedDate.isAfter(newWeekEnd)) {
                  notifier.updateSelectedDate(newWeekStart);
                }
              },
              itemBuilder: (context, index) {
                final weekOffset = index - _initialPage;
                final baseWeekStart =
                    _calculateStartOfWeek(_baseDate, weekStartDay);
                final weekStart =
                    baseWeekStart.add(Duration(days: weekOffset * 7));

                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 12.0, left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(7, (index) {
                      final date = weekStart.add(Duration(days: index));
                      final isSelected = date.year == selectedDate.year &&
                          date.month == selectedDate.month &&
                          date.day == selectedDate.day;

                      final isToday = date.year == now.year &&
                          date.month == now.month &&
                          date.day == now.day;

                      return GestureDetector(
                        onTap: () => notifier.updateSelectedDate(date),
                        child: Container(
                          width: 45,
                          padding: const EdgeInsets.only(top: 10, bottom: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.primaryColor
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                formatDateWithUserLanguage(ref, date, 'E'),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isSelected
                                      ? theme.colorScheme.onPrimary
                                      : theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 1),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: isToday
                                    ? theme.primaryColor.withAlpha(170)
                                    : Colors.transparent,
                                child: Text(
                                  date.day.toString(),
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected || isToday
                                        ? theme.colorScheme.onPrimary
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
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
          ? date // Today is Sunday
          : date.subtract(Duration(days: date.weekday));
    }
  }

  Future<void> _goToWeekOf(DateTime date) async {
    final notifier = ref.read(selectedDateProvider.notifier);

    final weekStartDay =
        ref.read(settingsControllerProvider).valueOrNull?.weekStartDay ??
            WeekStartDay.monday;

    final targetWeekStart = _calculateStartOfWeek(date, weekStartDay);
    final baseWeekStart = _calculateStartOfWeek(_baseDate, weekStartDay);

    final weekDiff = targetWeekStart.difference(baseWeekStart).inDays ~/ 7;
    final targetPage = _initialPage + weekDiff;

    await _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    notifier.updateSelectedDate(date);
  }
}
