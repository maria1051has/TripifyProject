import 'package:flutter/material.dart';
import 'splash_screen.dart';


void main() {
  runApp(const TripifyApp());
}

class TripifyApp extends StatelessWidget {
  const TripifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tripify',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
