// @dart=2.9
import 'package:scanf/screens/homepage.dart';
import 'package:scanf/screens/loading.dart';
import 'package:scanf/screens/login7/login.dart';
import 'package:flutter/material.dart';
//import 'screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth.dart';
import 'screens/login7/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        )
      ],
      child: MaterialApp(
          title: 'Firebase Authentication',
          home: Authenticate(),
          debugShowCheckedModeBanner: false),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<FirebaseUser>();

    if (firebaseUser != null) {
      return LoadingPage();
    }
    return const Login7();
  }
}
