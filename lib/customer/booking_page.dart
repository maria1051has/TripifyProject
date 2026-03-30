import 'package:flutter/material.dart';
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

  String pay = "";
  DateTime? date;

  pickDate() async {
    var d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (d != null) {
      setState(() {
        date = d;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Booking"),
        backgroundColor: Colors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(widget.packageName),
            Text(widget.packagePrice, style: TextStyle(color: Colors.teal)),

            SizedBox(height: 15),

            TextField(
              controller: name,
              decoration: InputDecoration(hintText: "Name"),
            ),

            TextField(
              controller: phone,
              decoration: InputDecoration(hintText: "Phone"),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.grey[200],
                child: Text(date == null
                    ? "Select Date"
                    : "${date!.day}-${date!.month}-${date!.year}"),
              ),
            ),

            SizedBox(height: 15),

            Text("Payment"),

            Row(
              children: [
                Radio(
                  value: "bkash",
                  groupValue: pay,
                  onChanged: (v) {
                    setState(() {
                      pay = "bkash";
                    });
                  },
                ),
                Text("Bkash")
              ],
            ),

            Row(
              children: [
                Radio(
                  value: "nagad",
                  groupValue: pay,
                  onChanged: (v) {
                    setState(() {
                      pay = "nagad";
                    });
                  },
                ),
                Text("Nagad")
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                if (name.text == "" ||
                    phone.text == "" ||
                    pay == "" ||
                    date == null) {

                  print("Fill all");

                } else {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetails(
                        packageName: widget.packageName,
                        packagePrice: widget.packagePrice,
                        paymentMethod: pay,
                      ),
                    ),
                  );
                }
              },
              child: Text("Confirm"),
            )

          ],
        ),
      ),
    );
  }
}