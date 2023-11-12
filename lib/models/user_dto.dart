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
      'firstName': firstName,
      'lastName': lastName,
      'registeredOn': registeredOn?.millisecondsSinceEpoch,
      'profileImageUrl': profileImageUrl,
    };
  }

  Map<String, dynamic> toMapProfileImage() {
    return <String, dynamic>{
      'profile_image_url': profileImageUrl,
    };
  }

  @override
  String toString() {
    return 'UserDto(email: $email, username: $username, firstName: $firstName, lastName: $lastName, registeredOn: $registeredOn, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(covariant UserDto other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.registeredOn == registeredOn &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        registeredOn.hashCode ^
        profileImageUrl.hashCode;
  }
}
