import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanf/screens/login7/login.dart';
import 'package:scanf/main.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;

  AuthenticationProvider(this.firebaseAuth);

  Stream<FirebaseUser> get authState => firebaseAuth.onAuthStateChanged;

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Authenticate();
      return "Signed in";
    } on AuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Authenticate();
      return "Signed up";
      // ignore: nullable_type_in_catch_clause
    } on AuthException catch (e) {
      return e.message;
    }
  }

  Future<String> uid() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
    return uid;
  }
}

class Authentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        biometricOnly: true,
      );
    }

    return isAuthenticated;
  }
}
