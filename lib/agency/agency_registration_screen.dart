import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'agency_login_screen.dart';

class AgencyRegistrationScreen extends StatefulWidget {
  const AgencyRegistrationScreen({super.key});

  @override
  State<AgencyRegistrationScreen> createState() =>
      _AgencyRegistrationScreenState();
}

class _AgencyRegistrationScreenState extends State<AgencyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  final _agencyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerNidController = TextEditingController();
  final _ownerPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Map<String, File?> uploadedFiles = {
    'Trade License': null,
    'Tourism License': null,
    'TIN Certificate': null,
    'Bank Account Proof': null,
    'Agency Logo': null,
  };

  final List<String> requiredFiles = [
    'Trade License',
    'Tourism License',
    'TIN Certificate',
    'Bank Account Proof',
    'Agency Logo',
  ];

  Future<void> pickFile(String key) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        uploadedFiles[key] = File(pickedFile.path);
      });
    }
  }

  Future<String?> uploadFileToStorage(File file, String fileName) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('agency_documents/$fileName');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  bool _validateFiles() {
    for (String key in requiredFiles) {
      if (uploadedFiles[key] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$key is required!',
              style: TextStyle(color: Colors.grey),
            ),
            backgroundColor: Colors.white,
          ),
        );
        return false;
      }
    }
    return true;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Passwords do not match',
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    if (!_validateFiles()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      Map<String, String?> fileUrls = {};
      for (var entry in uploadedFiles.entries) {
        if (entry.value != null) {
          String fileName = '${uid}_${entry.key.replaceAll(' ', '_')}';
          String? url = await uploadFileToStorage(entry.value!, fileName);
          fileUrls[entry.key] = url;
        }
      }

      await FirebaseFirestore.instance.collection('agencies').doc(uid).set({
        'agencyName': _agencyNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
        'ownerName': _ownerNameController.text.trim(),
        'ownerNid': _ownerNidController.text.trim(),
        'ownerPhone': _ownerPhoneController.text.trim(),
        'documents': fileUrls,
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'agency',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registration successful! Please login.',
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AgencyLoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed';
      if (e.code == 'email-already-in-use') message = 'Email already registered';
      if (e.code == 'weak-password') message = 'Password is too weak (min 6 characters)';
      if (e.code == 'invalid-email') message = 'Invalid email format';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }  catch (e) {
  debugPrint('FULL ERROR: $e');

  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  content: Text(
  'Error: $e',
  style: TextStyle(color: Colors.grey),
  ),
  backgroundColor: Colors.white,
  ),
  );
  } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _agencyNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _ownerNameController.dispose();
    _ownerNidController.dispose();
    _ownerPhoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildUploadRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label *'),
        Row(
          children: [
            if (uploadedFiles[label] != null)
              Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () => pickFile(label),
              icon: Icon(Icons.upload_file),
              label: Text('Upload'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
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
                      controller: _agencyNameController,
                      decoration: InputDecoration(
                        labelText: 'Agency Name *',
                        hintText: 'Enter Agency Name',
                        prefixIcon: Icon(Icons.apartment),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Agency name is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Agency Email *',
                        hintText: 'Enter Agency Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Email is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number *',
                        hintText: 'Enter Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Phone number is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Official Address *',
                        hintText: 'Enter Official Address',
                        prefixIcon: Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Address is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _ownerNameController,
                      decoration: InputDecoration(
                        labelText: 'Owner Name *',
                        hintText: 'Enter Owner Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Owner name is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _ownerNidController,
                      decoration: InputDecoration(
                        labelText: 'Owner NID/Passport *',
                        hintText: 'Enter Owner NID/Passport',
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'NID/Passport is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _ownerPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Owner Phone *',
                        hintText: 'Enter Owner Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Owner phone is required' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password *',
                        hintText: 'Enter password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Password is required';
                        if (value.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password *',
                        hintText: 'Confirm password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please confirm password' : null,
                    ),
                    SizedBox(height: 20),
                    buildUploadRow('Trade License'),
                    SizedBox(height: 10),
                    buildUploadRow('Tourism License'),
                    SizedBox(height: 10),
                    buildUploadRow('TIN Certificate'),
                    SizedBox(height: 10),
                    buildUploadRow('Bank Account Proof'),
                    SizedBox(height: 10),
                    buildUploadRow('Agency Logo'),
                    SizedBox(height: 30),
                    _isLoading
                        ? CircularProgressIndicator(color: Colors.teal)
                        : MaterialButton(
                      onPressed: _register,
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Text('Register'),
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