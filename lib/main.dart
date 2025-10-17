import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:lunari/core/services/noti_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data/repositories/preferences_repository.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotiService().initNotification();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final firestore = FirebaseFirestore.instance;

  User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = currentUser?.uid;

  PreferencesRepository? preferencesRepository;
  if (uid != null) {
    preferencesRepository = PreferencesRepository(prefs, firestore, uid);
  }

  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (currentUser != null) {
    LogService.w("User logged in: ${currentUser.email}".tr());
  } else {
    LogService.w("User not logged in!".tr());
  }

  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('zh'), // Mandarin Chinese
        Locale('hi'), // Hindi
        Locale('ar'), // Arabic
        Locale('bn'), // Bengali
        Locale('pt'), // Portuguese
        Locale('ru'), // Russian
        Locale('ja'), // Japanese
        Locale('de'), // German
        Locale('fr'), // French
        Locale('ur'), // Urdu
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MyApp(
        isFirstLaunch: isFirstLaunch,
        prefs: prefs,
        preferencesRepository: preferencesRepository,
        currentUser: currentUser,
      ),
    ),
  );
}


// git

