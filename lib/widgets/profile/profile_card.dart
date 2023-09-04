import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/providers/user_provider.dart';
import 'package:gymbuddy/screen/profile/change_profile_data_screen.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  Widget _profileData(BuildContext context, UserDto userData) {
    List<List<Object?>> content = [
      [
        // Full name
        '${userData.firstName} ${userData.lastName}',
        Theme.of(context).textTheme.titleLarge,
      ],
      [
        // Username
        userData.username,
        Theme.of(context).textTheme.titleMedium,
      ],
      [
        // Registered
        "Joined: ${DateFormat.yMMMd('en_CA').format(userData.registeredOn)}",
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
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<UserDto> _data = ref.watch(userProvider);

    if (_data.isLoading) {
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
    UserDto _userData = _data.value!;

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
                  _userData.profileImageUrl == null
                      ? Icon(
                          Icons.person,
                          size: 75,
                          color: Theme.of(context).colorScheme.tertiary,
                        )
                      : ProfilePicture(
                          size: 40,
                          picture: NetworkImage(_userData.profileImageUrl!),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile _data
                        _profileData(context, _userData),

                        // Edit _data button
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeProfileDataScreen(),
                              ),
                            );
                            ref.read(userProvider);
                          },
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
  }
}
