import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/screen/stats/charts/weight/yearly_chart.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

class WeightLineChart extends StatefulWidget {
  const WeightLineChart({super.key});

  @override
  State<WeightLineChart> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<WeightLineChart> {
  static const _yAxisGap = 40.0;
  static late final double _xAxis;
  final now = DateTime.now();
  final data = [1];

  @override
  void initState() {
    super.initState();
    _xAxis = daysInMonth(now.year, now.month).toDouble();
  }

  bool showYearly = false;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
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
              const Text('My weight'),
              Stack(
                alignment: Alignment.topRight,
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
                        showYearly
                            ? WeightYearlyChart(
                                gradientColors: gradientColors,
                              ).mainData(gradientColors, context)
                            : monthlyData(gradientColors),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: showYearly ? 75 : 60,
                    height: 34,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          showYearly = !showYearly;
                        });
                      },
                      child: Text(
                        showYearly
                            ? 'This year'
                            : DateFormat.LLL()
                                .format(DateTime(now.year, now.month)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
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

  LineChartData monthlyData(List<Color> gradientColors) {
    return LineChartData(
      lineTouchData: linetouchData,
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
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
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
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
            getTitlesWidget: rightTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: _xAxis,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 3.44),
          ],
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
            show: data.length == 1,
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${value.toInt()}',
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

  get linetouchData {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((LineBarSpot touchedSpot) => LineTooltipItem(
                    '${touchedSpot.y}',
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
