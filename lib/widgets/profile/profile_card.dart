import 'package:flutter/material.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/screen/profile/change_profile_data.dart';
import 'package:gymbuddy/service/profile/profile_data_service.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final _data = ProfileDataService().profileData;

  Widget _profileData(BuildContext context, AsyncSnapshot<UserDto> snapshot) {
    List<List<Object?>> content = [
      [
        // Full name
        '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
        Theme.of(context).textTheme.titleLarge,
      ],
      [
        // Username
        snapshot.data!.username,
        Theme.of(context).textTheme.titleMedium,
      ],
      [
        // Registered
        "Joined: ${DateFormat.yMMMd('en_CA').format(snapshot.data!.registeredOn)}",
        Theme.of(context).textTheme.titleSmall,
      ],
    ];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...content.map((item) => Text(
                item[0] as String,
                style: item[1] as TextStyle,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                  ),
                ),
              ),
            );
          }

          // Allows to set different date locales
          initializeDateFormatting();

          return Container(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Profile picture goes here
                        ProfilePicture(
                          size: 40,
                          child: Icon(
                            Icons.person,
                            size: 75,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile data
                              _profileData(context, snapshot),

                              // Edit data button
                              IconButton(
                                onPressed: () =>
                                    ChangeProfileData(userDto: snapshot.data!)
                                        .showChangeData(context),
                                icon: const Icon(Icons.edit),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
