import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:gymbuddy/service/stats/weight_chart_helper.dart';
import 'package:quiver/time.dart';

class WeightMonthlyChart extends StatelessWidget {
  final List<Color> gradientColors;
  final List<HealthDataEntry> weightsData;
  const WeightMonthlyChart({
    super.key,
    required this.gradientColors,
    required this.weightsData,
  });

  static final double _xAxis = daysInMonth(now.year, now.month).toDouble();
  static final now = DateTime.now();
  static final _helper = WeightChartHelper();

  @override
  Widget build(BuildContext context) {
    return LineChart(monthlyData(gradientColors, context));
  }

  LineChartData monthlyData(List<Color> gradientColors, BuildContext context) {
    double _yMin = weightsData.isEmpty
        ? 40
        : _helper.getYCoordinate(weightsData, isMinimum: true);
    double _yMax = weightsData.isEmpty
        ? 80
        : _helper.getYCoordinate(weightsData, isMinimum: false);
    double interval = _helper.getCoordinatesInterval(_yMax - _yMin);
    return LineChartData(
      lineTouchData: getLinetouchData(context),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
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
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(value, meta, context),
            interval: 6,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) =>
                rightTitleWidgets(value, meta, context),
            reservedSize: 42,
            interval: interval,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        ),
      ),
      minX: 1,
      maxX: _xAxis,
      minY: _yMin,
      maxY: _yMax,
      lineBarsData: [
        LineChartBarData(
          spots: weightsData
              .map(
                (pointInMonth) => FlSpot(
                  pointInMonth.createdAt.day.toDouble(),
                  double.parse(pointInMonth.value.toStringAsFixed(1)),
                ),
              )
              .toList(),
          isCurved: false,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: weightsData.length == 1,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(
      double value, TitleMeta meta, BuildContext context) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${value.toInt()}',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    if (value == meta.max || value == meta.min) {
      return Container();
    }

    final style = Theme.of(context).textTheme.titleSmall;
    var yAxisValue = value;

    return Text((yAxisValue).toStringAsFixed(1),
        style: style, textAlign: TextAlign.right);
  }

  getLinetouchData(BuildContext context) {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((LineBarSpot touchedSpot) => LineTooltipItem(
                    '${_helper.getTouchSpotData(touchedSpot, weightsData)}',
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
}
