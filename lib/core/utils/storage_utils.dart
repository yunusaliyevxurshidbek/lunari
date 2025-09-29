import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageUtils {
  static Future<double> calculateSharedPreferencesSize() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final sharedPrefsDir = Directory('${appDocDir.path}/shared_prefs');

      if (!await sharedPrefsDir.exists()) return 0.0;

      double totalSize = 0;
      final List<FileSystemEntity> files = sharedPrefsDir.listSync();

      for (final file in files) {
        if (file is File && file.path.endsWith('.xml')) {
          totalSize += await file.length();
        }
      }

      return totalSize / (1024 * 1024);
    } catch (e) {
      print('Error calculating SharedPreferences size: $e');
      return 0.0;
    }
  }

  static Future<double> calculateAppCacheSize() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      return await _getDirectorySize(tempDir) / (1024 * 1024);
    } catch (e) {
      print('Error calculating cache size: $e');
      return 0.0;
    }
  }

  static Future<int> _getDirectorySize(Directory dir) async {
    int size = 0;

    if (await dir.exists()) {
      final List<FileSystemEntity> files = dir.listSync(recursive: true);

      for (final file in files) {
        if (file is File) {
          size += await file.length();
        }
      }
    }

    return size;
  }
}