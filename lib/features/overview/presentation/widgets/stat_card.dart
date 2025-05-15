import 'package:flutter/material.dart';

class StatCard extends StatefulWidget {
  final Widget iconWidget;
  final String title;
  final String amount;
  final bool isHighlighted;
  final IconData? arrowIcon;
  final Color? arrowColor;

  const StatCard({
    super.key,
    required this.iconWidget,
    required this.title,
    required this.amount,
    required this.isHighlighted,
    this.arrowIcon,
    this.arrowColor,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 14, left: 14, right: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: widget.isHighlighted
            ? Border.all(color: theme.colorScheme.primary, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
              color: theme.colorScheme.shadow.withAlpha(38), // 0.15 * 255 = 38
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.iconWidget,
              const SizedBox(width: 8),
              Text(widget.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(179))),
              const Spacer(),
              widget.arrowIcon != null
                  ? Icon(widget.arrowIcon, color: widget.arrowColor, size: 18)
                  : SizedBox(),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(widget.amount,
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface)),
          ),
        ],
      ),
    );
  }
}
