import 'dart:io';

abstract class UserProfileEvent {}

class LoadUserProfile extends UserProfileEvent {}

class UpdateUserProfile extends UserProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String birthday;


  UpdateUserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthday,
  });
}

class SaveUserProfile extends UserProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String birthday;
  final File? avatarFile;

  SaveUserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthday,
    this.avatarFile,
  });
}