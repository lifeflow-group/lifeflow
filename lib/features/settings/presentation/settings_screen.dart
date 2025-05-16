import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/settings_controller.dart';
import 'widgets/settings_divider.dart';
import 'widgets/settings_item.dart';
import 'widgets/week_day_selector_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double avatarSize = 65.0;
    final settingsState = ref.watch(settingsControllerProvider);
    final weekStartDay = settingsState.whenOrNull(
          data: (data) => data.weekStartDay.display,
        ) ??
        'Monday';

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, bottom: 12, left: 12.0, right: 12.0),
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none, // Allow avatar to overflow card
                children: [
                  // The card starts visually below the center of the avatar
                  Padding(
                    padding: EdgeInsets.only(top: avatarSize / 2),
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Colors.white,
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
                                  'Sign up or log in',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                'You are currently in guest mode',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
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
                        color: Theme.of(context).cardTheme.color,
                        border: Border.all(color: Colors.white, width: 3.5),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Colors.black.withAlpha((0.15 * 255).toInt()),
                              blurRadius: 8,
                              offset: Offset(0, 4)),
                        ],
                      ),
                      child: Center(child: Icon(Icons.person, size: 32)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text('Settings', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                child: Column(
                  children: [
                    SettingsItem(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                      onTap: () {
                        // Handle Notifications tap
                      },
                    ),
                    const SettingsDivider(),
                    SettingsItem(
                      icon: Icons.settings_outlined,
                      title: 'Week starts on',
                      value: weekStartDay,
                      onTap: () async {
                        final weekStart =
                            await showWeekStartDaySelector(context);
                        if (weekStart != null) {
                          await ref
                              .read(settingsControllerProvider.notifier)
                              .setWeekStartDay(weekStart);
                        }
                      },
                    ),
                    const SettingsDivider(),
                    SettingsItem(
                      icon: Icons.translate_outlined,
                      title: 'Change app language',
                      value: 'English',
                      onTap: () {
                        // Handle Change app language tap
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
