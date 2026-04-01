import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_password_screen.dart';
import 'dashboard_screen.dart';
import 'agency_registration_screen.dart';

class AgencyLoginScreen extends StatefulWidget {
  const AgencyLoginScreen({super.key});

  @override
  State<AgencyLoginScreen> createState() => _AgencyLoginScreenState();
}

class _AgencyLoginScreenState extends State<AgencyLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } on FirebaseAuthException catch (e) {
        print('Firebase error code: ${e.code}');
        print('Firebase error message: ${e.message}');
        String message = 'Login failed. Please check your email and password.';
        if (e.code == 'invalid-credential') message = 'Invalid email or password';
        if (e.code == 'user-not-found') message = 'No account found with this email';
        if (e.code == 'wrong-password') message = 'Wrong password';
        if (e.code == 'invalid-email') message = 'Invalid email format';
        if (e.code == 'user-disabled') message = 'This account has been disabled';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      } catch (e) {
        print('General error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong. Try again.', style: TextStyle(color: Colors.teal),), backgroundColor: Colors.white,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tripify'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 35,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter email' : null,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _passwordController,
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
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgencyRegistrationScreen(),
                            ),
                          );
                        },
                        child: Text("Register",
                            style: TextStyle(color: Colors.teal)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(color: Colors.teal)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.teal)
                        : MaterialButton(
                      onPressed: _login,
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}