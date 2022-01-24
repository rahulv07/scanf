// @dart=2.9
import 'package:bio_guard/screens/loading.dart';
import 'package:bio_guard/screens/login7/login.dart';
import 'package:flutter/material.dart';
//import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login7(),
    );
  }
}
