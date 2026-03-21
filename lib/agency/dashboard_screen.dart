import 'package:flutter/material.dart';
import 'add_package_screen.dart';
import 'view_package_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String agencyName = "Dream Travels";
  String email = "dream@agency.com";
  String phone = "+880123456789";
  String address = "Dhaka, Bangladesh";
  bool isVerified = true;


  int totalPackages = 5;
  int verifiedPackages = 3;
  int pendingPackages = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agency Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.business, size: 60, color: Colors.teal),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            agencyName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(email, style: TextStyle(color: Colors.grey[700])),
                          Text(phone, style: TextStyle(color: Colors.grey[700])),
                          Text(address, style: TextStyle(color: Colors.grey[700])),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                isVerified ? Icons.verified : Icons.hourglass_top,
                                color: isVerified ? Colors.green : Colors.orange,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isVerified ? 'Verified' : 'Pending Verification',
                                style: TextStyle(
                                    color: isVerified ? Colors.green : Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.teal),
                      onPressed: () {
                        _showEditProfileSheet();
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),


            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _summaryCard('Total Packages', totalPackages, Icons.card_travel, Colors.teal),
                  _summaryCard('Verified', verifiedPackages, Icons.check_circle, Colors.green),
                  _summaryCard('Pending', pendingPackages, Icons.pending_actions, Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Add Package',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddPackageScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.list, color: Colors.white),
                    label: const Text(
                      'View Packages',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ViewPackagesScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _summaryCard(String title, int value, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value.toString(),
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }


  void _showEditProfileSheet() {
    TextEditingController nameController = TextEditingController(text: agencyName);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneController = TextEditingController(text: phone);
    TextEditingController addressController = TextEditingController(text: address);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Agency Name')),
              const SizedBox(height: 8),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              const SizedBox(height: 8),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone')),
              const SizedBox(height: 8),
              TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Address')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    agencyName = nameController.text;
                    email = emailController.text;
                    phone = phoneController.text;
                    address = addressController.text;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}