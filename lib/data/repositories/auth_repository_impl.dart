import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';
import '../../core/router/app_router.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  //! Forgot_Password:

  @override
  Future<void> sendOtp(String email) async {
    try {
      String otp = (1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000).toInt().toString();
      await _firestore.collection('password_resets').doc(email).set({
        'otp': otp,
        'expiresAt': DateTime.now().add(Duration(minutes: 5)).toIso8601String(),
      });

      print("OTP code for $email: $otp");

    } catch (e) {
      throw Exception("Failed to send OTP: $e");
    }
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      DocumentSnapshot otpDoc = await _firestore.collection('password_resets').doc(email).get();

      if (!otpDoc.exists) throw Exception("OTP not found");

      Map<String, dynamic> data = otpDoc.data() as Map<String, dynamic>;
      String savedOtp = data['otp'];
      DateTime expiresAt = DateTime.parse(data['expiresAt']);

      if (DateTime.now().isAfter(expiresAt)) {
        throw Exception("OTP expired");
      }

      return savedOtp == otp;
    } catch (e) {
      throw Exception("Failed to verify OTP: $e");
    }
  }


  @override
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception("User with this email does not exist.");
      }

      String userId = userSnapshot.docs.first.id;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'password': newPassword,
      });

      LogService.i("Password updated successfully in Firestore.");

      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: newPassword,
        );

        user = credential.user;
      }

      if (user != null) {
        await user.updatePassword(newPassword);
        await FirebaseAuth.instance.signOut();
        LogService.i("Password updated  in  Authentication.");
      } else {
        print("User not logged in.");
      }
    } catch (e) {
      print("Failed to reset password: $e");
    }
  }




  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'password': password,
        'createdAt': DateTime.now().toString(),
        'userId': userCredential.user!.uid,
        'lastLoginAt': DateTime.now().toString(),
        'signUpMethod': 'email',
        'name': null,
        'weight': null,
        'height': null,
        'birthday': null,
        'cycle': null,
        'period': null,
        'last': null,
        'personalizing': null,
      },SetOptions(merge: true));

      LogService.i("User data saved in Firestore");

    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for that email.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }



  Future<bool> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        throw Exception("Authentication failed!");
      }

      DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();

      if (userDoc.exists) {
        String savedEmail = userDoc["email"];
        String savedPassword = userDoc["password"];

        if (savedEmail == email && savedPassword == password) {
          return true;
        } else {
          throw Exception("Please, check your details!");
        }
      } else {
        throw Exception("User not found in Firestore!");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<void> checkUserData(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      LogService.e("User not logged in!");
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      final data = userDoc.data();

      if (data != null) {
        if (data['name'] == null) {
          LogService.e("SetUp Data not found!");
          context.push(AppRouter.setUP);
        } else {
          LogService.i("SetUp Data exist!");
        }
      }
    } else {
      LogService.e("User Data not found!");
    }
  }



  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'createdAt': DateTime.now().toString(),
          'userId': user.uid,
          'lastLoginAt': DateTime.now().toString(),
          'signUpMethod': 'google',
        }, SetOptions(merge: true));

        LogService.i("User signed in with Google: ${user.email}");
      }
    } catch (e) {
      throw Exception("Google sign-in failed: $e");
    }
  }



  @override
  Future<UserCredential?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;

        if (accessToken == null) {
          throw Exception("Facebook access token is null");
        }

        final String fbToken = accessToken.token;

        final AuthCredential credential = FacebookAuthProvider.credential(fbToken);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          print("Facebook sign-in success: ${user.email}");
        }
      } else {
        throw Exception("Facebook sign-in failed: ${result.message}");
      }
    } catch (e) {
      print("Facebook sign-in error: $e");
    }
  }




  //! signIn_with_X:
  @override
  Future<void> signInWithX() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey:"EysIzNiCB9ctvlh68A9y0Key1fEfL5vfPqUirYNhzIZiE",
        apiSecretKey: "1801497455261007872-buc6hHtfhZr3xFmFXpmQ43hOfc9Bgg",
        redirectURI: "https://lunari-18e8a.firebaseapp.com/__/auth/handler"
      );

      final authResult = await twitterLogin.login();

      if (authResult.status == TwitterLoginStatus.loggedIn) {
        final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        final user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
            "email" : user.email,
            "createdAt" : DateTime.now().toString(),
            "userId" : user.uid,
            "lastLoginAt" : DateTime.now().toString(),
            "signUpMethod" : "twitter",
          },SetOptions(merge: true),);

          LogService.i("User Signed In with X!");
        }
      } else {
        throw Exception("X login failed: ${authResult.errorMessage}");
      }
    }  catch (e) {
      LogService.e("X Sign In error: $e");
      throw Exception("X login failed: $e");
    }
  }
}



