import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/stats/heart_rate_point.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:intl/intl.dart';

class HeartRateLineChart extends StatefulWidget {
  final List<HearthRatePoint> healthDataPoints;
  const HeartRateLineChart({
    super.key,
    required this.healthDataPoints,
  });

  @override
  State<HeartRateLineChart> createState() => _HeartRateLineChartState();
}

class _HeartRateLineChartState extends State<HeartRateLineChart> {
  static const _yAxisGap = 40.0;
  static const _xAxisGap = 6.0;
  static const _yAxisMaxValue = 4.0;

  double get maxY {
    final initialMax = _yAxisMaxValue + 0.5;
    if (widget.healthDataPoints.isEmpty) {
      return initialMax;
    }
    final sortedbyValue = List<HearthRatePoint>.from(widget.healthDataPoints);
    sortedbyValue.sort(
      (b, a) => a.value.compareTo(b.value),
    );
    double highestValue = sortedbyValue.first.value / _yAxisGap;
    return highestValue < initialMax ? initialMax : highestValue;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Theme.of(context).colorScheme.primaryContainer,
      Theme.of(context).colorScheme.primary,
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Heart rate',
                  style: Theme.of(context).textTheme.titleMedium),
              Text(FormatUtils.toHungarianDate(DateTime.now())),
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 12,
                        top: 24,
                        bottom: 12,
                      ),
                      child: LineChart(
                        mainData(gradientColors),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('${value.toInt() * _xAxisGap.toInt()}h', style: style),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    var yAxisValue = value.toInt();

    if (yAxisValue == 0) {
      return const Text('', style: style, textAlign: TextAlign.right);
    }

    return Text((yAxisValue * _yAxisGap).toString(),
        style: style, textAlign: TextAlign.right);
  }

  LineChartData mainData(List<Color> gradientColors) {
    return LineChartData(
      lineTouchData: linetouchData,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: rightTitleWidgets,
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
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 24 / _xAxisGap,
      minY: 0,
      maxY: maxY + 0.5, // max data point
      lineBarsData: [
        LineChartBarData(
          spots: widget.healthDataPoints
              .map((point) => FlSpot(
                  (point.createdAt.hour + point.createdAt.minute / 60) /
                      _xAxisGap,
                  point.value / _yAxisGap))
              .toList(),
          isCurved: true,
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

  getTouchSpotData(LineBarSpot touchedSpot) {
    final date = DateFormat.Hm()
        .format(widget.healthDataPoints[touchedSpot.spotIndex].createdAt);
    final heartRate = (touchedSpot.y * _yAxisGap).toInt().toString();
    return '$date\n$heartRate bpm';
  }

  get linetouchData {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((LineBarSpot touchedSpot) => LineTooltipItem(
                    '${getTouchSpotData(touchedSpot)}',
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
