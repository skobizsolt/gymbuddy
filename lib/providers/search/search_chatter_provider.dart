import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/chats/chat_person.dart';

final searchChatterControllerProvider =
    StateNotifierProvider<SearchUserController, List<ChatPerson>>((ref) {
  return SearchUserController();
});

class SearchUserController extends StateNotifier<List<ChatPerson>> {
  SearchUserController() : super([]);

  void onSearch(String query, List<ChatPerson> chatters) {
    state = [];
    if (query.isNotEmpty) {
      final result = chatters
          .where(
            (element) =>
                element.personData!.email
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                '${element.personData!.firstName} ${element.personData!.lastName}'
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                element.personData!.username
                    .toLowerCase()
                    .contains(query.toLowerCase()),
          )
          .toList();
      state.addAll(result);
    }
  }
}
