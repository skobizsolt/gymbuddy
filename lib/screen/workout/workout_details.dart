import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/utils/dribble_style_body.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:ionicons/ionicons.dart';

class WorkoutDetails extends StatelessWidget {
  const WorkoutDetails({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.background;

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

    Widget renderDescription() {
      if (workout.description == null) {
        return const SizedBox();
      }
      return InformationTag(
        color: onPrimaryContainer,
        child: Text(
          workout.description!,
          style: TextStyle(
            color: primaryContainer,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      );
    }

    Widget renderTags() {
      var tags = [
        InformationTag(
          child: Text(
            '${workoutCategoryIcon[workout.category]} ${workout.category.name[0].toUpperCase() + workout.category.name.substring(1)}',
            style: TextStyle(color: primaryContainer, fontSize: 14),
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
                style: TextStyle(color: primaryContainer, fontSize: 14),
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

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackButton(
                  style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(
                      onPrimaryContainer,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            const SizedBox(
              height: 40,
            ),

            // Basic details
            Column(
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
                    title: '${workout.steps} Steps', icon: Ionicons.footsteps)
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            DribbleBody(
              backgroundColor: backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tags
                    renderTags(),
                    const SizedBox(
                      height: 20,
                    ),
                    // Description
                    Row(
                      children: [
                        Expanded(child: renderDescription()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
