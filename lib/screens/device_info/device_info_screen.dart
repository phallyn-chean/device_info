import 'package:device_manager/services/device_info_service.dart';
import 'package:device_manager/widgets/info_widget.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  Map<String, dynamic> map = {};

  Future init() async {
    final deviceInfo = await DeviceInfoService.getInfo();

    if (!mounted) {
      return;
    }
    setState(() {
      map = deviceInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(map: map);
  }
}
