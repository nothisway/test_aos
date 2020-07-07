import 'package:permission_handler/permission_handler.dart';

Map<Permission, PermissionStatus> permissions;

Future<Map<Permission, PermissionStatus>> getPermission() async {
  permissions = await [
    Permission.location,
    Permission.locationWhenInUse,
    Permission.locationAlways,
    Permission.camera,
    Permission.storage,
  ].request();
  print(permissions[Permission.location]);
  return permissions;
}

Future<bool> checkPermission() async {
  bool check = false;
  PermissionStatus permissionLocation = await Permission.location.status;
  PermissionStatus permissionCamera = await Permission.camera.status;
  PermissionStatus permissionStorage = await Permission.storage.status;

  if (permissionLocation == PermissionStatus.granted &&
      permissionCamera == PermissionStatus.granted &&
      permissionStorage == PermissionStatus.granted) {
    check = true;
  }
  return check;
}