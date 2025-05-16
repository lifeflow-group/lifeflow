import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
        thickness: 0.8,
        height: 0.4,
        indent: 12.0,
        endIndent: 12.0,
        color: Theme.of(context).colorScheme.outlineVariant);
  }
}
