abstract class SignUpEvent {
  const SignUpEvent();
}

class  EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends SignUpEvent {
  final String password;
  PasswordChanged(this.password);
}

class TermsAccepted extends SignUpEvent {
  final bool accepted;
  TermsAccepted(this.accepted);
}

class SignUpSubmitted extends SignUpEvent {}

class GoogleSignUpRequested  extends SignUpEvent {}
class AppleSignUpRequested  extends SignUpEvent {}
class FacebookSignUpRequested  extends SignUpEvent {}
class TwitterSignUpRequested  extends SignUpEvent {}

