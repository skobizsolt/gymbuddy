import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/stats/pie_badge.dart';

class CompletionByCategoryPieChart extends StatefulWidget {
  final List<SessionActivity> data;
  const CompletionByCategoryPieChart({
    super.key,
    required this.data,
  });

  @override
  State<CompletionByCategoryPieChart> createState() =>
      _CompletionByCategoryPieChartState();
}

class _CompletionByCategoryPieChartState
    extends State<CompletionByCategoryPieChart> {
  var touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final categoryCount = _calculateValues();
    final colors = {
      WorkoutCategory.balance: Colors.green,
      WorkoutCategory.endurance: Colors.amber,
      WorkoutCategory.flexibility: Colors.brown,
      WorkoutCategory.strength: Colors.indigo,
    };

    return WorkoutCategory.values.map((category) {
      var index = WorkoutCategory.values.indexOf(category);
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[category] ?? Theme.of(context).colorScheme.primary,
        value: categoryCount[index] / widget.data.length,
        title: '${categoryCount[index]}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: PieBadge(
          Text(workoutCategoryIcon[WorkoutCategory.values[index]]!),
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }

  List<int> _calculateValues() {
    final List<int> categoryCount = [];
    WorkoutCategory.values.forEach(
      (category) {
        var matches =
            widget.data.where((item) => item.category == category).length;
        categoryCount.add(matches);
      },
    );
    return categoryCount;
  }
}
