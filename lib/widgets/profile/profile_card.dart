import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';
import 'package:gymbuddy/widgets/utils/themed_icon.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Widget _profileData(BuildContext context) {
    List<List<Object?>> content = [
      [
        // Full name
        "Your name",
        Theme.of(context).textTheme.titleLarge,
      ],
      [
        // Username
        "user099",
        Theme.of(context).textTheme.titleMedium,
      ],
      [
        // Registered
        "Joined: 2023.01.01",
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
                        _profileData(context),
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
  }
}
