import 'package:flutter/material.dart';
import 'package:gymbuddy/data/workout_step_data.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_details_screen.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class StepsPanelList extends StatelessWidget {
  const StepsPanelList({super.key, required this.workoutId});

  final int workoutId;

  List<WorkoutStep> get steps {
    List<WorkoutStep> list = stepsData
        .where(
          (element) => element.workoutId == workoutId,
        )
        .toList();
    list.sort(
        (step, nextStep) => step.stepNumber.compareTo(nextStep.stepNumber));
    return list;
  }

  void openDetails(BuildContext context, WorkoutStep step) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepDetailsScreen(
          step: step,
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
              child: ListTile(
                title: Text(steps[index].stepName),
                subtitle: Text(
                  'Type: ${steps[index].workoutType.name}',
                  style: Theme.of(context).listTileTheme.subtitleTextStyle,
                ),
                trailing: IconButton(
                  onPressed: () {
                    openDetails(context, steps[index]);
                  },
                  icon: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
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
