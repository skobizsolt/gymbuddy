import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final _fcm = FirebaseMessaging.instance;

  Future<void> setupPushNotifications() async {
    await _fcm.requestPermission().whenComplete(initPushNotifications);
  }

  Future<void> handleNotification(RemoteMessage? message) async {
    if (message == null) {
      return;
    }
    print("Handling a background message: ${message.messageId}");
  }

  Future initPushNotifications() async {
    _fcm.getInitialMessage().then(handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  }
}
