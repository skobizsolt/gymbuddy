import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbuddy/global/user_data.dart';
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
            profileImageUrl: value.data()!["image_url"] ?? null,
          ),
        );
  }
}
