import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(icon,
          color: colorScheme.onSurface.withAlpha((0.72 * 255).toInt())),
      title: Text(title,
          style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withAlpha((0.72 * 255).toInt()))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (value != null)
            Text(
              value!,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withAlpha((0.54 * 255).toInt())),
            ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios,
              size: 16.0,
              color: colorScheme.onSurface.withAlpha((0.54 * 255).toInt())),
        ],
      ),
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
  }
}
