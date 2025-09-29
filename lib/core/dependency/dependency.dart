import 'package:shared_preferences/shared_preferences.dart';

class AppDependency {
  AppDependency({
    required this.locale,
    required this.shp,
    required this.theme,
    // required this.dio,
  });

  String locale;
  bool theme ;

  final SharedPreferences shp;
  // final Dio dio;
}
