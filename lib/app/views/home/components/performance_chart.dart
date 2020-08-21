import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PerformanceChart extends StatefulWidget {
  PerformanceChart({Key key}) : super(key: key);

  @override
  _PerformanceChartState createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.00, bottom: 50.00),
      child: Container(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16 / 4,
          child: LineChart(_mainData()),
        ),
      ),
    );
  }

  LineChartData _mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: false, // turn this on for debug
        leftTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'D1';
              case 2:
                return 'D2';
              case 3:
                return 'D3';
              case 4:
                return 'D4';
              case 5:
                return 'D5';
              case 6:
                return 'D6';
            }

            return '';
          },
          margin: 8,
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 24, // max hour per day
      lineBarsData: [
        LineChartBarData(
          spots: [
            // x (day), y (total working hours)
            FlSpot(0, 12),
            FlSpot(1, 24),
            FlSpot(2, 8),
            FlSpot(3, 14),
            FlSpot(4, 0),
            FlSpot(5, 18),
            FlSpot(6, 6),
            FlSpot(7, 12),
          ],
          isCurved: true,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          colors: [
            Theme.of(context).primaryColor,
          ],
          shadow: Shadow(
            color: Color(0x95284ee8),
            blurRadius: 10.00,
            offset: Offset(00.00, 10.00),
          ),
        ),
      ],
    );
  }
}
