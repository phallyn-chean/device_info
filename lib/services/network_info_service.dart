import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkInfoService {
  void enablePlatformOverrideForDesktop() {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    }
  }

  static Future<Map<String, dynamic>> getNetworkInfo() async {
    String _connectionStatus = 'Unknown';
    final NetworkInfo _networkInfo = NetworkInfo();

    String? wifiName;
    String? wifiBSSID;
    String? wifiIPv4;
    String? wifiIPv6;
    String? wifiGatewayIP;
    String? wifiBroadcast;
    String? wifiSubmask;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways || status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else if (kIsWeb) {
        wifiName = 'Not Supported';
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (error) {
      developer.log("Failed to get Wifi Name", error: error);
      wifiName = "Failed to get Wifi Name";
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways || status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else if (kIsWeb) {
        wifiBSSID = "Not Supported";
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      if (kIsWeb) {
        wifiIPv4 = "Not Supported";
      } else {
        wifiIPv4 = await _networkInfo.getWifiIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get wifi IPv4', error: e);
      wifiIPv4 = "Failed to get wifi IPv4";
    }

    try {
      if (kIsWeb) {
        wifiIPv6 = "Not Supported";
      } else {
        wifiIPv6 = await _networkInfo.getWifiIPv6();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get wifi IPv6', error: e);
      wifiIPv6 = "Failed to get wifi IPv6";
    }

    try {
      if (kIsWeb) {
        wifiSubmask = "Not Supported";
      } else {
        wifiSubmask = await _networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get wifi submask address', error: e);
      wifiSubmask = "Failed to get wifi submask address";
    }

    try {
      if (kIsWeb) {
        wifiBroadcast = "Not Supported";
      } else {
        wifiBroadcast = await _networkInfo.getWifiBroadcast();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get wifi Broadcast', error: e);
      wifiBroadcast = "Failed to get wifi broadcast";
    }

    try {
      if (kIsWeb) {
        wifiGatewayIP = "Not Supported";
      } else {
        wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get wifi gateway address', error: e);
      wifiGatewayIP = "Failed to get wifi gatewat address";
    }

    try {
      if (kIsWeb) {
        wifiSubmask = "Not Supported";
      } else {
        wifiSubmask = await _networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask', error: e);
      wifiSubmask = "Failed to get Wifi submask";
    }

    return {
      'connectionStatus': _connectionStatus,
      'wifiName': wifiName,
      'wifiBSSID': wifiBSSID,
      'wifiIPv4': wifiIPv4,
      'wifiIPv6': wifiIPv6,
      'wifiGatewayIP': wifiGatewayIP,
      'wifiBroadcast': wifiBroadcast,
      'wifiSubmask': wifiSubmask,
    };
  }
}
