import 'package:flutter/material.dart';
import 'package:gymbuddy/global/user_data.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/widgets/home/home_option.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

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

    return DribbleLayout(
      addAppBar: false,
      headerContent: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi, ${user!.email}!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                ProfilePicture(
                  child: Icon(
                    Icons.person,
                    size: 32,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // add new option
          renderOptions()
        ],
      ),
    );
  }
}
