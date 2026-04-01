import 'package:flutter/material.dart';
import 'booking_page.dart';

class FacilitiesScreen extends StatefulWidget {
  final String packageName;
  final String packagePrice;

  const FacilitiesScreen({
    Key? key,
    required this.packageName,
    required this.packagePrice,
  }) : super(key: key);

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {

  int selectedIndex = 0;

  final List<String> categories = [
    "Hotels",
    "Food",
    "Transportation",
    "Time Table"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.packageName),
        centerTitle: true,
      ),
      body: Column(
        children: [

          // CATEGORY BAR
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          categories[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.teal
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (selectedIndex == index)
                          Container(
                            margin:
                            const EdgeInsets.only(top: 5),
                            height: 3,
                            width: 40,
                            color: Colors.teal,
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // CONTENT AREA
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildContent(),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
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
              child: const Text(
                "Select Package",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return _section("Luxury Room", "Sea view • AC • WiFi", "৳12,000");
      case 1:
        return _section("Food Arrangement",
            "Breakfast, Lunch, Dinner Included");
      case 2:
        return _section("Mini Bus",
            "AC • 20 seats capacity");
      case 3:
        return _section("Time Schedule",
            "Breakfast 7:30 - 8:30\nTravel 10:00 - 2:30");
      default:
        return const SizedBox();
    }
  }

  Widget _section(String title, String subtitle,
      [String? price]) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: price != null ? Text(price) : null,
      ),
    );
  }
}