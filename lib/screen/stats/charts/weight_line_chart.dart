import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/stats/health_data_entry.dart';
import 'package:gymbuddy/screen/stats/charts/weight/monthly_chart.dart';
import 'package:gymbuddy/screen/stats/charts/weight/yearly_chart.dart';
import 'package:intl/intl.dart';

class WeightLineChart extends StatefulWidget {
  final List<HealthDataEntry> weightsData;
  const WeightLineChart({
    super.key,
    required this.weightsData,
  });

  @override
  State<WeightLineChart> createState() => _WeightLineChartState();
}

class _WeightLineChartState extends State<WeightLineChart> {
  final now = DateTime.now();

  bool showYearly = false;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      Theme.of(context).colorScheme.primaryContainer,
      Theme.of(context).colorScheme.primary,
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            color: Theme.of(context).primaryColorDark,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('My weight',
                      style: Theme.of(context).textTheme.titleMedium),
                  widget.weightsData.isEmpty
                      ? const SizedBox()
                      : Text(
                          '${widget.weightsData.last.value.toStringAsFixed(1)} kg',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
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
                        showYearly
                            ? WeightYearlyChart(
                                gradientColors: gradientColors,
                                weightsData: yearlyWeights,
                              ).mainData(gradientColors, context)
                            : WeightMonthlyChart(
                                gradientColors: gradientColors,
                                weightsData: monthlyWeights,
                              ).monthlyData(gradientColors, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: SizedBox(
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
                      : DateFormat.LLL().format(DateTime(now.year, now.month)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<HealthDataEntry> get monthlyWeights {
    return widget.weightsData
        .where((point) =>
            point.createdAt.year == now.year &&
            point.createdAt.month == now.month)
        .toList();
  }

  List<HealthDataEntry> get yearlyWeights {
    final List<HealthDataEntry> entries = [];
    for (var i = 1; i <= 12; i++) {
      final weightsInMonth = widget.weightsData
          .where((element) => element.createdAt.month == i)
          .toList();
      if (weightsInMonth.isNotEmpty) {
        weightsInMonth.sort((a, b) => a.value.compareTo(b.value));
        entries.add(weightsInMonth[0]);
      }
    }
    return entries;
  }
}
