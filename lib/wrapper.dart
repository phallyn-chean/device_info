import 'package:device_manager/screens/home/home_screen.dart';
import 'package:device_manager/services/network_info_service.dart';
import 'package:device_manager/services/platform_identify_service.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final PlatformIndentifyService platformIndentifyService = PlatformIndentifyService();
  final NetworkInfoService networkInfoService = NetworkInfoService();

  @override
  Widget build(BuildContext context) {
    networkInfoService.enablePlatformOverrideForDesktop();
    platformIndentifyService.getPlatformInit();
    return const HomeScreen();
  }
}
