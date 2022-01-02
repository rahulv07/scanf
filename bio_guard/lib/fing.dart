import 'package:bio_guard/secret.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'custom_colors.dart';

class Finge extends StatefulWidget {
  const Finge({Key? key}) : super(key: key);

  @override
  _FingeState createState() => _FingeState();
}

class _FingeState extends State<Finge> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                CustomColors.firebaseOrange,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () async {
              bool isAuthenticated =
                  await Authentication.authenticateWithBiometrics();

              if (isAuthenticated) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SecretVaultScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  Authentication.customSnackBar(
                    content: 'Error authenticating using Biometrics.',
                  ),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Access secret vault',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
