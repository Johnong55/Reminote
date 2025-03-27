import 'package:flutter/material.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/pages/HomePage.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminote',
      theme: lightMode,
      darkTheme: darkMode,
      home: Homepage(),
    );
  }
}