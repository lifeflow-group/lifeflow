import 'package:flutter/material.dart';

import '../../../../core/utils/helpers.dart';
import '../../controllers/overview_controller.dart';

class LegendItem extends StatelessWidget {
  final CategoryStats categoryStats;
  final bool isRightAligned;

  const LegendItem({
    super.key,
    required this.categoryStats,
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
            Image.asset(categoryStats.category.iconPath, width: 17, height: 17),
            const SizedBox(width: 8),
            Text('${categoryStats.percentage.toStringAsFixed(0)}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: hexToColor(categoryStats.category.colorHex)))
          ],
        ),
        const SizedBox(height: 2),
        Text(categoryStats.category.name,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurface.withAlpha(153)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
      ],
    );
  }
}
