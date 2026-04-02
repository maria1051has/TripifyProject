import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking_details.dart';

class BookingPage extends StatefulWidget {
  final String packageName;
  final String packagePrice;

  BookingPage({required this.packageName, required this.packagePrice});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  DateTime? selectedDate;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  pickDate() async {
    DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (d != null) setState(() => selectedDate = d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Page")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Package Name:"),
            Text(widget.packageName),
            SizedBox(height: 10),
            Text("Price:"),
            Text(widget.packagePrice),
            SizedBox(height: 15),
            Text("Your Name"),
            TextField(controller: name),
            SizedBox(height: 10),
            Text("Mobile Number"),
            TextField(controller: phone, keyboardType: TextInputType.phone),
            SizedBox(height: 10),
            Text("Select Date"),
            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.grey[200],
                child: Text(
                  selectedDate == null
                      ? "Pick a date"
                      : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (name.text.isEmpty ||
                      phone.text.isEmpty ||
                      selectedDate == null) {
                    print("Fill all fields");
                    return;
                  }

                  await _firestore.collection("booking").add({
                    "name": name.text,
                    "phone": phone.text,
                    "package": widget.packageName,
                    "price": widget.packagePrice,
                    "date": selectedDate!.toIso8601String(),
                    "time": DateTime.now(),
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingDetails(
                        packageName: widget.packageName,
                        packagePrice: widget.packagePrice,
                        userName: name.text,
                        phone: phone.text,
                        bookingDate:
                        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                      ),
                    ),
                  );
                },
                child: Text("Confirm Booking"),
              ),
            )
          ],
        ),
      ),
    );
  }
}