import 'package:flutter/material.dart';
import 'package:tripifyUpdated/customer/customer_login_screen.dart';
import 'customer/home_feed_screen.dart';
import 'agency/agency_login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/whitelogo2.png',
          ),
        ),
        title: Column(
          children: [
            Text('Tripify',style: TextStyle(color: Colors.white)),
            Text(" Compare . Choose . Travel ",style: TextStyle(fontSize: 14,color:Colors.white),
            ),
          ],
        ),

        backgroundColor: Colors.teal,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            Padding(padding: const EdgeInsets.symmetric(horizontal:30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerLoginScreen(),
                    ),
                  );
                },
                child:Container(
                  height:70,
                  width:MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal,
                      boxShadow: [
                        BoxShadow(color:Colors.grey.shade500,offset:Offset(4.0,4.0),blurRadius:15.0, spreadRadius: 1.0,),
                        BoxShadow(color:Colors.white,offset:Offset(-4.0,-4.0),blurRadius:15.0, spreadRadius: 1.0,),
                      ]

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Text("Continue as Voyager", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),),
                                Text("Explore and Compare Trip Packages",style: TextStyle(fontSize: 10,color:Colors.white54),),
                              ]
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),

                  ),
                ),
              ),
            ),
            SizedBox(height:30),
            Padding(padding: const EdgeInsets.symmetric(horizontal:30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgencyLoginScreen(),
                    ),
                  );
                },
                child:Container(
                  height:70,
                  width:MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal,
                      boxShadow: [
                        BoxShadow(color:Colors.grey.shade500,offset:Offset(4.0,4.0),blurRadius:15.0, spreadRadius: 1.0,),
                        BoxShadow(color:Colors.white,offset:Offset(-4.0,-4.0),blurRadius:15.0, spreadRadius: 1.0,),
                      ]

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Text("Continue as Agency", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),),
                                Text("Publish and manage trip packages",style: TextStyle(fontSize:10,color:Colors.white54),),
                              ]
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),

                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

