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
          style: TextStyle(color:Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.business, size: 50, color: Colors.teal),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(agencyName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(email),
                    Text(phone),
                    Text(address),
                    Row(
                      children: [
                        Icon(isVerified ? Icons.verified : Icons.hourglass_top, size: 18, color: isVerified ? Colors.green : Colors.orange),
                        SizedBox(width: 5),
                        Text(isVerified ? "Verified" : "Pending", style: TextStyle(color: isVerified ? Colors.green : Colors.orange)),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                TextButton(onPressed: _editProfile, child: Text("Edit")),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [Text("Total Packages"), Text(totalPackages.toString())]),
                Column(children: [Text("Verified Packages"), Text(verifiedPackages.toString())]),
                Column(children: [Text("Pending Packages"), Text(pendingPackages.toString())]),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => AddPackageScreen()));
                    },
                    child: Text("Add Package"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ViewPackagesScreen()));
                    },
                    child: Text("View Packages"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: agencyName);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneController = TextEditingController(text: phone);
    TextEditingController addressController = TextEditingController(text: address);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController),
              TextField(controller: emailController),
              TextField(controller: phoneController),
              TextField(controller: addressController),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                setState(() {
                  agencyName = nameController.text;
                  email = emailController.text;
                  phone = phoneController.text;
                  address = addressController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}