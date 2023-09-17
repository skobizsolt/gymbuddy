import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gymbuddy/global/firebase_constants.dart';

class FcmService {
  final _fcm = FirebaseMessaging.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> addTokenToUser() async {
    final String? fcmToken = await _fcm.getToken();
    if (fcmToken == null || _auth.currentUser == null) {
      return;
    }

    final tokens = await _getExistingTokens();

    if (tokens.isNotEmpty && tokens.contains(fcmToken)) {
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

  Future<void> deleteToken() async {
    final String? fcmToken = await _fcm.getToken();
    if (fcmToken == null || _auth.currentUser == null) {
      return;
    }

    final tokens = await _getExistingTokens();

    if (tokens.isNotEmpty && !tokens.contains(fcmToken)) {
      return;
    }

    return await _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(_auth.currentUser!.uid)
        .collection(FIRESTORE_USER_TOKENS_SUBCOLLECTION)
        .doc(fcmToken)
        .delete();
  }

  Future<List<String>> _getExistingTokens() async {
    return await _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(_auth.currentUser!.uid)
        .collection(FIRESTORE_USER_TOKENS_SUBCOLLECTION)
        .get()
        .then((event) => event.docs.map((element) => element.id).toList());
  }
}
