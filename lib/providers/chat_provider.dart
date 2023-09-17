import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/service/chats/chat_service.dart';

var chatsProvider = StreamProvider((ref) {
  ref.watch(authStateChangeProvider);
  return ChatService().getUsers();
});
