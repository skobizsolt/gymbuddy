import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/providers/user_provider.dart';
import 'package:gymbuddy/widgets/home/home_option.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(userProvider);

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

      // Render options on home page
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

    // If the user data cannot be loaded
    if (homeData.hasError) {
      return const Center(
        child: NoContentText(title: 'An error occured'),
      );
    }

    // If userdata is loading
    if (homeData.isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WaitingSpinner(title: 'Fetching data...'),
          ],
        ),
      );
    }

    // Userdata is loaded, then build home
    final userData = homeData.value!;

    return DribbleLayout(
      addAppBar: false,
      headerContent: Padding(
        padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Greet the user
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    'Hi, ${userData.firstName}!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 28,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),

                // Profile picture
                ProfilePicture(
                  size: 32,
                  child: userData.profileImageUrl == null
                      ? Icon(
                          Icons.person,
                          size: 32,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )
                      : ProfilePicture(
                          picture: NetworkImage(
                            userData.profileImageUrl!,
                          ),
                          size: 24,
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
