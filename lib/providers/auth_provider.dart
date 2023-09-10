import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/service/notification_service.dart';

var authProvider = StateNotifierProvider<AuthService, UserCredential?>((ref) {
  return AuthService(null);
});

var authStateChangeProvider = Provider((ref) {
  NotificationService().saveDeviceToken();
  return FirebaseAuth.instance.authStateChanges();
});
