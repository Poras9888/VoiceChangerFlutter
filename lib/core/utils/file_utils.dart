import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<Directory> documentsDir() => getApplicationDocumentsDirectory();

  static Future<String> buildOutputPath({required String fileName}) async {
    final dir = await documentsDir();
    return p.join(dir.path, fileName);
  }

  static Future<void> deleteIfExists(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
