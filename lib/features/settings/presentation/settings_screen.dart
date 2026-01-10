import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_languages.dart';
import '../../../data/domain/models/app_settings.dart';
import '../../../data/domain/models/language.dart';
import '../../../data/services/analytics/analytics_service.dart';
import '../../../src/generated/l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_divider.dart';
import 'widgets/settings_item.dart';
import 'widgets/theme_mode_selector_sheet.dart';
import 'widgets/week_day_selector_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final analyticsService = ref.read(analyticsServiceProvider);
    final double avatarSize = 65.0;
    final settingsState = ref.watch(settingsControllerProvider);
    final weekStartDay = settingsState.whenOrNull(
            data: (data) => data.weekStartDay.getLocalizedDisplay(context)) ??
        WeekStartDay.monday.getLocalizedDisplay(context);

    // Get the current language from settings
    final language = settingsState.whenOrNull(data: (data) => data.language) ??
        AppLanguages.defaultLanguage;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, bottom: 12, left: 12.0, right: 12.0),
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  // The card starts visually below the center of the avatar
                  Padding(
                    padding: EdgeInsets.only(top: avatarSize / 2),
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: theme.brightness == Brightness.dark
                            ? theme.cardTheme.color
                            : theme.colorScheme.onPrimary,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: avatarSize / 2 + 8.0, bottom: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // TODO: Implement handle sign up or login button tap
                                },
                                style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size(0, 0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                ),
                                child: Text(
                                  l10n.signUpOrLogin,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                l10n.guestMode,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Avatar is positioned from the top of the Stack area
                  Positioned(
                    top: 0,
                    child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.brightness == Brightness.dark
                            ? theme.cardTheme.color
                            : theme.colorScheme.onPrimary,
                        border: Border.all(
                            color: theme.scaffoldBackgroundColor, width: 3.5),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Colors.black.withAlpha((0.15 * 255).toInt()),
                              blurRadius: 2,
                              offset: const Offset(0, 4)),
                        ],
                      ),
                      child: const Center(child: Icon(Icons.person, size: 32)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(l10n.settings, style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                color: theme.brightness == Brightness.dark
                    ? theme.cardTheme.color
                    : theme.colorScheme.onPrimary,
                child: Column(
                  children: [
                    SettingsItem(
                      icon: Icons.settings_outlined,
                      title: l10n.weekStartsOnTitle,
                      value: weekStartDay,
                      onTap: () async {
                        // UI-specific interaction tracking
                        analyticsService
                            .trackWeekStartSettingTapped(weekStartDay);

                        final weekStart =
                            await showWeekStartDaySelector(context);

                        if (weekStart != null) {
                          // Business logic update is tracked in controller
                          await ref
                              .read(settingsControllerProvider.notifier)
                              .setWeekStartDay(weekStart);
                        } else {
                          // Track setting canceled
                          analyticsService
                              .trackWeekStartSelectionCanceled(weekStartDay);
                        }
                      },
                    ),
                    const SettingsDivider(),
                    SettingsItem(
                      icon: Icons.translate_outlined,
                      title: l10n.changeAppLanguage,
                      value: language.languageName,
                      onTap: () async {
                        // Track language setting tap
                        analyticsService.trackLanguageSettingTapped(
                            language.languageCode, language.languageName);

                        final selectedLanguage =
                            await context.pushNamed('language-selection');

                        if (selectedLanguage != null) {
                          final newLanguage = selectedLanguage as Language;

                          // Business logic update is tracked in controller
                          await ref
                              .read(settingsControllerProvider.notifier)
                              .setLanguage(newLanguage);
                        } else {
                          // Track language selection canceled
                          analyticsService.trackLanguageSelectionCanceled(
                              language.languageCode, language.languageName);
                        }
                      },
                    ),
                    const SettingsDivider(),
                    SettingsItem(
                      icon: Icons.brightness_medium,
                      title: l10n.themeSelectionTitle,
                      value: settingsState.whenOrNull(
                              data: (data) => data.themeMode
                                  .getLocalizedDisplay(context)) ??
                          ThemeModeSetting.system.getLocalizedDisplay(context),
                      onTap: () async {
                        // Track theme mode setting tap
                        analyticsService.logEvent('theme_mode_setting_tapped', {
                          'current_theme_mode': settingsState.whenOrNull(
                                data: (data) => data.themeMode.toString(),
                              ) ??
                              ThemeModeSetting.system.toString(),
                        });

                        final selectedThemeMode =
                            await showThemeModeSelector(context);

                        if (selectedThemeMode != null) {
                          // Business logic update is tracked in controller
                          await ref
                              .read(settingsControllerProvider.notifier)
                              .setThemeMode(selectedThemeMode);
                        } else {
                          // Track theme mode selection canceled
                          analyticsService
                              .logEvent('theme_mode_selection_canceled', {
                            'current_theme_mode': settingsState.whenOrNull(
                                  data: (data) => data.themeMode.toString(),
                                ) ??
                                ThemeModeSetting.system.toString()
                          });
                        }
                      },
                    ),
                    const SettingsDivider(),
                    SettingsItem(
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.termsOfUse,
                      onTap: () {
                        // Track terms of use tapped
                        analyticsService.trackTermsOfUseTapped();

                        context.pushNamed('terms-of-use');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
