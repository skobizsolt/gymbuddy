import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/user_provider.dart';

class AuthorTag extends ConsumerWidget {
  final String userId;
  const AuthorTag({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _author = ref.watch(authorProvider(userId));

    return _author.when(
        data: (data) {
          if (data == null) {
            return Container();
          }

          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(48)),
            child: Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "By:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      data.profileImageUrl == null
                          ? Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : CircleAvatar(
                              maxRadius: 12,
                              backgroundImage:
                                  Image.network(data.profileImageUrl!).image,
                            ),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Container(
                          child: Text(
                            '${data.firstName} ${data.lastName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
        loading: Container.new,
        error: (error, stackTrace) => Container(),
        skipError: true);
  }
}
