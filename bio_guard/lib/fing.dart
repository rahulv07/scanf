import 'package:bio_guard/secret.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'auth.dart';
import 'custom_colors.dart';
class finge extends StatefulWidget {
  const finge({Key? key}) : super(key: key);

  @override
  _fingeState createState() => _fingeState();
}

class _fingeState extends State<finge> {

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
