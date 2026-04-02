import 'package:flutter/material.dart';
import 'facilities_screen.dart';
import 'package:flutter/material.dart';
import 'facilities_screen.dart';

class HotelsScreen extends StatelessWidget {
  final String placeName;

  const HotelsScreen({Key? key, required this.placeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [];

    if (placeName == "Cox’s Bazar") {
      images = ["assets/coxsbazar.png", "assets/coxsbazar.png"];
    } else if (placeName == "Sundarbans") {
      images = ["assets/sundarbans.png", "assets/sundarbans.png"];
    } else if (placeName == "Srimangal") {
      images = ["assets/srimangal.png", "assets/srimangal.png"];
    } else if (placeName == "Bandarban") {
      images = ["assets/bandarban.png", "assets/bandarban.png"];
    } else if (placeName == "Kuakata") {
      images = ["assets/kuakata.png", "assets/kuakata.png"];
    }

    String getImage(int index) {
      if (images.length > index) {
        return images[index];
      }
      return "assets/package1.jpg";
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
              Text("Hotels in $placeName", style: TextStyle(fontSize: 22)),
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
                    Image.asset(getImage(0), width: 100, height: 100, fit: BoxFit.cover),
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
                    Image.asset(getImage(1), width: 100, height: 100, fit: BoxFit.cover),
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
            ],
          ),
        ),
      ),
    );
  }
}
