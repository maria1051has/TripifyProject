import 'package:flutter/material.dart';
import 'home_feed_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool showPlane = false;
  bool hidePlane = false;
  bool showMainText = false;
  bool showFinalText = false;
  bool showBus = false;

  @override
  void initState() {
    super.initState();


     Future.delayed(const Duration(milliseconds: 300), () {
       if (!mounted) return;
       setState(() => showPlane= true);

       });



    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() => hidePlane = true);
    });


    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      setState(() => showMainText = true);
    });


    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      setState(() => showFinalText = true);
    });


    Future.delayed(const Duration(milliseconds: 3700), () {
      if (!mounted) return;
      setState(() => showBus = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF008080),
      body: Stack(
        children: [

           AnimatedSlide(
               offset: showPlane ? Offset.zero: const Offset(0,1),
             duration: const Duration (milliseconds: 800),
             child: AnimatedOpacity(
               opacity: hidePlane? 0:1,
               duration: const Duration(milliseconds: 400),
               child: const Align(
                 alignment: Alignment.topCenter,
                 child: Icon(Icons.flight, color:Colors.white, size: 60),
               ),
             ),
           
           
           ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 AnimatedOpacity(
                     opacity:showMainText ? 1:0,
                   duration: const Duration(milliseconds: 600),
                    child: const Text(
                    'Explore Your Dream Destination!' ,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                   ),
                 ),
                const SizedBox(height: 8),
                AnimatedOpacity(
                  opacity: showFinalText ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  child: const Text(
                    'with us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                AnimatedSlide(
                  offset: showBus ? Offset.zero : const Offset(0, 1.5),
                  duration: const Duration(milliseconds: 800),
                  child: AnimatedOpacity(
                    opacity: showBus ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    child: const Icon(
                      Icons.directions_bus_filled,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                opacity: showFinalText ? 1 : 0,
                duration: const Duration(milliseconds: 600),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeFeedScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Explore Now >',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF008080),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}