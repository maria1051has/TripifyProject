import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'view_package_screen.dart';

class AddPackagePage extends StatefulWidget {
  const AddPackagePage({super.key});

  @override
  State<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final imageC = TextEditingController();
  final durationC = TextEditingController();
  final startFromC = TextEditingController();
  final placeC = TextEditingController();

  bool isLoading = false;

  Future submit() async {
    if (nameC.text.isEmpty ||
        priceC.text.isEmpty ||
        imageC.text.isEmpty ||
        durationC.text.isEmpty ||
        startFromC.text.isEmpty ||
        placeC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection("packages").add({
        "name": nameC.text,
        "price": priceC.text,
        "image": imageC.text,
        "duration": durationC.text,
        "startFrom": startFromC.text,
        "place": placeC.text,
        "createdAt": FieldValue.serverTimestamp(),
      });

      nameC.clear();
      priceC.clear();
      imageC.clear();
      durationC.clear();
      startFromC.clear();
      placeC.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Package Added Successfully")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewPackagesScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget input(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Travel Package")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                input(nameC, "Package Name"),
                input(priceC, "Price"),
                input(imageC, "Image URL"),
                input(durationC, "Duration (e.g. 3 Days)"),
                input(startFromC, "Start From"),
                input(placeC, "Destination Place"),

                const SizedBox(height: 20),

                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Save Package"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}