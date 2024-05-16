import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

enum DeviceType {
  isAndroid,
  isIos,
  isWindows,
  isMacOS,
  isWeb,
  isLinux,
  isFuchsia,
  isUnknown,
}

class PlatformIndentifyService {
  static late DeviceType deviceType;
  static late String device;

  void getPlatformInit() {
    if (kIsWeb) {
      deviceType = DeviceType.isWeb;
      device = "Web";
    } else {
      if (Platform.isAndroid) {
        deviceType = DeviceType.isAndroid;
        device = "Android";
      } else if (Platform.isIOS) {
        deviceType = DeviceType.isIos;
        device = "IOS";
      } else if (Platform.isWindows) {
        deviceType = DeviceType.isWindows;
        device = "Windows";
      } else if (Platform.isMacOS) {
        deviceType = DeviceType.isMacOS;
        device = "MacOS";
      } else if (Platform.isLinux) {
        deviceType = DeviceType.isLinux;
        device = "Linux";
      } else if (Platform.isFuchsia) {
        deviceType = DeviceType.isFuchsia;
        device = "Fuchsia";
      } else {
        deviceType = DeviceType.isUnknown;
        device = "Unknown";
      }
    }
  }
}
