import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/blocs/preferences/preferences_state.dart';

class PreferencesRepository {
  final SharedPreferences _sharedPrefs;
  final FirebaseFirestore _firestore;
  final String _uid;

  PreferencesRepository(this._sharedPrefs,this._firestore,this._uid);

  static const keyWeight = "weightUnit";
  static const keyHeight = "heighUnit";
  static const keyTemperature = "temperatureUnit";
  static const keyWaterGoal = "waterGoal";
  static const keyCup = "cupUnit";
  static const keyFirstDay = "firstDay";
  static const  keyTimeFormat = "timeFormat";
  static const keyBmi = "isBmiEnabled";
  static const keyDayReset = "daysResetTime";

  CollectionReference get _prefsCollection => _firestore.collection("users").doc(_uid).collection("Preferences");

  Future<PreferencesState> loadPreferences() async {
    final weight = _sharedPrefs.getString(keyWeight) ?? "kg";
    final height = _sharedPrefs.getString(keyHeight) ?? "cm";
    final temperature = _sharedPrefs.getString(keyTemperature) ?? "°C";
    final waterGoal = _sharedPrefs.getString(keyWaterGoal) ?? "2400";
    final cup = _sharedPrefs.getString(keyCup) ?? "mL";
    final firstDay = _sharedPrefs.getString(keyFirstDay) ?? "Sunday";
    final timeFormat = _sharedPrefs.getString(keyTimeFormat) ?? "System Default";
    final isBmi = _sharedPrefs.getBool(keyBmi) ?? true;
    final dayResetMillis = _sharedPrefs.getInt(keyDayReset) ?? TimeOfDay.now().hour * 60 + TimeOfDay.now().minute;

    final doc = await _prefsCollection.doc("settings").get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
    }
    return PreferencesState(
      weightUnit: weight,
      heightUnit: height,
      temperatureUnit: temperature,
      waterGoal: waterGoal,
      cupUnit: cup,
      firstDay: firstDay,
      timeFormat: timeFormat,
      isBmiEnabled: isBmi,
      dayResetTimeInMinutes: dayResetMillis,
    );
  }

  Future<void> savePreference(String key, dynamic value) async {
    // Save locally
    switch (key) {
      case keyWeight:
        await _sharedPrefs.setString(keyWeight, value as String);
        break;
      case keyHeight:
        await _sharedPrefs.setString(keyHeight, value as String);
        break;
      case keyTemperature:
        await _sharedPrefs.setString(keyTemperature, value as String);
        break;
      case keyWaterGoal:
        await _sharedPrefs.setString(keyWaterGoal, value as String);
        break;
      case keyCup:
        await _sharedPrefs.setString(keyCup, value as String);
        break;
      case keyFirstDay:
        await _sharedPrefs.setString(keyFirstDay, value as String);
        break;
      case keyTimeFormat:
        await _sharedPrefs.setString(keyTimeFormat, value as String);
        break;
      case keyBmi:
        await _sharedPrefs.setBool(keyBmi, value as bool);
        break;
      case keyDayReset:
        await _sharedPrefs.setInt(keyDayReset, value as int);
        break;
    }
    await _prefsCollection.doc('settings').set({key: value}, SetOptions(merge: true));
  }
}