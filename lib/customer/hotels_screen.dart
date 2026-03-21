import 'package:flutter/material.dart';
import 'facilities_screen.dart';

class ModernHomeScreen extends StatelessWidget {
  final String placeName;

  const ModernHomeScreen({
    super.key,
    required this.placeName,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> packages = [
      {
        "title": "Package 1",
        "details": "2 Nights • Breakfast Included",
        "price": "৳4,000",
        "popular": false,
        "image": "assets/package1.jpg",
      },
      {
        "title": "Package 2",
        "details": "2 Nights • Breakfast + Dinner",
        "price": "৳6,000",
        "popular": true,
        "image": "assets/package2.jpg",
      },
      {
        "title": "Package 3",
        "details": "3 Nights • Breakfast Included",
        "price": "৳8,000",
        "popular": false,
        "image": "assets/package3.jpg",
      },
      {
        "title": "Package 4",
        "details": "2 Nights • Sea View Room",
        "price": "৳6,000",
        "popular": false,
        "image": "assets/package4.jpg",
      },
      {
        "title": "Package 5",
        "details": "VIP Suite • 2 Nights",
        "price": "৳8,000",
        "popular": false,
        "image": "assets/package5.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          placeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hotels in $placeName",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),


            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/hotel1.jpg",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/hotel2.jpg",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Available Packages",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            const SizedBox(height: 20),


            ListView.builder(
              itemCount: packages.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final package = packages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPackageCard(
                    context,
                    package["title"],
                    package["details"],
                    package["price"],
                    package["popular"],
                    package["image"],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildPackageCard(
      BuildContext context,
      String title,
      String details,
      String price,
      bool isPopular,
      String imagePath,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FacilitiesScreen(
              packageName: title,
              packagePrice: price,
            ),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    if (isPopular)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Popular",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          details,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}