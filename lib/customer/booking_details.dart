import 'package:flutter/material.dart';

class BookingDetails extends StatelessWidget {
  final String packageName;
  final String packagePrice;
  final String userName;
  final String phone;
  final String bookingDate;

  BookingDetails({
    required this.packageName,
    required this.packagePrice,
    required this.userName,
    required this.phone,
    required this.bookingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Package Name:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(packageName),

            SizedBox(height: 10),
            Text("Price:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(packagePrice),

            SizedBox(height: 10),
            Text("Name:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(userName),

            SizedBox(height: 10),
            Text("Phone:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(phone),

            SizedBox(height: 10),
            Text("Booking Date:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(bookingDate),

            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}