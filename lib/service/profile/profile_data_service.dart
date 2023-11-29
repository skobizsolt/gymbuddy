import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/models/auth/new_user_dto.dart';
import 'package:gymbuddy/models/user_dto.dart';

class ProfileDataService {
  final _firestore = FirebaseFirestore.instance;

  Stream<UserDto> get profileData {
    var currentUser = FirebaseAuth.instance.currentUser;
    return _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(currentUser!.uid)
        .snapshots()
        .map((value) {
      if (value.data() == null || value.data()!.isEmpty) {
        throw Exception("Couldn't receive user data");
      }
      return UserDto(
              email: value.data()!["email"],
              username: value.data()!["username"],
              firstName: value.data()!["first_name"],
              lastName: value.data()!["last_name"],
              registeredOn: currentUser.metadata.creationTime!)
          .copyWith(
        profileImageUrl: value.data()!["profile_image_url"] ?? null,
      );
    });
  }

  Future<void> registerUserData(
      UserCredential? value, NewUserDto newUser) async {
    if (value == null || value.user == null) {
      return;
    }
    await _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(value.user!.uid)
        .set({
      'email': value.user!.email,
      'username': newUser.username,
      'first_name': newUser.firstName,
      'last_name': newUser.lastName
    });
  }

  Future<void> updateProfileData(
      UserDto oldData, UserDto updatedData, File? localphoto) async {
    var userData = FirebaseAuth.instance.currentUser;
    // If the user choose a new profile picture
    if (userData != null && localphoto != null) {
      var storageRef = FirebaseStorage.instance
          .ref()
          .child(FIREBASE_STORAGE_USER_IMAGES)
          .child('${userData.uid}.png');
      await storageRef.putFile(localphoto);
      updatedData.profileImageUrl = await storageRef.getDownloadURL();
      await _firestore
          .collection(FIRESTORE_USER_COLLECTION)
          .doc(userData.uid)
          .update(updatedData.toMapProfileImage());
    }

    // Now store the newly added data
    if (oldData.firstName != updatedData.firstName ||
        oldData.lastName != updatedData.lastName) {
      await _firestore
          .collection(FIRESTORE_USER_COLLECTION)
          .doc(userData!.uid)
          .update(updatedData.toMap());
    }
  }

  Future<List<String>> get usernames async {
    var usernamesCollection =
        await _firestore.collection(FIRESTORE_USERNAME_COLLECTION).get();
    List<String> usernames =
        usernamesCollection.docs.map((doc) => doc.id).toList();
    return usernames;
  }

  addUsernameToCollection(final String username, final String email) async {
    return await _firestore
        .collection(FIRESTORE_USERNAME_COLLECTION)
        .doc(username)
        .set({'email': email});
  }

  Future<UserDto?>? getAuthor(String userId) async {
    return await _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(userId)
        .get()
        .then((value) =>
            value.data() == null ? null : UserDto.fromMap(value.data()!));
  }
}
