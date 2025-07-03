import 'package:flutter/material.dart';

class PersonalizationChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const PersonalizationChip({
    super.key,
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        color ?? Theme.of(context).colorScheme.onSurface.withAlpha(120);
    final Color iconColor = color ?? Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(bottom: 8, right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
