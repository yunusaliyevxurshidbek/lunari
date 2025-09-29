import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/user_panel/user_event.dart';
import 'package:lunari/presentation/blocs/user_panel/user_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? _profileSubscription;

  UserProfileBloc() : super(UserProfileState()) {
    on<LoadUserProfile>(_onLoadUserprofile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<SaveUserProfile>(_onSaveUserProfile); // New handler
  }

  Future<void> _onLoadUserprofile(
      LoadUserProfile event, Emitter<UserProfileState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(state.copyWith(error: "No authenticated user found!"));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));

    _profileSubscription?.cancel();
    _profileSubscription = _firestore
        .collection("users")
        .doc(user.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        add(UpdateUserProfile(
          name: data["name"] as String? ?? "",
          email: data["email"] as String? ?? "",
          phone: data["phone"] as String? ?? "",
          gender: data["gender"] as String? ?? "female",
          birthday: data["birthday"] as String? ?? "",
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: "User profile does not exist!",
        ));
      }
    }, onError: (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    });
  }

  void _onUpdateUserProfile(
      UpdateUserProfile event, Emitter<UserProfileState> emit) {
    emit(state.copyWith(
      isLoading: false,
      name: event.name,
      email: event.email,
      phone: event.phone, // New
      gender: event.gender, // New
      birthday: event.birthday,
      error: null,
    ));
  }

  Future<void> _onSaveUserProfile(
      SaveUserProfile event, Emitter<UserProfileState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(state.copyWith(error: "No authenticated user found!"));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      String avatarUrl = state.avatarUrl;

      if (event.avatarFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('avatars/${user.uid}');
        await storageRef.putFile(event.avatarFile!);
        avatarUrl = await storageRef.getDownloadURL();
      }

      await _firestore.collection("users").doc(user.uid).update({
        "name": event.name,
        "email": event.email,
        "phone": event.phone,
        "gender": event.gender,
        "birthday": event.birthday,
        "avatarUrl": avatarUrl, // Save new URL
      });

      emit(state.copyWith(
        isLoading: false,
        name: event.name,
        email: event.email,
        phone: event.phone,
        gender: event.gender,
        birthday: event.birthday,
        avatarUrl: avatarUrl, // Update state
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Failed to update profile: ${e.toString()}",
      ));
    }
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }
}