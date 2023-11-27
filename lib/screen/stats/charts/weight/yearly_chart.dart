import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:gymbuddy/service/stats/weight_chart_helper.dart';
import 'package:intl/intl.dart';

class WeightYearlyChart extends StatelessWidget {
  final List<Color> gradientColors;
  final List<HealthDataEntry> weightsData;
  const WeightYearlyChart({
    super.key,
    required this.gradientColors,
    required this.weightsData,
  });
  static const _xAxis = 12.0;
  static final _helper = WeightChartHelper();

  @override
  Widget build(BuildContext context) {
    return LineChart(mainData(gradientColors, context));
  }

  LineChartData mainData(List<Color> gradientColors, BuildContext context) {
    double _yMin = weightsData.isEmpty
        ? 40
        : _helper.getWeightsSortedByValue(weightsData).first.value;
    double _yMax = weightsData.isEmpty
        ? 80
        : _helper.getWeightsSortedByValue(weightsData).last.value;
    double interval = _helper.getCoordinatesInterval(_yMax - _yMin);
    return LineChartData(
      lineTouchData: getLinetouchData(context),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: weightsData.length > 1
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Colors.transparent,
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
            interval: interval,
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
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
      ),
      minX: 0,
      maxX: _xAxis,
      minY: _yMin.toInt() - 1.0,
      maxY: _yMax.toInt() + 1.0,
      lineBarsData: [
        LineChartBarData(
          spots: weightSpots,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
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

  List<FlSpot> get weightSpots {
    return weightsData
        .map((point) => FlSpot(
              point.createdAt.month.toDouble(),
              double.parse(point.value.toStringAsFixed(2)),
            ))
        .toList();
  }
}
