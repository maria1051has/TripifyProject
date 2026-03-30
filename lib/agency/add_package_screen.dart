import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPackageScreen extends StatefulWidget {
  const AddPackageScreen({super.key});

  @override
  State<AddPackageScreen> createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController packageNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController travelDetailsController = TextEditingController();
  final TextEditingController foodDetailsController = TextEditingController();
  final TextEditingController hotelDetailsController = TextEditingController();
  final TextEditingController placesController = TextEditingController();
  final TextEditingController itineraryController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String packageType = 'Local'; // Dropdown default
  File? _packageImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _packageImage = File(image.path);
      });
    }
  }

  void _submitPackage() {
    if (_formKey.currentState!.validate()) {
      if (_packageImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a package image')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Package added successfully!')),
      );


      packageNameController.clear();
      priceController.clear();
      durationController.clear();
      travelDetailsController.clear();
      foodDetailsController.clear();
      hotelDetailsController.clear();
      placesController.clear();
      itineraryController.clear();
      notesController.clear();
      setState(() {
        _packageImage = null;
        packageType = 'Local';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Package'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: _packageImage == null
                      ? const Center(
                    child: Text(
                      'Tap to select package image',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(_packageImage!, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 24),


              const Text(
                'Basic Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: packageNameController,
                decoration: const InputDecoration(
                  labelText: 'Package Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter package name' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: packageType,
                items: const [
                  DropdownMenuItem(value: 'Local', child: Text('Local')),
                  DropdownMenuItem(value: 'International', child: Text('International')),
                ],
                onChanged: (value) => setState(() => packageType = value!),
                decoration: const InputDecoration(
                  labelText: 'Package Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price (BDT)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter price';
                  if (double.tryParse(value) == null) return 'Enter valid number';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (days)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter duration';
                  if (int.tryParse(value) == null) return 'Enter valid number';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              const Text('Travel Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: travelDetailsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Transportation / Timings',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter travel details' : null,
              ),
              const SizedBox(height: 24),

              const Text('Food Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: foodDetailsController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Meals Included',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter food details' : null,
              ),
              const SizedBox(height: 24),


              const Text('Hotel / Accommodation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: hotelDetailsController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Hotel Name / Room Type / Nights',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter hotel details' : null,
              ),
              const SizedBox(height: 24),


              const Text('Places / Sightseeing',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: placesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Places to Visit',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter places' : null,
              ),
              const SizedBox(height: 24),


              const Text('Day-wise Plan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: itineraryController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Activities for each day',
                  border: OutlineInputBorder(),
                  hintText: 'E.g., Day 1: Breakfast 8:00, Sightseeing 9:00...',
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter itinerary' : null,
              ),
              const SizedBox(height: 24),

              // --- Notes / Instructions ---
              const Text('Notes / Special Instructions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes / Terms / Policy',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitPackage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    'Add Package',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

