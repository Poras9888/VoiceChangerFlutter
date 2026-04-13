import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestMicrophone() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }
}
