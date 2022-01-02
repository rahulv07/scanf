import 'package:location/location.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:async';

class Networking {
  final _hostSSID = "Redmi Note 10 Pro";
  final _hostPWD = "VishnuVmv";

  //Function to enable location in the device
  Future<bool> enableLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  //Function to enable WiFi module in device
  Future<bool> enableWifi() async {
    if (!await WiFiForIoTPlugin.isEnabled()) {
      await WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
      await Future.delayed(const Duration(seconds: 5), () {});
      if (await WiFiForIoTPlugin.isEnabled()) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  //Function to check whether the host(NodeMCU) is present
  Future<bool> checkHost() async {
    var wifiList = await WiFiForIoTPlugin.loadWifiList();
    if (wifiList.isNotEmpty) {
      for (var wifi in wifiList) {
        if (wifi.ssid == _hostSSID) {
          return true;
        }
      }
    }
    return false;
  }

  //Function to connect to the host(NodeMCU)
  Future<bool> connectHost() async {
    var status = await WiFiForIoTPlugin.connect(_hostSSID,
        password: _hostPWD, security: NetworkSecurity.WPA);
    return status;
  }
}
