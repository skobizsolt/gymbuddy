import 'package:flutter/material.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/widgets/workout/workout_activity_card.dart';

class LastSessionWidget extends StatelessWidget {
  final SessionActivity data;
  const LastSessionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text("Last session"),
          ),
          const SizedBox(height: 4),
          WorkoutActivityCard(
            sessionId: data.sessionId,
            minimal: true,
          ),
        ],
      ),
    );
  }
}
