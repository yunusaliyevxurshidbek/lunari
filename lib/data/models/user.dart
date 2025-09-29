import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final int? id;
  final String uid;
  final String email;
  final String password;
  final String? imageUrl;
  final String? provider;

  // Constructor to initialize User model
  const User(
      {required this.username,
      required this.email,
      this.id,
      this.imageUrl,
      this.provider,
      required this.password,
      required this.uid});

  // From JSON (e.g., when receiving data from an API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        uid: json['uid'] ?? '',
        imageUrl: json['image_url'] ?? '',
        provider: json["provider"] ?? '',
        id: json['id'] ?? '');
  }

  // To JSON (e.g., when sending data to an API)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'id': id,
      'uid': uid,
      'image_url': imageUrl,
      "provider": provider
    };
  }

  // Equatable allows value comparison rather than reference comparison
  @override
  List<Object> get props => [username, uid, email, password];
}
