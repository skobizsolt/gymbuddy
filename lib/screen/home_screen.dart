import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/home/home_option.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget renderOptions() {
      var options = [
        {
          'optionName': 'Search for something new',
          'icon': Icons.search_rounded,
        },
        {
          'optionName': 'Currently popular',
          'icon': Icons.star_outline_sharp,
        },
        {
          'optionName': 'Add new',
          'icon': Icons.add,
        },
        {
          'optionName': 'Created by me',
          'icon': Icons.accessibility_new_rounded,
        },
        {
          'optionName': 'Recent history',
          'icon': Icons.history,
        },
      ];

      return Expanded(
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return HomeOption(
              optionName: options[index]['optionName'] as String,
              icon: options[index]['icon'] as IconData,
            );
          },
        ),
      );
    }

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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 28,
                          ),
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 28,
                          ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // add new option
                    renderOptions()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
