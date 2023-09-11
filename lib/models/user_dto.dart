class UserDto {
  String email;
  String username;
  String firstName;
  String lastName;
  DateTime? registeredOn;
  String? profileImageUrl;
  UserDto({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.registeredOn,
    this.profileImageUrl,
  });

  UserDto copyWith({
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    DateTime? registeredOn,
    String? profileImageUrl,
  }) {
    return UserDto(
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      registeredOn: registeredOn ?? this.registeredOn,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  static UserDto fromMap(Map<String, dynamic> map) {
    return UserDto(
      email: map["email"],
      username: map["username"],
      firstName: map["first_name"],
      lastName: map["last_name"],
      profileImageUrl: map["profile_image_url"] ?? null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  Map<String, dynamic> toMapProfileImage() {
    return <String, dynamic>{
      'profile_image_url': profileImageUrl,
    };
  }
}
