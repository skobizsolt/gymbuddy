class ChatHistory {
  ChatHistory({
    this.receiverProfilePictureUrl,
    required this.receiverUserName,
    required this.lastMessage,
    required this.lastMessageDate,
  });

  final String? receiverProfilePictureUrl;
  final String receiverUserName;
  final String lastMessage;
  final DateTime lastMessageDate;
}
