import 'package:device_info_app/services/device_info_service.dart';
import 'package:device_info_app/services/ip_info_service.dart';
import 'package:device_info_app/services/package_info_service.dart';
import 'package:device_info_app/services/platform_identify_service.dart';
import 'package:device_info_app/widgets/info_widget.dart';
import 'package:flutter/material.dart';

class ApplicationInfoScreen extends StatefulWidget {
  const ApplicationInfoScreen({super.key});

  @override
  State<ApplicationInfoScreen> createState() => _ApplicationInfoScreenState();
}

class _ApplicationInfoScreenState extends State<ApplicationInfoScreen> {
  Map<String, dynamic> map = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final packageName = await PackageInfoService.getPackageName();
    final appVersion = await PackageInfoService.getAppVersion();
    final ipAddress = await IpInfoService.getIpAddress();
    final device = await DeviceInfoService.getDeviceInfo();
    final deviceVersion = await DeviceInfoService.getDeviceVersion();
    final operationSystem = PlatformIndentifyService.deviceType == DeviceType.isAndroid || PlatformIndentifyService.deviceType == DeviceType.isIos ? await DeviceInfoService.getOperationSystem() : 'Not Supported';
    final screenResolution = await DeviceInfoService.getScreenResolution();

    if (!mounted) {
      return;
    }
    setState(() {
      map = {
        "IP Adress": ipAddress,
        "Device": device,
        "Device OS Version": deviceVersion,
        "Operation System": operationSystem,
        "Screen Resolution": screenResolution,
        "": "",
        "App Version": appVersion,
        PlatformIndentifyService.deviceType == DeviceType.isAndroid ? 'Package Name' : 'Bundle ID': packageName,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(map: map);
  }
}
