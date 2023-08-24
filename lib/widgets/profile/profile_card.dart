import 'package:flutter/material.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/service/profile/profile_data_service.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';
import 'package:gymbuddy/widgets/utils/themed_icon.dart';
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

  Widget _editProfileContent(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {},
        child: const ThemedIcon(
          Icons.edit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 5),
                      Text('Loading profile data')
                    ],
                  ),
                ),
              ),
            );
          }

          // Allows to set different locales
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
                        ProfilePicture(
                          size: 40,
                          child: Icon(
                            Icons.person,
                            size: 75,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ), // Profile picture goes here
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _profileData(context, snapshot),
                              _editProfileContent(context),
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
