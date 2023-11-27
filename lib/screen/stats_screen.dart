import 'package:flutter/material.dart';
import 'package:gymbuddy/screen/stats/achievements.dart';
import 'package:gymbuddy/screen/stats/health/health_screen.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

bool _healthHintVisible = true;

class StatisticsSreen extends StatefulWidget {
  const StatisticsSreen({super.key});

  @override
  State<StatisticsSreen> createState() => _StatisticsSreenState();
}

class _StatisticsSreenState extends State<StatisticsSreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _healthHintVisible,
          child: InformationTag(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: _buildHintText(context),
          ),
        ),
        const Expanded(
          child: DefaultTabController(
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
          ),
        ),
      ],
    );
  }

  _buildHintText(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '❗',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            "The Health charts are only available to selected users. " +
                "If you want access to this feature, please contact:\n" +
                "gymbuddy.trainer.app@gmail.com",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                _healthHintVisible = !_healthHintVisible;
              });
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
