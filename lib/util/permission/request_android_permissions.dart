import 'package:permission_handler/permission_handler.dart';

class RequestAndroidPermissions {
  static Future<bool> requestPermissions(List<Permission> permissions) async {
    final Map<Permission, PermissionStatus> statuses =
        await permissions.request();
    for (var status in statuses.values) {
      if (status.isDenied || status.isPermanentlyDenied) {
        // 권한이 거부되었거나 영구적으로 거부된 경우
        return Future.value(false);
      }
    }
    // 모든 권한이 허용된 경우
    return Future.value(true);
  }
}
