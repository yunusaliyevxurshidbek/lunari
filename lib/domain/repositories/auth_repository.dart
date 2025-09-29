abstract class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithFacebook();
  Future<void> signInWithX();
  Future<bool> signInUser(String email, String password);

  Future<void> sendOtp(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<void> resetPassword(String email, String newPassword);

}
