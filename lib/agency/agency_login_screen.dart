import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';
import 'dashboard_screen.dart';
import 'agency_registration_screen.dart';


class AgencyLoginScreen extends StatefulWidget {
  const AgencyLoginScreen({super.key});

  @override
  State<AgencyLoginScreen> createState() => _AgencyLoginScreenState();
}

class _AgencyLoginScreenState extends State<AgencyLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Text('Tripify'),
        backgroundColor: Colors.teal,
      ),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text(
                'Login',
                style:TextStyle(
                    fontSize: 35,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold
                )
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical:30),
                child: Form(
                    child:Column(
                        children:[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:15),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText:'Email',
                                  hintText: 'Enter Email',
                                  prefixIcon: Icon(Icons.email),
                                  border:OutlineInputBorder()
                              ),
                              onChanged:(String value){


                              },
                              validator:(value){
                                return value!.isEmpty?'Please enter email':null;
                              },
                            ),
                          ),

                          SizedBox(height:30),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:15),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration:InputDecoration(
                                labelText:'Password',
                                hintText:'Enter password',
                                prefixIcon:Icon(Icons.password),
                                border:OutlineInputBorder(),
                              ),
                              onChanged:(String value){


                              },
                              validator:(value){
                                return value!.isEmpty?'Please enter password':null;
                              },


                            ),
                          ),
                          SizedBox(height:30),
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
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: Colors.teal),
                                ),
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
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashboardScreen(),
                                  ),
                                );
                              },
                              child: Text('Login'),
                              color: Colors.teal,
                              textColor: Colors.white,
                            ),
                          ),


                        ]
                    )
                )
            )
          ]
      ),

    );
  }
}