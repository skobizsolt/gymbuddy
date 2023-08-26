class UserDto {
  String email;
  String username;
  String firstName;
  String lastName;
  DateTime registeredOn;
  String? profileImageUrl;
  UserDto({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.registeredOn,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'profile_image_url': profileImageUrl,
    };
  }
}
