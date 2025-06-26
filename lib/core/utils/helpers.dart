import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/domain/models/app_settings.dart';
import '../../data/domain/models/habit.dart';
import '../../data/domain/models/habit_series.dart';
import '../constants/app_languages.dart';

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  hexString = hexString.replaceFirst('#', '');
  buffer.write(hexString);
  return Color(int.parse(buffer.toString(), radix: 16));
}

// Generates recurring UTC dates for a habit
List<DateTime> generateRecurringDates(
  HabitSeries series, {
  DateTime? startDate,
  int daysAhead = 30,
  Set<DateTime>? excludedDatesUtc,
}) {
  final now = DateTime.now().toUtc();
  final untilDate = series.untilDate ?? now.add(Duration(days: daysAhead));
  List<DateTime> dates = [];

  DateTime current = startDate?.toUtc() ?? series.startDate;
  while (current.isBefore(untilDate)) {
    final normalized = DateTime.utc(current.year, current.month, current.day);
    final isSkipped = excludedDatesUtc?.contains(normalized) ?? false;

    if (!isSkipped) {
      dates.add(current);
    }

    switch (series.repeatFrequency) {
      case RepeatFrequency.daily:
        current = current.add(Duration(days: 1));
        break;
      case RepeatFrequency.weekly:
        current = current.add(Duration(days: 7));
        break;
      case RepeatFrequency.monthly:
        current = DateTime(current.year, current.month + 1, current.day);
        break;
      default:
        break;
    }
  }

  return dates.where((date) => date.isAfter(now)).toList();
}

Expression<bool> isSameDateQuery(
    GeneratedColumn<DateTime> date1, DateTime date2) {
  return date1.year.equals(date2.year) &
      date1.month.equals(date2.month) &
      date1.day.equals(date2.day);
}

String getRepeatFrequencyLabel(
    BuildContext context, RepeatFrequency? frequency) {
  final l10n = AppLocalizations.of(context)!;
  if (frequency == null) return l10n.noRepeatLabel;
  switch (frequency) {
    case RepeatFrequency.daily:
      return l10n.repeatDaily;
    case RepeatFrequency.weekly:
      return l10n.repeatWeekly;
    case RepeatFrequency.monthly:
      return l10n.repeatMonthly;
    default:
      return l10n.noRepeatLabel;
  }
}

// dt is utc
DateTime normalizeToUtcMinute(DateTime dt) =>
    DateTime.utc(dt.year, dt.month, dt.day, dt.hour, dt.minute);

int generateNotificationId(DateTime dateTime,
    {String? habitId, String? seriesId}) {
  final cleanDigits =
      (seriesId ?? habitId)?.replaceAll(RegExp(r'\D'), '') ?? '';
  final habitPart = int.tryParse(cleanDigits.substring(0, 6)) ?? 999999;
  final timePart =
      normalizeToUtcMinute(dateTime.toUtc()).millisecondsSinceEpoch % 1000000;

  final rawId = habitPart * 1000000 + timePart;
  return rawId % 2147483647; // Ensure 32-bit signed int
}

// Helper function to format dates according to user's language preference
String formatDateWithUserLanguage(
    AsyncValue<AppSettings> settingsState, DateTime date, String pattern) {
  // Get language from user settings
  final userLanguage = settingsState.valueOrNull?.language;

  // Get locale code from user language preference or use default
  final dateFormatLocale = userLanguage?.dateFormatLocale ??
      AppLanguages.defaultLanguage.dateFormatLocale;

  // Capitalize the first letter of the formatted date
  final dateString = DateFormat(pattern, dateFormatLocale).format(date);
  return dateString.isNotEmpty
      ? dateString[0].toUpperCase() + dateString.substring(1)
      : dateString;
}
