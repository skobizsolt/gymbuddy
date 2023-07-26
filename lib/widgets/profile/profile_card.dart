import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/profile/containered_text.dart';
import 'package:gymbuddy/widgets/profile/profile_picture.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Expanded _profileData(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ContaineredText(
            text: "Your name",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ContaineredText(
            text: "user099",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ContaineredText(
            text: 'Joined: 2023.01.01',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Column _editProfileContent(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.edit,
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
          ),
        ),
      ],
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
                  const ProfilePicture(), // Profile picture goes here
                  const SizedBox(
                    width: 10,
                  ),
                  _profileData(context),
                  const Spacer(),
                  _editProfileContent(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
