import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsData = ref.watch(settingProvider);

    return SafeArea(
      child: Scaffold(
        body: Center(child: Text(settingsData)),
      ),
    );
  }
}
