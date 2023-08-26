import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/models/user_dto.dart';

class ProfileDataService {
  Future<UserDto> get profileData async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(currentUser!.uid)
        .get()
        .then(
          (value) => UserDto(
                  email: value.data()!["email"],
                  username: value.data()!["username"],
                  firstName: value.data()!["first_name"],
                  lastName: value.data()!["last_name"],
                  registeredOn: currentUser.metadata.creationTime!)
              .copyWith(
            profileImageUrl: value.data()!["profile_image_url"] ?? null,
          ),
        );
  }

  void updateProfileData(UserDto? updatedData, File? localphoto) async {
    var userData = FirebaseAuth.instance.currentUser;
    // If the user choose a new profile picture
    if (userData != null && localphoto != null) {
      var storageRef = FirebaseStorage.instance
          .ref()
          .child(FIREBASE_STORAGE_USER_IMAGES)
          .child('${userData.uid}.png');
      await storageRef.putFile(localphoto);
      updatedData!.profileImageUrl = await storageRef.getDownloadURL();
    }

    // Now store the newly added data
    await FirebaseFirestore.instance
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(userData!.uid)
        .update(updatedData!.toMap());
  }
}
