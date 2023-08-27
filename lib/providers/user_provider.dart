import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/service/profile/profile_data_service.dart';

final userProvider = FutureProvider<UserDto>(
  (ref) {
    return ProfileDataService().profileData;
  },
);
