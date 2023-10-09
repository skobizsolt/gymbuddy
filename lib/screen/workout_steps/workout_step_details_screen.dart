// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class WorkoutStepDetailsScreen extends StatefulWidget {
  const WorkoutStepDetailsScreen({
    super.key,
    required this.step,
    required this.workoutId,
    required this.placeInList,
  });

  final WorkoutStep step;
  final int workoutId;
  final int placeInList;

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

  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;

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
                    stepData.details.isEmpty
                        ? "No description added for this step."
                        : stepData.details,
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
      headerContent: Column(
        children: [
          // Title
          renderTitle(),

          // Step number
          renderDetail(
            title: '${widget.placeInList}. step',
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
            renderDescription(),
          ],
        ),
      ),
    );
  }
}
