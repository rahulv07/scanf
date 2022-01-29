import 'package:bio_guard/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String checkIn = "";
  String checkOut = "";
  String date = DateFormat('EEE, d-M-y').format(DateTime.now());
  late DataBase dataBase;

  Future<void> initializeValues() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    dataBase = DataBase(collection: date, userId: firebaseUser.uid);
    await dataBase.setData();
  }

  @override
  void initState() {
    super.initState();
    initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BioGuard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(50),
              child: Text(
                date,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Text(
                    'In Time : $checkIn',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    child: const Text(
                      'CHECK IN',
                    ),
                    onPressed: () async {
                      bool isAuthenticated =
                          await Authentication.authenticateWithBiometrics();

                      if (isAuthenticated) {
                        setState(() {
                          checkIn =
                              DateFormat("hh:mm a").format(DateTime.now());
                        });
                        print(checkIn);
                        dataBase.checkIn(timestamp: checkIn);
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
            Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Text(
                    'Out Time : $checkOut',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    child: const Text('CHECK OUT'),
                    onPressed: () async {
                      bool isAuthenticated =
                          await Authentication.authenticateWithBiometrics();

                      if (isAuthenticated) {
                        setState(() {
                          checkOut =
                              DateFormat("hh:mm a").format(DateTime.now());
                        });
                        print(checkOut);
                        dataBase.checkOut(timestamp: checkOut);
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
            )
          ],
        ),
      ),
    );
  }
}
