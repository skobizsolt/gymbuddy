import 'package:flutter/material.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/models/stats/chart_type.dart';
import 'package:gymbuddy/screen/stats/charts/completion_by_category_chart.dart';
import 'package:gymbuddy/screen/stats/charts/session_completion_percentage_chart.dart';

var kChartIndex = 0;

class AchievementCharts extends StatefulWidget {
  final List<SessionActivity> data;
  const AchievementCharts({super.key, required this.data});

  @override
  State<AchievementCharts> createState() => _AchievementChartsState();
}

class _AchievementChartsState extends State<AchievementCharts> {
  @override
  Widget build(BuildContext context) {
    List<TelemetryChart> charts = [
      TelemetryChart(
          title: "Completion Percentage",
          chart: SessionPercentagePieChart(data: widget.data)),
      TelemetryChart(
          title: "Completion by category",
          chart: CompletionByCategoryPieChart(data: widget.data)),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              alignment: Alignment.center,
              borderRadius: BorderRadius.zero,
              elevation: 1,
              value: kChartIndex,
              items: charts
                  .map((e) => DropdownMenuItem(
                        child: Text(e.title),
                        value: charts.indexOf(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  kChartIndex = value!;
                });
              },
            ),
          ),
        ),
        charts[kChartIndex].chart,
      ],
    );
  }
}
