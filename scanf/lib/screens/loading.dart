import 'package:scanf/screens/homepage.dart';
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

  void updateInfo({required String infotext, bool isDenied = false}) {
    setState(() {
      infoText = infotext;
      permissionDenied = isDenied;
    });
  }

  void mcuInterface() async {
    var networking = Networking();

    locationStatus = await networking.enableLocation();
    if (locationStatus) {
      updateInfo(infotext: "Enabling wifi...");
    }

    wifiStatus = await networking.enableWifi();

    if (locationStatus && wifiStatus) {
      updateInfo(infotext: "Searching for host...");
      if (await networking.checkHost()) {
        if (await networking.connectHost()) {
          updateInfo(infotext: "Connecting to host...");

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        } else {
          updateInfo(infotext: "Can't connect to host", isDenied: true);
        }
      } else {
        updateInfo(infotext: "Host not found", isDenied: true);
      }
    } else {
      updateInfo(infotext: "Enable location and wifi", isDenied: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'scanF',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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
                  size: MediaQuery.of(context).size.width * 0.15,
                ),
        ],
      ),
    );
  }
}
