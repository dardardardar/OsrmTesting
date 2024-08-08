import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class Info {
  String os;
  String appName;
  String device;
  Info({
    required this.os,
    required this.appName,
    required this.device,
  });
}

class DeviceInfo {
  static DeviceInfoPlugin? deviceInfoPlugin;
  Future<Info> getInfo() async {
    if (deviceInfoPlugin == null) {
      return Info(os: 'Test', appName: 'APP_ENV_NAME', device: 'device');
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfoPlugin!.androidInfo;
      return Info(
          os: androidInfo.version.release,
          appName: 'APP_ENV_NAME',
          device: androidInfo.device);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfoPlugin!.iosInfo;
      return Info(
          os: iosInfo.systemName,
          appName: 'APP_ENV_NAME',
          device: iosInfo.model);
    } else {
      return Info(os: 'Test', appName: 'APP_ENV_NAME', device: 'Device Test');
    }
  }

  Future<String> getUserAgent() async {
    Info info = await getInfo();
    return '${info.appName} ${info.device} ${info.os}';
  }
}
