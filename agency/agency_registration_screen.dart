import 'dart:io';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

import 'package:image_picker/image_picker.dart'; // For document uploads

class AgencyRegistrationScreen extends StatefulWidget {
  const AgencyRegistrationScreen({super.key});

  @override
  State<AgencyRegistrationScreen> createState() =>
      _AgencyRegistrationScreenState();
}

class _AgencyRegistrationScreenState extends State<AgencyRegistrationScreen> {
  int _currentStep = 0;

  // Step 1: Basic Info
  final TextEditingController agencyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Step 2: Owner Info
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerNIDController = TextEditingController();
  final TextEditingController ownerPhoneController = TextEditingController();

  // Step 3: Legal Documents
  File? tradeLicense;
  File? tourismLicense;
  File? tinCertificate;
  File? bankProof;
  File? agencyLogo;

  final ImagePicker _picker = ImagePicker();

  // Form keys
  final _formKeyBasic = GlobalKey<FormState>();
  final _formKeyOwner = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agency Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && _formKeyBasic.currentState!.validate()) {
            setState(() => _currentStep += 1);
          } else if (_currentStep == 1 && _formKeyOwner.currentState!.validate()) {
            setState(() => _currentStep += 1);
          } else if (_currentStep == 2) {
            // Final submit
            if (_validateDocuments()) {
              // TODO: Upload data & documents to Firebase
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please upload all required documents.'),
                ),
              );
            }
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep -= 1);
        },
        steps: [
          // Step 1: Basic Info
          Step(
            title: const Text('Basic Info'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _formKeyBasic,
              child: Column(
                children: [
                  TextFormField(
                    controller: agencyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Agency Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Enter agency name' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter email';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    value!.isEmpty ? 'Enter phone number' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Official Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Enter address' : null,
                  ),
                ],
              ),
            ),
          ),

          // Step 2: Owner Info
          Step(
            title: const Text('Owner Info'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _formKeyOwner,
              child: Column(
                children: [
                  TextFormField(
                    controller: ownerNameController,
                    decoration: const InputDecoration(
                      labelText: 'Owner Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Enter owner name' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: ownerNIDController,
                    decoration: const InputDecoration(
                      labelText: 'Owner NID / Passport',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.card_membership),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Enter NID/Passport' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: ownerPhoneController,
                    decoration: const InputDecoration(
                      labelText: 'Owner Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    value!.isEmpty ? 'Enter owner phone' : null,
                  ),
                ],
              ),
            ),
          ),

          // Step 3: Upload Legal Documents
          Step(
            title: const Text('Upload Documents'),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                _documentPicker('Trade License', tradeLicense, (file) {
                  setState(() => tradeLicense = file);
                }),
                _documentPicker('Tourism License', tourismLicense, (file) {
                  setState(() => tourismLicense = file);
                }),
                _documentPicker('TIN Certificate', tinCertificate, (file) {
                  setState(() => tinCertificate = file);
                }),
                _documentPicker('Bank Account Proof', bankProof, (file) {
                  setState(() => bankProof = file);
                }),
                _documentPicker('Agency Logo (Optional)', agencyLogo, (file) {
                  setState(() => agencyLogo = file);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Document Picker Widget
  Widget _documentPicker(
      String label, File? file, void Function(File) onFilePicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file, color: Colors.white),
              label: const Text(
                'Upload',
                style: TextStyle(color: Colors.white), // <-- Text color changed
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: () async {
                final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery); // For simplicity
                if (pickedFile != null) {
                  onFilePicked(File(pickedFile.path));
                }
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                file != null ? file.path.split('/').last : 'No file selected',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _validateDocuments() {
    return tradeLicense != null &&
        tourismLicense != null &&
        tinCertificate != null &&
        bankProof != null;
  }
}
