import 'package:flutter/material.dart';

class VoyagerAccountScreen extends StatefulWidget {
  const VoyagerAccountScreen({super.key});

  @override
  State<VoyagerAccountScreen> createState() => _VoyagerAccountScreenState();
}

class _VoyagerAccountScreenState extends State<VoyagerAccountScreen> {
  // Example controllers for editable fields
  final TextEditingController nameController =
  TextEditingController(text: "Nazifa");
  final TextEditingController locationController =
  TextEditingController(text: "Dhaka, Bangladesh");
  final TextEditingController emailController =
  TextEditingController(text: "nazifa@example.com");
  final TextEditingController passwordController =
  TextEditingController(text: "••••••••");
  final TextEditingController jobController =
  TextEditingController(text: "UI Designer");

  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ white background
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
                // TODO: Implement logout logic
                Navigator.pop(context); // For now, just go back
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
}