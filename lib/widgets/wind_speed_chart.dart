import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WindSpeedChart extends StatelessWidget {
  final double windMph;

  WindSpeedChart({required this.windMph});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 60,
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
      double radius = isWindSection ? 100 : 90;
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
