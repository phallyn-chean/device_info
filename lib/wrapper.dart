import 'package:device_info_app/screens/home/home_screen.dart';
import 'package:device_info_app/services/network_info_service.dart';
import 'package:device_info_app/services/platform_identify_service.dart';
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
