import 'package:flutter/material.dart';
import 'package:gymbuddy/screen/stats/achievements.dart';
import 'package:gymbuddy/screen/stats/health/health_screen.dart';

class StatisticsSreen extends StatelessWidget {
  const StatisticsSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pie_chart_outline),
                text: "Achievements",
              ),
              Tab(
                icon: Icon(Icons.monitor_heart_outlined),
                text: "Health",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                AchievementsScreen(),
                HealthScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
