import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/chats/chat_person.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/service/chats/chat_history_service.dart';
import 'package:gymbuddy/service/chats/chat_service.dart';

var chatPartnersProvider = StreamProvider((ref) {
  ref.watch(authStateChangeProvider);
  return ChatService().getUsers();
});

var _chatMessageListenerProvider = StreamProvider((ref) {
  ref.watch(authStateChangeProvider);
  return ChatHistoryService().getMessageSnapshots();
});

var chatHistoryProvider = FutureProvider<List<Future<ChatPerson>>>((ref) {
  ref.watch(_chatMessageListenerProvider);
  return ChatHistoryService().getHistory();
});
