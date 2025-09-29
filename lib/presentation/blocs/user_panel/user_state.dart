class UserProfileState {
  final bool isLoading;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String birthday;
  final String avatarUrl;
  final String? error;

  UserProfileState({
    this.isLoading = false,
    this.name = "",
    this.email = "",
    this.phone = "",
    this.gender = "female",
    this.birthday = "",
    this.avatarUrl = "",
    this.error,
  });

  UserProfileState copyWith({
    bool? isLoading,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? birthday,
    String? avatarUrl,
    String? error,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      error: error ?? this.error,
    );
  }
}