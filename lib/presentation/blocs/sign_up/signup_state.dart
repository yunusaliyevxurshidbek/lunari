class SignUpState {
  final String email;
  final String password;
  final bool termsAccepted;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  SignUpState ({
    this.email = "",
    this.password = "",
    this.termsAccepted = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  SignUpState copyWith ({
    String? email,
    String? password,
    bool? termsAccepted,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
