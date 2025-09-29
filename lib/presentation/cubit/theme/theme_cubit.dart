import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefKey = 'theme_mode';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(_loadFromPrefs(_prefs));

  static ThemeMode _loadFromPrefs(SharedPreferences prefs) {
    final str = prefs.getString(_prefKey) ?? 'system';
    return {
      'light': ThemeMode.light,
      'dark': ThemeMode.dark,
      'system': ThemeMode.system,
    }[str]!;
  }

  Future<void> _saveToPrefs(ThemeMode mode) async {
    final str = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
        ? 'dark'
        : 'system';
    await _prefs.setString(_prefKey, str);
  }

  void setLight() {
    emit(ThemeMode.light);
    _saveToPrefs(ThemeMode.light);
  }

  void setDark() {
    emit(ThemeMode.dark);
    _saveToPrefs(ThemeMode.dark);
  }

  void setSystem() {
    emit(ThemeMode.system);
    _saveToPrefs(ThemeMode.system);
  }
}
