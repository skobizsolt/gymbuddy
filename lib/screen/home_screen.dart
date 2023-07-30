import 'package:flutter/material.dart';
import 'package:gymbuddy/data/workout_data.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),

            // AppBar area
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, User!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28),
                    ),
                    const Icon(
                      Icons.person,
                      size: 32,
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Let\'s do some workout 💪',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Add Actions
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    return WorkoutCard(workout: workouts[index]);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
