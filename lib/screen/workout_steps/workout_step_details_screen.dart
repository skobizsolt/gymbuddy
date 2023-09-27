// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/mapper/workout_internal_mapper.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/workout/workout_step_service.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class WorkoutStepDetailsScreen extends StatefulWidget {
  const WorkoutStepDetailsScreen(
      {super.key, required this.step, required this.workoutId});

  final WorkoutStep step;
  final int workoutId;

  @override
  State<WorkoutStepDetailsScreen> createState() =>
      _WorkoutStepDetailsScreenState();
}

class _WorkoutStepDetailsScreenState extends State<WorkoutStepDetailsScreen> {
  late WorkoutStep stepData;

  @override
  void initState() {
    super.initState();
    stepData = widget.step;
  }

  editStep(BuildContext context) async {
    ChangeWorkoutStepDto? editedStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(
          type: CrudType.edit,
          workoutStep: stepData,
        ),
      ),
    );

    if (editedStep == null) {
      return;
    }

    if (widget.workoutId != GlobalValues.LOCAL_WORKOUT_ID) {
      WorkoutStepService()
          .editStep(context, widget.workoutId, stepData.stepNumber, editedStep);
    }

    setState(() {
      stepData = WorkoutInternalDataMapper()
          .toWorkoutStep(editedStep, widget.step.stepNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;

    // Renders app bar buttons
    Widget renderAppBarButtons() {
      // Delete Button
      return Visibility(
        visible: true,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: onPrimaryContainer,
          ),
        ),
      );
    }

    // Renders the Workouts name
    Widget renderTitle() {
      return Row(
        children: [
          Expanded(
            child: Text(
              stepData.stepName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: onPrimaryContainer,
                    fontSize: 32,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    // Renders the total workout time and steps
    Widget renderDetail({
      required final String title,
      required final IconData icon,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: onPrimaryContainer,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: onPrimaryContainer,
                fontSize: 18,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    // Renders the deatils if added
    Widget renderDescription() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InformationTag(
                  child: Text(
                    stepData.details,
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }

    //Renders all steps belongs with this workout

    return DribbleLayout(
      popValue: stepData,
      actions: [
        renderAppBarButtons(),
      ],
      headerContent: Column(
        children: [
          // Title
          renderTitle(),

          // Step number
          renderDetail(
            title: '${stepData.stepNumber}. step',
            icon: Icons.grid_3x3_outlined,
          ),
          // Step type
          renderDetail(
              title: FormatUtils.toCapitalized(
                  '${stepData.workoutType.name} based step'),
              icon: Icons.star_border_purple500_outlined),

          // Time to complete
          renderDetail(
            title: FormatUtils.toTimeString(
                Duration(seconds: stepData.estimatedTime)),
            icon: Icons.access_time_rounded,
          ),

          const SizedBox(
            height: 8,
          ),

          // Edit step button
          Visibility(
            visible: true,
            child: ElevatedButton.icon(
              onPressed: () => editStep(context),
              icon: const Icon(Icons.edit),
              label: const Text('Edit step'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: onPrimaryContainer, elevation: 0),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            // Description
            Visibility(
              visible: stepData.details != null && stepData.details.isNotEmpty,
              child: renderDescription(),
            ),
          ],
        ),
      ),
    );
  }
}
