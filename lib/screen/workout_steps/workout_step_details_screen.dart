// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class WorkoutStepDetailsScreen extends StatelessWidget {
  const WorkoutStepDetailsScreen({super.key, required this.step});

  final WorkoutStep step;

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
              step.stepName,
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
                    step.details,
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
      actions: [
        renderAppBarButtons(),
      ],
      headerContent: Column(
        children: [
          // Title
          renderTitle(),

          // Step number
          renderDetail(
            title: '${step.stepNumber}. step',
            icon: Icons.grid_3x3_outlined,
          ),
          // Step type
          renderDetail(
              title: step.workoutType.name[0].toUpperCase() +
                  step.workoutType.name.substring(1),
              icon: Icons.star_border_purple500_outlined),

          const SizedBox(
            height: 8,
          ),

          // Edit step button
          Visibility(
            visible: true,
            child: ElevatedButton.icon(
              onPressed: () {},
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
              visible: step.details != null && step.details.isNotEmpty,
              child: renderDescription(),
            ),
          ],
        ),
      ),
    );
  }
}
