import 'package:flutter/material.dart';   // 👈 this import is required
import 'splash_screen.dart';
// import 'home_page.dart';  // <-- updated role selection page

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
      // Start app with SplashScreen
      home: const SplashScreen(),
    );
  }
}

