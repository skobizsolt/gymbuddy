import 'package:flutter/material.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Workouts screen',
        style: TextStyle(
            fontSize: 48, color: Theme.of(context).textTheme.titleLarge!.color),
      ),
    );
  }
}
