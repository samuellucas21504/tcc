import 'package:flutter/material.dart';
import 'package:tcc/constants/themes.dart';
import 'package:tcc/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.main,
      home: const Home(),
    );
  }
}
