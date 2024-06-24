import 'homePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Timein());
}

class Timein extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimeInScreen(),
    );
  }
}

class TimeInScreen extends StatefulWidget {
  const TimeInScreen({Key? key}) : super(key: key);

  @override
  _TimeInScreenState createState() => _TimeInScreenState();
}

class _TimeInScreenState extends State<TimeInScreen> {
  TextEditingController _plateNumberController = TextEditingController();
  final double _fixedAmount = 10.00;

  void _enterPlateNumber() {
    showDialog(
      context: context,
      builder: (context) => EnterPlateNumberDialog(
        plateNumberController: _plateNumberController,
        onPlateNumberChanged: (value) {
          setState(() {
            // You can update other state variables here if needed
          });
        },
      ),
    );
  }

  void _printReceipt() {
    String currentDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    String receiptInfo =
        'Amount: \$${_fixedAmount.toStringAsFixed(2)}\nDate: $currentDateTime\nPlate Number: ${_plateNumberController.text}';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(receiptInfo),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  void dispose() {
    _plateNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parking Time-In',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => home()));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _plateNumberController,
                onChanged: (value) {
                  // You can handle onChanged logic here if needed
                },
                decoration: InputDecoration(
                  hintText: 'Enter plate number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add some space between text field and button
            ElevatedButton(
              onPressed: _printReceipt,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Use backgroundColor instead of primary
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Proceed', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 20), // Add some space between buttons
          ],
        ),
      ),
    );
  }
}

class EnterPlateNumberDialog extends StatelessWidget {
  final TextEditingController plateNumberController;
  final ValueChanged<String> onPlateNumberChanged;

  const EnterPlateNumberDialog({
    Key? key,
    required this.plateNumberController,
    required this.onPlateNumberChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Plate Number'),
      content: TextField(
        controller: plateNumberController,
        onChanged: onPlateNumberChanged,
        decoration: InputDecoration(
          hintText: 'Enter plate number',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none, // No border side
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.amber, // Border color when focused
              width: 2.0, // Border width
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade400, // Border color when not focused
              width: 1.0, // Border width
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text('Enter'),
        ),
      ],
    );
  }
}
