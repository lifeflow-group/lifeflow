import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/domain/models/app_settings.dart';
import '../../../../src/generated/l10n/app_localizations.dart';
import '../../controllers/settings_controller.dart';

Future<ThemeModeSetting?> showThemeModeSelector(BuildContext context) async {
  return showModalBottomSheet<ThemeModeSetting>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ThemeModeSelector(),
  );
}

class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settingsState = ref.watch(settingsControllerProvider);
    final selectedThemeMode =
        settingsState.valueOrNull?.themeMode ?? ThemeModeSetting.system;

    return Material(
      // color: theme.colorScheme.surface,
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
            Text(l10n.themeSelectionTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            ThemeModeOption(
              title: l10n.themeModeLight,
              icon: Icons.light_mode,
              themeMode: ThemeModeSetting.light,
              isSelected: selectedThemeMode == ThemeModeSetting.light,
              onSelect: (mode) => Navigator.pop(context, mode),
            ),
            ThemeModeOption(
              title: l10n.themeModeDark,
              icon: Icons.dark_mode,
              themeMode: ThemeModeSetting.dark,
              isSelected: selectedThemeMode == ThemeModeSetting.dark,
              onSelect: (mode) => Navigator.pop(context, mode),
            ),
            ThemeModeOption(
              title: l10n.themeModeSystem,
              icon: Icons.settings_suggest,
              themeMode: ThemeModeSetting.system,
              isSelected: selectedThemeMode == ThemeModeSetting.system,
              onSelect: (mode) => Navigator.pop(context, mode),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeModeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final ThemeModeSetting themeMode;
  final bool isSelected;
  final Function(ThemeModeSetting) onSelect;

  const ThemeModeOption({
    super.key,
    required this.title,
    required this.icon,
    required this.themeMode,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title,
          style: theme.textTheme.titleMedium
              ?.copyWith(color: colorScheme.onSurface)),
      trailing:
          isSelected ? Icon(Icons.check, color: colorScheme.primary) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () => onSelect(themeMode),
    );
  }
}
