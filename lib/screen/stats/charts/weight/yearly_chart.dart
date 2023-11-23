import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightYearlyChart extends StatelessWidget {
  final List<Color> gradientColors;
  const WeightYearlyChart({
    super.key,
    required this.gradientColors,
  });

  static const _yAxisGap = 40.0;
  static const _xAxis = 12.0;

  LineChartData mainData(List<Color> gradientColors, BuildContext context) {
    return LineChartData(
      lineTouchData: getLinetouchData(context),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            strokeWidth: 1,
            dashArray: [5, 6],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            strokeWidth: 1,
            dashArray: [3, 4],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) =>
                rightTitleWidgets(value, meta, context),
            reservedSize: 42,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 3,
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(value, meta, context),
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: _xAxis,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(
      double value, TitleMeta meta, BuildContext context) {
    if (value == meta.max) {
      return Container();
    }
    final now = DateTime.now();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${DateFormat.LLL().format(
          DateTime(now.year, value.toInt() + 1, now.day),
        )}',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    if (value == meta.max || value == meta.min) {
      return Container();
    }

    final style = Theme.of(context).textTheme.titleSmall;
    var yAxisValue = value.toInt();

    return Text((yAxisValue * _yAxisGap.toInt()).toString(),
        style: style, textAlign: TextAlign.right);
  }

  getLinetouchData(BuildContext context) {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((LineBarSpot touchedSpot) => LineTooltipItem(
                    '$touchedSpot',
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
              .toList();
        },
        tooltipBgColor: Theme.of(context).colorScheme.background,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(mainData(gradientColors, context));
  }
}
