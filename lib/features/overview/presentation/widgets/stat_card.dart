import 'package:flutter/material.dart';

class StatCard extends StatefulWidget {
  final Widget iconWidget;
  final String title;
  final String amount;
  final bool isHighlighted;
  final IconData arrowIcon;
  final Color arrowColor;

  const StatCard({
    super.key, // It's good practice to include a Key
    required this.iconWidget,
    required this.title,
    required this.amount,
    required this.isHighlighted,
    required this.arrowIcon,
    required this.arrowColor,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  // If you needed to manage internal state for this card,
  // you would declare variables here. For this specific conversion,
  // there's no internal state managed by the card itself yet,
  // as all data is passed in.

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 14, left: 14, right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: widget.isHighlighted // Access properties using 'widget.'
            ? Border.all(color: Colors.pink.shade300, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(38),
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
              widget.iconWidget, // Access properties using 'widget.'
              const SizedBox(width: 8),
              Text(widget.title, // Access properties using 'widget.'
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              const Spacer(),
              Icon(widget.arrowIcon, // Access properties using 'widget.'
                  color: widget.arrowColor, // Access properties using 'widget.'
                  size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              widget.amount, // Access properties using 'widget.'
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
