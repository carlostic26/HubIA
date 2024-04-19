import 'package:permission_handler/permission_handler.dart';

class RequestPermissions {
  final Permission _cameraPermission = Permission.camera;
  final Permission _storagePermission = Permission.storage;

  Future<bool> requestCameraPermission() async {
    var result = await _cameraPermission.request();
    return result.isGranted;
  }

  Future<bool> requestStoragePermission() async {
    var result = await _storagePermission.request();
    return result.isGranted;
  }

  Future<bool> requestAllPermissions() async {
    var cameraRequestResult = await requestCameraPermission();
    var storageRequestResult = await requestStoragePermission();

    return cameraRequestResult && storageRequestResult;
  }
}
