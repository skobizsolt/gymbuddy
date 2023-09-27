import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_details_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class StepsPanelList extends StatefulWidget {
  const StepsPanelList(
      {super.key, required this.workoutSteps, required this.workoutId});

  final List<WorkoutStep> workoutSteps;
  final int workoutId;

  @override
  State<StepsPanelList> createState() => _StepsPanelListState();
}

class _StepsPanelListState extends State<StepsPanelList> {
  List<WorkoutStep> get steps {
    widget.workoutSteps.sort(
        (step, nextStep) => step.stepNumber.compareTo(nextStep.stepNumber));
    return widget.workoutSteps;
  }

  Future<void> openDetails(BuildContext context, WorkoutStep step) async {
    final WorkoutStep? editedStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepDetailsScreen(
          step: step,
          workoutId: widget.workoutId,
        ),
      ),
    );

    if (editedStep == null || editedStep == step) {
      return;
    }

    setState(() {
      steps[steps.indexOf(step)] = editedStep;
    });
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
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              onTap: () => openDetails(context, steps[index]),
              title: Text(steps[index].stepName),
              subtitle: Text(
                '${FormatUtils.toCapitalized(steps[index].workoutType.name)} based step\n${FormatUtils.toTimeString(Duration(seconds: steps[index].estimatedTime))}',
                style: Theme.of(context).listTileTheme.subtitleTextStyle,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
