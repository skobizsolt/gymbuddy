import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/workout/steps_panel_list.dart';
import 'package:ionicons/ionicons.dart';

class WorkoutDetails extends StatelessWidget {
  const WorkoutDetails({super.key, required this.workout, this.steps});

  final Workout workout;
  final List<WorkoutStep>? steps;
  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.background;

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
              workout.title,
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

    // Renders the type and difficulty and other future tags
    Widget renderTags() {
      var tags = [
        InformationTag(
          child: Text(
            '${workoutCategoryIcon[workout.category]} ${workout.category.name[0].toUpperCase() + workout.category.name.substring(1)}',
            style: TextStyle(color: primaryColor, fontSize: 14),
          ),
        ),
        InformationTag(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              workoutDifficultyRating[workout.difficulty] as Widget,
              const SizedBox(
                width: 5,
              ),
              Text(
                workout.difficulty.name[0].toUpperCase() +
                    workout.difficulty.name.substring(1),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ];

      return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: tags.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: tags[index],
            );
          },
        ),
      );
    }

    // Renders the deatils if added
    Widget renderDescription() {
      if (workout.description == null || workout.description!.isEmpty) {
        return const SizedBox();
      }
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InformationTag(
                  child: Text(
                    workout.description!,
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

          // Time to complete
          renderDetail(
            title: '${workout.estimatedTimeInMinutes} mins',
            icon: Icons.access_time_rounded,
          ),

          // Steps
          renderDetail(
              title: '${workout.steps} Steps', icon: Ionicons.footsteps),

          const SizedBox(
            height: 8,
          ),

          // Edit workout button
          Visibility(
            visible: true,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Edit workout'),
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
            // Tags
            renderTags(),
            const SizedBox(
              height: 20,
            ),

            // Description
            renderDescription(),

            // Steps
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Steps',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Visibility(
                  visible: true,
                  child: InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4.0),
                        color: Theme.of(context).primaryColorLight,
                        child: Row(
                          children: [
                            const Text('Add new'),
                            Icon(
                              Ionicons.add,
                              size: 24,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            StepsPanelList(workoutSteps: steps!),
          ],
        ),
      ),
      footing: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Launch'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
