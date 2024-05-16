import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:device_manager/services/platform_identify_service.dart';

class DeviceInfoService {
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getOperationSystem() async {
    return Platform.operatingSystem;
  }

  static Future<String> getScreenResolution() async {
    // ignore: deprecated_member_use
    return '${window.physicalGeometry.width} X ${window.physicalGeometry.height}';
  }

  static Future<String> getDeviceInfo() async {
    if (PlatformIndentifyService.deviceType == DeviceType.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;

      return "${info.manufacturer} - ${info.model}";
    } else if (PlatformIndentifyService.deviceType == DeviceType.isIos) {
      final info = await _deviceInfoPlugin.iosInfo;

      return "${info.name} ${info.model}";
    } else if (PlatformIndentifyService.deviceType == DeviceType.isWindows) {
      final info = await _deviceInfoPlugin.windowsInfo;

      return info.computerName;
    } else if (PlatformIndentifyService.deviceType == DeviceType.isWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;

      return "${info.browserName}";
    } else if (PlatformIndentifyService.deviceType == DeviceType.isMacOS) {
      final info = await _deviceInfoPlugin.macOsInfo;

      return "${info.computerName} - ${info.hostName}";
    } else if (PlatformIndentifyService.deviceType == DeviceType.isLinux) {
      final info = await _deviceInfoPlugin.linuxInfo;

      return "${info.name} ${info.prettyName}";
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceVersion() async {
    if (PlatformIndentifyService.deviceType == DeviceType.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;

      return info.version.sdkInt.toString();
    } else if (PlatformIndentifyService.deviceType == DeviceType.isIos) {
      final info = await _deviceInfoPlugin.iosInfo;

      return info.systemVersion;
    } else if (PlatformIndentifyService.deviceType == DeviceType.isWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;

      return info.browserName.toString();
    } else if (PlatformIndentifyService.deviceType == DeviceType.isWindows) {
      final info = await _deviceInfoPlugin.windowsInfo;

      return "${info.numberOfCores} Cores";
    } else if (PlatformIndentifyService.deviceType == DeviceType.isMacOS) {
      final info = await _deviceInfoPlugin.macOsInfo;

      return info.kernelVersion;
    } else if (PlatformIndentifyService.deviceType == DeviceType.isLinux) {
      final info = await _deviceInfoPlugin.linuxInfo;

      return info.version!;
    } else {
      throw UnimplementedError();
    }
  }

  static Future<Map<String, dynamic>> getInfo() async {
    try {
      if (PlatformIndentifyService.deviceType == DeviceType.isAndroid) {
        final info = await _deviceInfoPlugin.androidInfo;

        return _readAndroidBuildData(info);
      } else if (PlatformIndentifyService.deviceType == DeviceType.isIos) {
        final info = await _deviceInfoPlugin.iosInfo;

        return _readIosDeviceInfo(info);
      } else if (PlatformIndentifyService.deviceType == DeviceType.isWeb) {
        final info = await _deviceInfoPlugin.webBrowserInfo;

        return _readWebBrowserInfo(info);
      } else if (PlatformIndentifyService.deviceType == DeviceType.isWindows) {
        final info = await _deviceInfoPlugin.windowsInfo;

        return _readWindowsDeviceInfo(info);
      } else if (PlatformIndentifyService.deviceType == DeviceType.isMacOS) {
        final info = await _deviceInfoPlugin.macOsInfo;

        return _readMacOsDeviceInfo(info);
      } else if (PlatformIndentifyService.deviceType == DeviceType.isLinux) {
        final info = await _deviceInfoPlugin.linuxInfo;

        return _readLinuxDeviceInfo(info);
      } else {
        throw UnimplementedError();
      }
    } on PlatformException {
      return <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo info) {
    return <String, dynamic>{
      'device': info.device,
      'brand': info.brand,
      'isPhysicalDevice': info.isPhysicalDevice,
      'version.sdkInt': info.version.sdkInt,
      'manufacturer': info.manufacturer,
      'model': info.model,
      '': '',
      ' ': '',
      'version.securityPatch': info.version.securityPatch,
      'version.release': info.version.release,
      'version.previewSdkInt': info.version.previewSdkInt,
      'version.incremental': info.version.incremental,
      'version.codename': info.version.codename,
      'version.baseOS': info.version.baseOS,
      'board': info.board,
      'bootloader': info.bootloader,
      'display': info.display,
      'fingerprint': info.fingerprint,
      'hardware': info.hardware,
      'host': info.host,
      'id': info.id,
      'product': info.product,
      'supported32BitAbis': info.supported32BitAbis,
      'supported64BitAbis': info.supported64BitAbis,
      'supportedAbis': info.supportedAbis,
      'tage': info.tags,
      'type': info.type,
      'systemFeatures': info.systemFeatures,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    return <String, dynamic>{
      'name': info.name,
      'systemName': info.systemName,
      'systemVersion': info.systemVersion,
      'model': info.model,
      'localizedModel': info.localizedModel,
      'identifierForVendor': info.identifierForVendor,
      'isPhysicalDevice': info.isPhysicalDevice,
      'utsname.sysname:': info.utsname.sysname,
      'utsname.nodename:': info.utsname.nodename,
      'utsname.release:': info.utsname.release,
      'utsname.version:': info.utsname.version,
      'utsname.machine:': info.utsname.machine,
    };
  }

  static Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo info) {
    return <String, dynamic>{
      'name': info.name,
      'version': info.version,
      'id': info.id,
      'idLike': info.idLike,
      'versionCodename': info.versionCodename,
      'versionId': info.versionId,
      'prettyName': info.prettyName,
      'buildId': info.buildId,
      'variant': info.variant,
      'variantId': info.variantId,
      'machineId': info.machineId,
    };
  }

  static Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo info) {
    return <String, dynamic>{
      'browserName': info.browserName.name,
      'appCodeName': info.appCodeName,
      'appName': info.appName,
      'appVersion': info.appVersion,
      'deviceMemory': info.deviceMemory,
      'language': info.language,
      'languages': info.languages,
      'platform': info.platform,
      'product': info.product,
      'productSub': info.productSub,
      'userAgent': info.userAgent,
      'vendor': info.vendor,
      'vendorSub': info.vendorSub,
      'hardwareConcurrency': info.hardwareConcurrency,
      'maxTouchPoints': info.maxTouchPoints,
    };
  }

  static Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo info) {
    return <String, dynamic>{
      'computerName': info.computerName,
      'hostName': info.hostName,
      'arch': info.arch,
      'model': info.model,
      'kernelVersion': info.kernelVersion,
      'majorVersion': info.majorVersion,
      'minorVersion': info.minorVersion,
      'patchVersion': info.patchVersion,
      'osRelease': info.osRelease,
      'activeCPUs': info.activeCPUs,
      'memorySize': info.memorySize,
      'cpuFrequency': info.cpuFrequency,
      'systemGUID': info.systemGUID,
    };
  }

  static Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo info) {
    return <String, dynamic>{
      'numberOfCores': info.numberOfCores,
      'computerName': info.computerName,
      'systemMemoryInMegabytes': info.systemMemoryInMegabytes,
      'userName': info.userName,
      'majorVersion': info.majorVersion,
      'minorVersion': info.minorVersion,
      'buildNumber': info.buildNumber,
      'platformId': info.platformId,
      'csdVersion': info.csdVersion,
      'servicePackMajor': info.servicePackMajor,
      'servicePackMinor': info.servicePackMinor,
      'suitMask': info.suitMask,
      'productType': info.productType,
      'reserved': info.reserved,
      'buildLab': info.buildLab,
      'buildLabEx': info.buildLabEx,
      'digitalProductId': info.digitalProductId,
      'displayVersion': info.displayVersion,
      'editionId': info.editionId,
      'installDate': info.installDate,
      'productId': info.productId,
      'productName': info.productName,
      'registeredOwner': info.registeredOwner,
      'releaseId': info.releaseId,
      'deviceId': info.deviceId,
    };
  }
}
