import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/service/home/home_service.dart';
import 'package:gymbuddy/widgets/home/home_option.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeData = HomeService().homeData;

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

    return FutureBuilder(
      future: homeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator()),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Fetching data...')
                  ],
                )
              ],
            ),
          );
        }

        return DribbleLayout(
          addAppBar: false,
          headerContent: Padding(
            padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        'Hi, ${snapshot.data!.firstName}!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 28,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                    ),
                    ProfilePicture(
                      size: 32,
                      child: snapshot.data!.profileImageUrl == null
                          ? Icon(
                              Icons.person,
                              size: 32,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )
                          : Image.network(snapshot.data!.profileImageUrl!),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // add new option
              renderOptions()
            ],
          ),
        );
      },
    );
  }
}
