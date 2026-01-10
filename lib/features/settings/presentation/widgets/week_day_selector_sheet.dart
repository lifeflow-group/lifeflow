import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/domain/models/app_settings.dart';
import '../../../../src/generated/l10n/app_localizations.dart';
import '../../controllers/settings_controller.dart';

Future<WeekStartDay?> showWeekStartDaySelector(BuildContext context) async {
  return showModalBottomSheet<WeekStartDay>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const WeekDaySelector(),
  );
}

class WeekDaySelector extends ConsumerWidget {
  const WeekDaySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settingsState = ref.watch(settingsControllerProvider);
    final selectedDay =
        settingsState.valueOrNull?.weekStartDay ?? WeekStartDay.monday;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface
                      .withAlpha((0.2 * 255).toInt()),
                  borderRadius: BorderRadius.circular(2)),
              margin: const EdgeInsets.only(bottom: 12),
            ),
            Text(l10n.weekStartsOnTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            WeekDayOption(
              title: l10n.mondayLabel,
              day: WeekStartDay.monday,
              isSelected: selectedDay == WeekStartDay.monday,
              onSelect: (day) => Navigator.pop(context, day),
            ),
            WeekDayOption(
              title: l10n.sundayLabel,
              day: WeekStartDay.sunday,
              isSelected: selectedDay == WeekStartDay.sunday,
              onSelect: (day) => Navigator.pop(context, day),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekDayOption extends StatelessWidget {
  final String title;
  final WeekStartDay day;
  final bool isSelected;
  final Function(WeekStartDay) onSelect;

  const WeekDayOption({
    super.key,
    required this.title,
    required this.day,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      title: Text(title,
          style: theme.textTheme.titleMedium
              ?.copyWith(color: colorScheme.onSurface)),
      trailing:
          isSelected ? Icon(Icons.check, color: colorScheme.primary) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () => onSelect(day),
    );
  }
}
