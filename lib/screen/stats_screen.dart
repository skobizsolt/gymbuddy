import 'package:flutter/material.dart';

class StatisticsSreen extends StatelessWidget {
  const StatisticsSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Stats screen',
        style: TextStyle(
            fontSize: 48, color: Theme.of(context).textTheme.titleLarge!.color),
      ),
    );
  }
}
