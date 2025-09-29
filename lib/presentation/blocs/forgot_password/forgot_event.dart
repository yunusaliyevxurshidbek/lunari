import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

class VerifyOtpRequested extends ForgotPasswordEvent {
  final String email;
  final String otp;

  const VerifyOtpRequested(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}

class ResetPasswordRequested extends ForgotPasswordEvent {
  final String email;
  final String newPassword;

  ResetPasswordRequested({required this.email, required this.newPassword});
}

