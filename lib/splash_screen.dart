import 'package:flutter/material.dart';
import 'dart:math';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _planeController;
  late AnimationController _mapController;

  late Animation<double> _planeAnimation;
  late Animation<double> _mapAnimation;

  final double planeSize = 80;

  @override
  void initState() {
    super.initState();

    // Plane animation (3 seconds)
    _planeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _planeAnimation =
        CurvedAnimation(parent: _planeController, curve: Curves.easeInOut);

    // Map animation (3 seconds)
    _mapController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _mapAnimation =
        CurvedAnimation(parent: _mapController, curve: Curves.easeOutBack);

    // Start plane animation
    _planeController.forward();

    // When plane finishes, start map animation
    _planeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _mapController.forward();
      }
    });

    // Navigate to home after map animation finishes
    _mapController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _planeController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  // Plane circular path
  Offset _planeOffset(Size size, double t) {
    final centerX = size.width / 2 - planeSize / 2;
    final centerY = size.height / 2 - planeSize / 2;

    final radius = min(size.width, size.height) * 0.35;

    final angle = 2 * pi * t;
    final progress = t <= 0.5 ? t * 2 : (1 - t) * 2; // out & back

    final x = centerX + radius * progress * cos(angle);
    final y = centerY + radius * progress * sin(angle);

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_planeAnimation, _mapAnimation]),
        builder: (context, child) {
          // Background color: teal during plane, fade to white during map
          Color bgColor = _mapAnimation.value == 0
              ? Colors.teal
              : Color.lerp(Colors.teal, Colors.white, _mapAnimation.value)!;

          return Container(
            color: bgColor,
            child: Stack(
              children: [
                // Map icon at center
                Center(
                  child: ScaleTransition(
                    scale: _mapAnimation,
                    child: Image.asset(
                      'assets/map.png',
                      width: 260,
                    ),
                  ),
                ),

                // Plane animation
                AnimatedBuilder(
                  animation: _planeAnimation,
                  builder: (context, child) {
                    final t = _planeAnimation.value;

                    // Hide plane after orbit
                    if (t >= 1.0) return const SizedBox();

                    final offset = _planeOffset(size, t);
                    final rotation = 0.5 * sin(2 * pi * t); // gentle swing

                    return Transform.translate(
                      offset: offset,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Image.asset(
                          'assets/plane.png',
                          width: planeSize + 50,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
