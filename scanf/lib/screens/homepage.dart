import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scanf/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFetching = true;
  late String checkIn;
  late String checkOut;
  late String date;
  late DataBase dataBase;

  Future<void> fetchInitialData() async {
    date = DateFormat('EEE, d-M-y').format(DateTime.now());
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    dataBase = DataBase(collection: date, userId: firebaseUser.uid);
    bool doesExist = await dataBase.exists();
    if (doesExist) {
      print("Exists\n\n");
      await dataBase.lastCheckIn().then((value) {
        setState(() {
          checkIn = value;
        });
      });
      await dataBase.lastCheckOut().then((value) {
        setState(() {
          checkOut = value;
          isFetching = false;
        });
      });
    } else {
      print("Not Exists\n\n");
      await dataBase.setData().then((value) {
        setState(() {
          checkIn = "";
          checkOut = "";
          isFetching = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchInitialData();
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
      body: (isFetching)
          ? SpinKitDoubleBounce(
              color: Colors.grey,
              size: MediaQuery.of(context).size.width * 0.15,
            )
          : Center(
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
                            bool isAuthenticated = await Authentication
                                .authenticateWithBiometrics();

                            if (isAuthenticated) {
                              setState(() {
                                checkIn = DateFormat("hh:mm a")
                                    .format(DateTime.now());
                              });
                              print(checkIn);
                              dataBase.writeCheckIn(timestamp: checkIn);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                Authentication.customSnackBar(
                                  content:
                                      'Error authenticating using Biometrics.',
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
                            bool isAuthenticated = await Authentication
                                .authenticateWithBiometrics();

                            if (isAuthenticated) {
                              setState(() {
                                checkOut = DateFormat("hh:mm a")
                                    .format(DateTime.now());
                              });
                              print(checkOut);
                              dataBase.writeCheckOut(timestamp: checkOut);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                Authentication.customSnackBar(
                                  content:
                                      'Error authenticating using Biometrics.',
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
