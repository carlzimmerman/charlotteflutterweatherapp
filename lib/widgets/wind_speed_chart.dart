import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WindSpeedChart extends StatelessWidget {
  final double windMph;

  WindSpeedChart({required this.windMph});

  @override
  Widget build(BuildContext context) {
    // Adjusting the overall size by setting a more flexible aspect ratio if needed
    return Container(
      height: 100, // Set a fixed height to control the size
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 20, // Slightly smaller center space
          sectionsSpace: 0,
          startDegreeOffset: 270, // Start from top
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isWindSection = i == 0;
      double radius = isWindSection ? 70 : 60; // Reduced radius for both sections
      double value = isWindSection ? windMph : 100 - windMph;
      Color color = isWindSection ? Colors.blue : Colors.grey[300]!;

      return PieChartSectionData(
        color: color,
        value: value,
        title: isWindSection ? '${windMph.toStringAsFixed(1)} MPH' : '',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        titlePositionPercentageOffset: 0.55,
      );
    });
  }
}
