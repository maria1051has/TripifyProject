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

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // simple card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  buildRow("Package", packageName),
                  buildRow("Price", packagePrice),
                  buildRow("Name", userName),
                  buildRow("Phone", phone),
                  buildRow("Date", bookingDate),
                ],
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}