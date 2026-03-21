import 'dart:io';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';

class AgencyRegistrationScreen extends StatefulWidget {
  const AgencyRegistrationScreen({super.key});

  @override
  State<AgencyRegistrationScreen> createState() => _AgencyRegistrationScreenState();
}

class _AgencyRegistrationScreenState extends State<AgencyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  Map<String, File?> uploadedFiles = {
    'Trade License': null,
    'Tourism License': null,
    'TIN Certificate': null,
    'Bank Account Proof': null,
    'Agency Logo (Optional)': null,
  };

  Future<void> pickFile(String key) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        uploadedFiles[key] = File(pickedFile.path);
      });
    }
  }

  Widget buildUploadRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        ElevatedButton.icon(
          onPressed: () => pickFile(label),
          icon: Icon(Icons.upload_file),
          label: Text('Upload'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tripify'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Registration',
              style: TextStyle(
                fontSize: 35,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Agency Name',
                        hintText: 'Enter Agency Name',
                        prefixIcon: Icon(Icons.apartment),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter agency name' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Agency Email',
                        hintText: 'Enter Agency Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter agency email' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter phone number' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: 'Official Address',
                        hintText: 'Enter Official Address',
                        prefixIcon: Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter official address' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Owner Name',
                        hintText: 'Enter Owner Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter owner name' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Owner NID/Passport',
                        hintText: 'Enter Owner NID/Passport',
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter owner NID/Passport' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Owner Phone',
                        hintText: 'Enter Owner Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter owner phone' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter password' : null,
                    ),
                    SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please confirm password' : null,
                    ),
                    SizedBox(height: 30),

                    buildUploadRow('Trade License'),
                    SizedBox(height: 20),
                    buildUploadRow('Tourism License'),
                    SizedBox(height: 20),
                    buildUploadRow('TIN Certificate'),
                    SizedBox(height: 20),
                    buildUploadRow('Bank Account Proof'),
                    SizedBox(height: 20),
                    buildUploadRow('Agency Logo (Optional)'),
                    SizedBox(height: 30),

                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        }
                      },
                      child: Text('Register'),
                      color: Colors.teal,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}