import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/global/global_variables.dart';

class NotificationService {
  final _firebaseMessagging = FirebaseMessaging.instance;

  Future<void> setupPushNotifications() async {
    await _firebaseMessagging
        .requestPermission()
        .whenComplete(initPushNotifications);
  }

  Future<void> handleNotification(RemoteMessage? message) async {
    if (message == null) {
      return;
    }
    if (message.data["action"] == FIREBASE_NOTIFICATION_CHATS_TOPIC) {
      GlobalValues.kBottomNavBarIndex = BottomNavigationTab.chats.index;
    }
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  }
}
