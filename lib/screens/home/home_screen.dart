import 'package:device_info_app/screens/device_info/application_info_screen.dart';
import 'package:device_info_app/screens/device_info/device_info_screen.dart';
import 'package:device_info_app/screens/device_info/network_info_screen.dart';
import 'package:device_info_app/services/platform_identify_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${PlatformIndentifyService.device}'s info"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Flutter Approach"),
              accountEmail: Text("Flutter@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/app-icon-1024x1024.png"),
              ),
            ),
            ListTile(
              selectedColor: Colors.blue,
              selected: index == 1,
              leading: const Icon(Icons.device_unknown_outlined),
              title: const Text("Device Info"),
              onTap: () {
                Navigator.of(context).pop();
                if (index != 1) {
                  setState(() {
                    index = 1;
                  });
                }
              },
            ),
            ListTile(
              selectedColor: Colors.blue,
              selected: index == 2,
              leading: const Icon(Icons.contact_support_outlined),
              title: const Text("Application Info"),
              onTap: () {
                Navigator.of(context).pop();
                if (index != 2) {
                  setState(() {
                    index = 2;
                  });
                }
              },
            ),
            ListTile(
              selectedColor: Colors.blue,
              selected: index == 3,
              leading: const Icon(Icons.network_check_outlined),
              title: const Text("Network Info"),
              onTap: () {
                Navigator.of(context).pop();
                if (index != 3) {
                  setState(() {
                    index = 3;
                  });
                }
              },
            )
          ],
        ),
      ),
      body: index == 1
          ? const DeviceInfoScreen()
          : index == 2
              ? const ApplicationInfoScreen()
              : index == 3
                  ? const NetworkInfoScreen()
                  : const Center(
                      child: Text(
                        "Hello there..!\nIf you can see this text you're genius. 😜",
                        textAlign: TextAlign.center,
                      ),
                    ),
    );
  }
}
