import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'forgot_event.dart';
import 'forgot_state.dart';


class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordBloc({required this.authRepository}) : super(ForgotPasswordInitial()) {

    // OTP_send:
    on<ForgotPasswordRequested>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        await authRepository.sendOtp(event.email);
        emit(ForgotPasswordOtpSent());
      } catch (e) {
        emit(ForgotPasswordFailure(errorMessage: e.toString()));
      }
    });

    // OTP_verify::
    on<VerifyOtpRequested>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        bool isValid = await authRepository.verifyOtp(event.email, event.otp);
        if (isValid) {
          emit(ForgotPasswordSuccess());
        } else {
          emit(ForgotPasswordFailure(errorMessage: "Invalid OTP!"));

        }
      } catch (e) {
        emit(ForgotPasswordFailure(errorMessage: e.toString()));
      }
    });

    // Update_npassword:
    on<ResetPasswordRequested>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        await authRepository.resetPassword(event.email, event.newPassword);
        emit(ForgotPasswordSuccess());
      } catch (e) {
        emit(ForgotPasswordFailure(errorMessage: e.toString()));
      }
    });
  }
}