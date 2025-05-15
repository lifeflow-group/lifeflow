import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Color percentageColor;
  final String percentage;
  final String label;
  final bool isRightAligned;

  const LegendItem({
    super.key,
    required this.iconPath,
    required this.iconColor,
    required this.percentageColor,
    required this.percentage,
    required this.label,
    this.isRightAligned = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment:
          isRightAligned ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, width: 17, height: 17),
            const SizedBox(width: 8),
            Text(percentage,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: percentageColor))
          ],
        ),
        const SizedBox(height: 2),
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurface.withAlpha(153)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
      ],
    );
  }
}
