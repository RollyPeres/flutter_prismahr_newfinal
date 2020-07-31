import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartAttendanceRecord extends StatefulWidget {
  ChartAttendanceRecord({Key key}) : super(key: key);

  @override
  _ChartAttendanceRecordState createState() => _ChartAttendanceRecordState();
}

class _ChartAttendanceRecordState extends State<ChartAttendanceRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93.72,
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 1.70,
        child: LineChart(
          _mainData(),
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
            FlSpot(0, 0),
            FlSpot(1, 4),
            FlSpot(2, 0),
            FlSpot(3, 6),
            FlSpot(4, 3),
            FlSpot(5, 6),
            FlSpot(6, 4),
            FlSpot(7, 8),
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
