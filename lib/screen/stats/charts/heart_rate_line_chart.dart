import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:intl/intl.dart';

class HeartRateLineChart extends StatefulWidget {
  final List<HealthDataEntry> healthDataPoints;
  const HeartRateLineChart({
    super.key,
    required this.healthDataPoints,
  });

  @override
  State<HeartRateLineChart> createState() => _HeartRateLineChartState();
}

class _HeartRateLineChartState extends State<HeartRateLineChart> {
  static const _yAxisGap = 40.0;
  static const _xAxis = 6.0;
  static const _yAxisMaxValue = 5.5;

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
          padding: const EdgeInsets.fromLTRB(24, 8, 2, 0),
          child: Column(
            children: [
              Text('Heart rate',
                  style: Theme.of(context).textTheme.titleMedium),
              Text(FormatUtils.toHungarianDate(DateTime.now())),
              Text(bpmRange, style: Theme.of(context).textTheme.titleSmall),
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 12,
                        top: 16,
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
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${(value.toInt() * _xAxis.toInt()).toString().padLeft(1, '0')}:00',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.max || value == meta.min) {
      return Container();
    }

    final style = Theme.of(context).textTheme.titleSmall;
    var yAxisValue = value.toInt();

    return Text((yAxisValue * _yAxisGap.toInt()).toString(),
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
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              strokeWidth: 1,
              dashArray: [5, 6]);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              strokeWidth: 1,
              dashArray: [3, 4]);
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
        show: true,
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
      ),
      minX: 0,
      maxX: 24 / _xAxis,
      minY: 0,
      maxY: maxY, // max data point
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: spots.length == 1,
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

  double get maxY {
    final initialMax = _yAxisMaxValue;
    if (widget.healthDataPoints.isEmpty) {
      return initialMax;
    }
    final sortedbyValue = List<HealthDataEntry>.from(widget.healthDataPoints);
    sortedbyValue.sort(
      (b, a) => a.value.compareTo(b.value),
    );
    double highestValue = sortedbyValue.first.value / _yAxisGap;
    return highestValue < initialMax ? initialMax : highestValue;
  }

  List<FlSpot> get spots {
    var spots = widget.healthDataPoints.map((point) {
      final x = (point.createdAt.hour + point.createdAt.minute / 60) / _xAxis;
      final y = point.value / _yAxisGap;
      return FlSpot(
        double.parse(x.toStringAsFixed(2)),
        double.parse(y.toStringAsFixed(2)),
      );
    }).toList();
    return spots;
  }

  String get bpmRange {
    final data = List<HealthDataEntry>.from(widget.healthDataPoints);
    if (data.isEmpty) {
      return '-- bpm';
    }
    data.sort(
      (a, b) => a.value.compareTo(b.value),
    );

    final firstValue = data.first.value.toInt();
    final lastValue = data.last.value.toInt();

    if (firstValue == lastValue) {
      return '${lastValue} bpm';
    }
    return '${firstValue} - ${lastValue} bpm';
  }
}
