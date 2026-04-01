import 'package:flutter/material.dart';
import 'facilities_screen.dart';

class HotelsScreen extends StatelessWidget {
  final String placeName;

  const HotelsScreen({Key? key, required this.placeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [];

    if (placeName == "Cox’s Bazar") {
      images = ["assets/cox1.jpg", "assets/cox2.jpg", "assets/cox3.jpg"];
    }
    else if (placeName == "Sundarbans") {
      images = ["assets/sundarbans1.jpg", "assets/sundarbans2.jpg", "assets/sundarbans3.jpg"];
    }
    else if (placeName == "Srimangal") {
      images = ["assets/srimangal1.jpg", "assets/srimangal2.jpg", "assets/srimangal3.jpg"];
    }
    else if (placeName == "Bandarban") {
      images = ["assets/bandarban1.jpg", "assets/bandarban2.jpg", "assets/bandarban3.jpg"];
    }
    else if (placeName == "Kuakata") {
      images = ["assets/kuakata1.jpg", "assets/kuakata2.jpg", "assets/kuakata3.jpg"];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Hotels"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Hotels in " + placeName, style: TextStyle(fontSize: 22)),

              SizedBox(height: 20),

              Text("Available Packages", style: TextStyle(fontSize: 18)),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacilitiesScreen(
                        packageName: "Package 1",
                        packagePrice: "৳4,000",
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [

                    Image.asset(images[0], width: 100, height: 100),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Package 1"),
                        Text("2 Nights • Breakfast Included"),
                        Text("৳4,000"),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacilitiesScreen(
                        packageName: "Package 2",
                        packagePrice: "৳6,000",
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [

                    Image.asset(images[1], width: 100, height: 100),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Package 2"),
                        Text("2 Nights • Breakfast + Dinner"),
                        Text("৳6,000"),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacilitiesScreen(
                        packageName: "Package 3",
                        packagePrice: "৳8,000",
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [

                    Image.asset(images[2], width: 100, height: 100),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Package 3"),
                        Text("3 Nights • Breakfast Included"),
                        Text("৳8,000"),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}