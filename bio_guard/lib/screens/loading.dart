import 'package:bio_guard/screens/homepage.dart';
import 'package:flutter/material.dart';
import '../services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var locationStatus = false;
  var wifiStatus = false;
  var permissionDenied = false;
  var infoText = "Enabling Location...";

  @override
  void initState() {
    mcuInterface();
    super.initState();
  }

  void mcuInterface() async {
    var networking = Networking();

    locationStatus = await networking.enableLocation();
    if (locationStatus) {
      setState(() {
        infoText = "Enabling WiFi...";
      });
    }

    wifiStatus = await networking.enableWifi();

    if (locationStatus && wifiStatus) {
      if (await networking.checkHost()) {
        if (await networking.connectHost()) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        } else {
          setState(() {
            infoText = "Can't connect to Host";
            permissionDenied = true;
          });
        }
      } else {
        setState(() {
          infoText = "Host not found";
          permissionDenied = true;
        });
      }
    } else {
      setState(() {
        infoText = "Enable Location and WiFi";
        permissionDenied = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.1),
            child: Text(
              infoText,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          (permissionDenied)
              ? Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        permissionDenied = false;
                      });
                      mcuInterface();
                    },
                    child: const Text("Try Again"),
                  ),
                )
              : SpinKitDoubleBounce(
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.15),
        ],
      ),
    );
  }
}
