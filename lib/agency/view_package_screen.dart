import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPackagesScreen extends StatelessWidget {
  const ViewPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Packages")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("packages")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No packages added yet"));
          }

          final packages = snapshot.data!.docs;

          return ListView.builder(
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final data = packages[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['name'] ?? ""),
                  subtitle: Text(data['description'] ?? ""),
                  trailing: Text("\$${data['price'] ?? ""}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}