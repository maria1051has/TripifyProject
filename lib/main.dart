import 'package:flutter/material.dart';
import 'splash_screen.dart';
  nazifa-feature
// import 'home_page.dart';  // <-- updated role selection page
 
import 'package:firebase_core/firebase_core.dart';

 main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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

