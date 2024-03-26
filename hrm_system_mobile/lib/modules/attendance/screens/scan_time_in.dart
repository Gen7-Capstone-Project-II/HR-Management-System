import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScanTimeIn extends StatefulWidget {
  const ScanTimeIn({super.key, this.qrData});
  final String? qrData;

  @override
  State<ScanTimeIn> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScanTimeIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildDateTime(
                  "Date",
                  DateFormat("EEEE, MMMM dd, yyyy").format(
                    DateTime.now(),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDateTime(
                  "Time-In",
                  DateFormat("HH:mm").format(
                    DateTime.now(),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDateTime("Status", "Late"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Submit",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 5)
        ],
      ),
    );
  }

  Widget _buildDateTime(String title, String datetime) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: datetime,
                  hintStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                readOnly: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
