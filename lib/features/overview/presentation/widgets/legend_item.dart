import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color percentageColor;
  final String percentage;
  final String label;
  final bool isRightAligned;

  const LegendItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.percentageColor,
    required this.percentage,
    required this.label,
    this.isRightAligned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isRightAligned ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 17),
            const SizedBox(width: 8),
            Text(percentage,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: percentageColor)),
          ],
        ),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
      ],
    );
  }
}
