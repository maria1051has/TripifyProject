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
  final descriptionC = TextEditingController();
  bool isLoading = false;

  Future submit() async {
    if (nameC.text.isEmpty || priceC.text.isEmpty || descriptionC.text.isEmpty) {
      if (!mounted) return;
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
        "description": descriptionC.text,
        "createdAt": FieldValue.serverTimestamp(),
      });

      nameC.clear();
      priceC.clear();
      descriptionC.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Package Added ")),
      );

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewPackagesScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Package")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceC,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionC,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submit,
                child: const Text("Save & View"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}