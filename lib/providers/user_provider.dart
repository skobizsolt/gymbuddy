import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/service/profile/profile_data_service.dart';

final userProvider = StreamProvider<UserDto>(
  (ref) {
    ref.watch(authStateChangeProvider);
    return ProfileDataService().profileData;
  },
);
