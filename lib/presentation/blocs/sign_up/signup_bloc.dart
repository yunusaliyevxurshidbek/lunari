import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/domain/repositories/auth_repository.dart';
import 'package:lunari/presentation/blocs/sign_up/signup_event.dart';
import 'package:lunari/presentation/blocs/sign_up/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({required this.authRepository}) : super(SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<TermsAccepted>(_onTermsAccepted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<GoogleSignUpRequested>(_onGoogleSignUp);
    on<AppleSignUpRequested>(_onAppleSignUp);
    on<FacebookSignUpRequested>(_onFacebookSignUp);
    on<TwitterSignUpRequested>(_onTwitterSignUp);
  }

  void _onEmailChanged(EmailChanged event,Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onTermsAccepted(TermsAccepted event, Emitter<SignUpState> emit) {
    emit(state.copyWith(termsAccepted: event.accepted));
  }


  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event,
      Emitter<SignUpState> emit,
      ) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please, fill all fields!'));
      return;
    }

    if (!state.termsAccepted) {
      emit(state.copyWith(errorMessage: 'Please accept terms and conditions!'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }



  //! Google:
  Future<void> _onGoogleSignUp(GoogleSignUpRequested event, Emitter<SignUpState> emit,)
  async {

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }

  //! Apple:
  Future<void> _onAppleSignUp(
      AppleSignUpRequested event,
      Emitter<SignUpState> emit
      ) async {
    if (!state.termsAccepted) {
      emit(state.copyWith(errorMessage: 'Please accept terms and conditions!'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authRepository.signInWithApple();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }


  //! Facebook:
  Future<void> _onFacebookSignUp(
      FacebookSignUpRequested event,
      Emitter<SignUpState> emit
      ) async {
    if (!state.termsAccepted) {
      emit(state.copyWith(errorMessage: 'Please accept terms and conditions!'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }


  //! Twitter:
  Future<void> _onTwitterSignUp(
      TwitterSignUpRequested event,
      Emitter<SignUpState> emit
      ) async {
    if (!state.termsAccepted) {
      emit(state.copyWith(errorMessage: 'Please accept terms and conditions!'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }



}