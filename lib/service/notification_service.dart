import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gymbuddy/global/firebase_constants.dart';

class NotificationService {
  final _fcm = FirebaseMessaging.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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

  void saveDeviceToken() async {
    final String? fcmToken = await _fcm.getToken();
    if (fcmToken == null || _auth.currentUser == null) {
      return;
    }
    await _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(_auth.currentUser!.uid)
        .collection(FIRESTORE_USER_TOKENS_SUBCOLLECTION)
        .doc(fcmToken)
        .set(_getTokenData(fcmToken));
  }

  _getTokenData(String fcmToken) {
    return {
      "token": fcmToken,
      "createdAt": FieldValue.serverTimestamp(),
      "platform": Platform.operatingSystem,
    };
  }
}
