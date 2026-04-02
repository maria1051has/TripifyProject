import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoyagerAccountScreen extends StatefulWidget {
  const VoyagerAccountScreen({super.key});

  @override
  State<VoyagerAccountScreen> createState() => _VoyagerAccountScreenState();
}

class _VoyagerAccountScreenState extends State<VoyagerAccountScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  double rating = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    User? user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('voyagers').doc(user.uid).snapshots().listen((snapshot) {
        if (snapshot.exists) {
          setState(() {
            nameController.text = snapshot['name'] ?? "";
            locationController.text = snapshot['location'] ?? "";
            emailController.text = snapshot['email'] ?? "";
            jobController.text = snapshot['job'] ?? "";
            rating = (snapshot['rating'] ?? 0).toDouble();
          });
        }
      });
    }
  }

  void _saveData() {
    User? user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('voyagers').doc(user.uid).set({
        'name': nameController.text,
        'location': locationController.text,
        'email': emailController.text,
        'job': jobController.text,
        'rating': rating,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Voyager Account"),
        backgroundColor: const Color(0xFF008080),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: ListView(
          children: [

            Text("Account Information"),
            SizedBox(height: 20),

            Text("Name"),
            TextField(
              controller: nameController,
              onChanged: (value) => _saveData(),
            ),

            SizedBox(height: 10),

            Text("Location"),
            TextField(
              controller: locationController,
              onChanged: (value) => _saveData(),
            ),

            SizedBox(height: 10),

            Text("Email"),
            TextField(
              controller: emailController,
              onChanged: (value) => _saveData(),
            ),

            SizedBox(height: 10),

            Text("Password"),
            TextField(
              controller: passwordController,
              obscureText: true,
            ),

            SizedBox(height: 10),

            Text("Occupation"),
            TextField(
              controller: jobController,
              onChanged: (value) => _saveData(),
            ),

            SizedBox(height: 30),

            Text("Feedback & Rating"),
            SizedBox(height: 10),

            TextField(
              maxLines: 3,
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Text("Rate: "),
                Expanded(
                  child: Slider(
                    value: rating,
                    min: 0,
                    max: 5,
                    onChanged: (value) {
                      setState(() {
                        rating = value;
                      });
                      _saveData();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
              child: Text("Log Out"),
            ),

          ],
        ),
      ),
    );
  }
}
/*
class VoyagerAccountScreen extends StatefulWidget {
  const VoyagerAccountScreen({super.key});

  @override
  State<VoyagerAccountScreen> createState() => _VoyagerAccountScreenState();
}

class _VoyagerAccountScreenState extends State<VoyagerAccountScreen> {
  final TextEditingController nameController =
  TextEditingController(text: "Afia");
  final TextEditingController locationController =
  TextEditingController(text: "Dhaka, Bangladesh");
  final TextEditingController emailController =
  TextEditingController(text: "afiasundarbans2suna@example.com");
  final TextEditingController passwordController =
  TextEditingController(text: "••••••••");
  final TextEditingController jobController =
  TextEditingController(text: "UI Designer");

  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Voyager Account"),
        backgroundColor: const Color(0xFF008080),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Account Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildEditableField("Name", nameController),
            _buildEditableField("Location", locationController),
            _buildEditableField("Email", emailController),
            _buildEditableField("Password", passwordController, obscure: true),
            _buildEditableField("Occupation", jobController),

            const SizedBox(height: 30),
            const Text(
              "Feedback & Rating",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                hintText: "Share your feedback...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                const Text("Rate our app: "),
                Expanded(
                  child: Slider(
                    value: rating,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: rating.toString(),
                    onChanged: (val) {
                      setState(() => rating = val);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Log Out",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}*/