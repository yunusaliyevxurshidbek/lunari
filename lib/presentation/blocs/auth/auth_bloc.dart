import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/domain/repositories/auth_repository.dart';
import 'package:lunari/presentation/blocs/auth/auth_event.dart';
import 'package:lunari/presentation/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<GoogleSignInRequested>(_onGoogleSignIn);
    on<AplleSignInPressed>(_onAppleSignIn);
    on<FacebookSignInRequested>(_onFacebookSignIn);
    on<XSignInRequested>(_onXSignIn);
    on<SignInPressed>(_onSignIn);
    on<SignUpPressed>(_onSignUp);
  }

  Future<void> _onGoogleSignIn(GoogleSignInRequested event, Emitter<AuthState> emit)
  async {
    emit(AuthLoading());
    try {
      await authRepository.signInWithGoogle();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Google sign-in rejected!"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onFacebookSignIn(FacebookSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signInWithFacebook();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Facebook sign-in rejected!"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAppleSignIn(AplleSignInPressed event, Emitter<AuthState> emit) async {}

  Future<void> _onXSignIn(XSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signInWithX();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("X SIgnIn rejected!"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }

  }

  Future<void> _onSignIn(SignInPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      emit(AuthNavigateToSignIn());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      emit(AuthNavigateToSignUp());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
