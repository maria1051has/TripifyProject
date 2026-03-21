import 'package:flutter/material.dart';

class ViewPackagesScreen extends StatelessWidget {
  const ViewPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> packages = [
      {
        'name': 'Cox\'s Bazar Trip',
        'price': '12000',
        'duration': '3',
        'image': 'assets/coxsbazar.png',
      },
      {
        'name': 'Sundarbans Adventure',
        'price': '15000',
        'duration': '4',
        'image': 'assets/sundarbans.png',
      },
      {
        'name': 'Sylhet Hills Tour',
        'price': '10000',
        'duration': '2',
        'image': 'assets/srimangal.png',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Explore Packages'),
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Row(
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.asset(
                    package['image']!,
                    width: 110,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              "${package['duration']} Days",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${package['price']} BDT",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18),
                              ),
                              onPressed: () {},
                              child: const Text("Edit"),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Delete"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

