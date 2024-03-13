import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus, PermissionStatusGetters;

class PermissionClient {
  const PermissionClient();

  Future<PermissionStatus> storageStatus() => Permission.storage.status;

  Future<PermissionStatus> requestStorage() => Permission.storage.request();

  Future<bool> openDeviceSettings() => openAppSettings();
}
