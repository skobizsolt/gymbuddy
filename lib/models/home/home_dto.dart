class HomeDto {
  String firstName;
  String? profileImageUrl;
  HomeDto({
    required this.firstName,
    this.profileImageUrl,
  });

  HomeDto copyWith({
    String? firstName,
    String? profileImageUrl,
  }) {
    return HomeDto(
      firstName: firstName ?? this.firstName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
