import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_details_screen.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class ChangeableStepsPanelList extends StatelessWidget {
  const ChangeableStepsPanelList({super.key, required this.steps});

  final List<ChangeWorkoutStepDto> steps;

  void openDetails(BuildContext context, ChangeWorkoutStepDto step) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepDetailsScreen(
          step: WorkoutStep(
              stepId: 0,
              workoutId: 0,
              stepNumber: steps.indexOf(step) + 1,
              stepName: step.stepName!,
              details: step.details!,
              workoutType: step.workoutType!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Notify the user if no steps added yet
    if (steps.isEmpty) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InformationTag(
              child: Text(
                'No steps to show!',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () => openDetails(context, steps[index]),
                child: ListTile(
                  title: Text(steps[index].stepName!),
                  subtitle: Text(
                    '${steps[index].workoutType!.name} based step, ${steps[index].estimatedTime} seconds',
                    style: Theme.of(context).listTileTheme.subtitleTextStyle,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
