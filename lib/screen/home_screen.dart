import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/home/home_option.dart';
import 'package:gymbuddy/widgets/utils/dribble_style_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget renderOptions() {
      var options = [
        {
          'id': 0,
          'optionName': 'Search for something new',
          'icon': Icons.search_rounded,
        },
        {
          'id': 1,
          'optionName': 'Currently popular',
          'icon': Icons.star_outline_sharp,
        },
        {
          'id': 2,
          'optionName': 'Add new training',
          'icon': Icons.add,
        },
        {
          'id': 3,
          'optionName': 'Created by me',
          'icon': Icons.accessibility_new_rounded,
        },
        {
          'id': 4,
          'optionName': 'Recent history',
          'icon': Icons.history,
        },
      ];

      return Expanded(
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return HomeOption(
              id: options[index]['id'] as int,
              optionName: options[index]['optionName'] as String,
              icon: options[index]['icon'] as IconData,
            );
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 28,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      Icon(
                        Icons.person,
                        size: 32,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                      Expanded(
                        child: Text(
                          'Let\'s do some workout 💪',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 28,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add Actions
            DribbleBody(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // add new option
                    renderOptions()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
