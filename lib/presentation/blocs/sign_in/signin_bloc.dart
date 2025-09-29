import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/domain/repositories/auth_repository.dart';
import 'package:lunari/presentation/blocs/sign_in/signin_event.dart';
import 'package:lunari/presentation/blocs/sign_in/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    try {
      bool isSignedIn =
      await authRepository.signInUser(event.email, event.password);
      if (isSignedIn) {
        emit(SignInSuccess());
      } else {
        emit(SignInFailure(errorMessage: "Email or password is wrong!"));
      }
    } catch (e) {
      emit(SignInFailure(errorMessage: e.toString()));
    }
  }
}
