import 'package:flutter/material.dart';
import 'booking_page.dart';

class FacilitiesScreen extends StatefulWidget {
  final String packageName;
  final String packagePrice;

  const FacilitiesScreen({
    super.key,
    required this.packageName,
    required this.packagePrice,
  });

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.packageName),
        centerTitle: true,
      ),

      body: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Text("Hotels"),
              ),

              TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Text("Food"),
              ),

              TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Text("Transportation"),
              ),

              TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
                child: Text("Time Table"),
              ),
            ],
          ),

          Divider(),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (selectedIndex == 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Luxury Room"),
                        SizedBox(height: 5),
                        Text("Sea view • AC • WiFi"),
                        SizedBox(height: 5),
                        Text("৳10,000"),
                      ],
                    ),

                  if (selectedIndex == 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Food Arrangement"),
                        SizedBox(height: 5),
                        Text("Breakfast, Lunch, Dinner Included"),
                      ],
                    ),

                  if (selectedIndex == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mini Bus"),
                        SizedBox(height: 5),
                        Text("AC • 20 seats capacity"),
                      ],
                    ),

                  if (selectedIndex == 3)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time Schedule"),
                        SizedBox(height: 5),
                        Text("Breakfast (7:30 - 8:30)am"),
                        Text("Travel (10:00 - 2:30)am"),
                        Text("Lunch Break (2:30-3:30)pm"),
                        Text("Travel (4:00-8:00)pm"),
                        Text("Dinner (8:00-9:00)pm"),
                      ],
                    ),

                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(
                      packageName: widget.packageName,
                      packagePrice: widget.packagePrice,
                    ),
                  ),
                );
              },
              child: Text("Select Package"),
            ),
          ),

        ],
      ),
    );
  }
}