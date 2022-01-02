import 'package:flutter/material.dart';
import 'package:bio_guard/auth.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String checkIn = "----";
  String checkOut = "-----";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BioGuard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(140.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Last Checked in At $checkIn',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                child: const Text('CHECK IN'),
                onPressed: () async {
                  bool isAuthenticated =
                      await Authentication.authenticateWithBiometrics();

                  if (isAuthenticated) {
                    setState(() {
                      checkIn = DateFormat("yyyy-MM-dd hh:mm:ss")
                          .format(DateTime.now());
                    });
                    print(checkIn);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      Authentication.customSnackBar(
                        content: 'Error authenticating using Biometrics.',
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Last Checked out At $checkOut',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                child: const Text('CHECK OUT'),
                onPressed: () async {
                  bool isAuthenticated =
                      await Authentication.authenticateWithBiometrics();

                  if (isAuthenticated) {
                    setState(() {
                      checkOut = DateFormat("yyyy-MM-dd hh:mm:ss")
                          .format(DateTime.now());
                    });

                    print(checkOut);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      Authentication.customSnackBar(
                        content: 'Error authenticating using Biometrics.',
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
