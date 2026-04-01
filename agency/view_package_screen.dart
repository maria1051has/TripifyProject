import 'package:flutter/material.dart';

class ViewPackagesScreen extends StatelessWidget {
  const ViewPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy package data
    final List<Map<String, String>> packages = [
      {
        'name': 'Cox\'s Bazar Trip',
        'price': '12000',
        'duration': '3',
        'image': 'assets/sample_package1.jpg',
      },
      {
        'name': 'Sundarbans Adventure',
        'price': '15000',
        'duration': '4',
        'image': 'assets/sample_package2.jpg',
      },
      {
        'name': 'Sylhet Hills Tour',
        'price': '10000',
        'duration': '2',
        'image': 'assets/sample_package3.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Packages'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Package Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  child: Image.asset(
                    package['image']!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                // Package Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package['name']!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Price: ${package['price']} BDT',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Duration: ${package['duration']} days',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                // TODO: Connect to Edit Package screen later
                              },
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text('Edit'),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // TODO: Connect Delete functionality later
                              },
                              icon: const Icon(Icons.delete, size: 16),
                              label: const Text('Delete'),
                            ),
                          ],
                        ),
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
