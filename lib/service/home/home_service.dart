import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbuddy/global/user_data.dart';
import 'package:gymbuddy/models/home/home_dto.dart';

class HomeService {
  Future<HomeDto> get homeData async {
    return await FirebaseFirestore.instance
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (value) => HomeDto(
            firstName: value.data()!["first_name"],
          ).copyWith(
            profileImageUrl: value.data()!["image_url"] ?? null,
          ),
        );
  }
}
