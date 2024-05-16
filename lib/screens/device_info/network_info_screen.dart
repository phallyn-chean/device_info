import 'package:device_manager/services/network_info_service.dart';
import 'package:device_manager/widgets/info_widget.dart';
import 'package:flutter/material.dart';

class NetworkInfoScreen extends StatefulWidget {
  const NetworkInfoScreen({super.key});

  @override
  State<NetworkInfoScreen> createState() => _NetworkInfoScreenState();
}

class _NetworkInfoScreenState extends State<NetworkInfoScreen> {
  Map<String, dynamic> map = {};

  Future init() async {
    final networkInfo = await NetworkInfoService.getNetworkInfo();

    if (!mounted) {
      return;
    }

    setState(() {
      map = networkInfo;
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
