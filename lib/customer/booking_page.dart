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

  void goToDetails(String paymentMethod) async {
    if (name.text.isEmpty || phone.text.isEmpty || selectedDate == null) {
      print("Fill all fields");
      return;
    }

    await _firestore.collection("booking").add({
      "name": name.text,
      "phone": phone.text,
      "package": widget.packageName,
      "price": widget.packagePrice,
      "date": selectedDate!.toIso8601String(),
      "payment": paymentMethod,
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
  }

  Widget buildTextField(String title, TextEditingController controller,
      {TextInputType? type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.teal.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentOption(String imagePath, String method) {
    return GestureDetector(
      onTap: () => goToDetails(method),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(imagePath, height: 30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // package card
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.packageName,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Price: ${widget.packagePrice}",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),

            SizedBox(height: 20),

            buildTextField("Your Name", name),
            SizedBox(height: 12),
            buildTextField("Mobile Number", phone,
                type: TextInputType.phone),

            SizedBox(height: 12),

            Text("Select Date",
                style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            GestureDetector(
              onTap: pickDate,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  selectedDate == null
                      ? "Pick a date"
                      : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                ),
              ),
            ),

            SizedBox(height: 25),

            // payment (logo only)
            Row(
              children: [
                Expanded(
                  child: paymentOption("assets/bkash.png", "bKash"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: paymentOption("assets/nagad.png", "Nagad"),
                ),
              ],
            ),

            SizedBox(height: 15),

            Center(
              child: TextButton(
                onPressed: () => goToDetails("Cash"),
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}