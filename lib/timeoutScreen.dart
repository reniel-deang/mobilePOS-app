import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'homePage.dart';

void main() {
  runApp(Timeout());
}

class Timeout extends StatefulWidget {
  const Timeout({Key? key}) : super(key: key);

  @override
  State<Timeout> createState() => _TimeoutscreenState();
}

class _TimeoutscreenState extends State<Timeout> {
  String _plateNumber = '';
  final double _fixedAmount = 10.00;

  void _enterPlateNumber() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Plate Number'),
        content: TextField(
          onChanged: (value) {
            setState(() {
              _plateNumber = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Enter plate number',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _printReceipt() {
    String currentDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    String receiptInfo = 'Amount: \$${_fixedAmount.toStringAsFixed(2)}\nDate: $currentDateTime\nPlate Number: $_plateNumber';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(receiptInfo),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Parking Time-out',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.amber,),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => home()));
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, size: 30, color: Colors.amber),
              onPressed: _enterPlateNumber,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _printReceipt,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Use backgroundColor instead of primary
                  padding: const  EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Print Receipt',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 20), // Add some space between buttons

            ],
          ),
        ),
      ),
    );
  }
}
