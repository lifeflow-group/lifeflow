import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'legend_item.dart';

class ChartSection extends StatefulWidget {
  const ChartSection({super.key});

  @override
  State<ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends State<ChartSection> {
  // Data for the pie chart.
  // Defining it here as 'final' means it's created once when the state is initialized.
  final List<PieChartSectionData> _pieChartSections = [
    PieChartSectionData(
      color: Colors.purple.shade200,
      value: 50,
      radius: 63,
      showTitle: false,
    ),
    PieChartSectionData(
      color: Colors.grey.shade300,
      value: 6,
      radius: 60,
      showTitle: false,
    ),
    PieChartSectionData(
      color: Colors.orange.shade300,
      value: 19,
      radius: 60,
      showTitle: false,
    ),
    PieChartSectionData(
      color: Colors.orange.shade500,
      value: 10,
      radius: 60,
      showTitle: false,
    ),
    PieChartSectionData(
      color: Colors.blue.shade200,
      value: 14,
      radius: 60,
      showTitle: false,
    ),
  ];

  // If you need to manage interactive state, e.g., which section is touched
  // int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230, // Adjust height to fit chart and legends comfortably
      child: Row(
        children: [
          // Left Legend
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItem(
                    icon: Icons.school_outlined,
                    iconColor: Colors.orange.shade600,
                    percentageColor: Colors.orange.shade700,
                    percentage: "19%",
                    label: "Education"),
                LegendItem(
                    icon: Icons.more_horiz,
                    iconColor: Colors.grey.shade600,
                    percentageColor: Colors.grey.shade800,
                    percentage: "6%",
                    label: "Others"),
                LegendItem(
                    icon: Icons.people_outline,
                    iconColor: Colors.brown.shade500,
                    percentageColor: Colors.orange.shade900,
                    percentage: "10%",
                    label: "Social"),
                LegendItem(
                    icon: Icons.restaurant_outlined,
                    iconColor: Colors.blue.shade600,
                    percentageColor: Colors.blue.shade700,
                    percentage: "14%",
                    label: "Food"),
              ],
            ),
          ),
          // Chart
          Expanded(
            flex: 2, // Give more space for chart and its legend
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: PieChart(
                PieChartData(
                  sections: _pieChartSections, // Use the state field
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2.5, // Space between sections
                  centerSpaceRadius: 30, // Donut hole size
                  startDegreeOffset:
                      -90, // Start purple section at the top right quadrant
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      // Optional: handle touch and update state if needed
                      // setState(() {
                      //   if (!event.isInterestedForInteractions ||
                      //       pieTouchResponse == null ||
                      //       pieTouchResponse.touchedSection == null) {
                      //     _touchedIndex = -1;
                      //     return;
                      //   }
                      //   _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      // });
                    },
                  ),
                ),
              ),
            ),
          ),
          // Right Legend
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LegendItem(
                    // Use the new widget
                    icon: Icons.home_outlined,
                    iconColor: Colors.purple.shade500,
                    percentageColor: Colors.purple.shade600,
                    percentage: "50%",
                    label: "Work",
                    isRightAligned: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
