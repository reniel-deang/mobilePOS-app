import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilepos_beta/variable/receiptdata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Time Value Calculator'),
        ),
        body: TimeValueCalculator(),
      ),
    );
  }
}

class TimeValueCalculator extends StatefulWidget {
  @override
  _TimeValueCalculatorState createState() => _TimeValueCalculatorState();
}

class _TimeValueCalculatorState extends State<TimeValueCalculator> {
  final TextEditingController _timeInController = TextEditingController();
  final TextEditingController _timeOutController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _result = "";

  void _calculate() {
    DateTime timeIn = DateFormat("yyyy-MM-dd HH:mm:ss").parse(_timeInController.text);
    DateTime timeOut = DateFormat("yyyy-MM-dd HH:mm:ss").parse(_timeOutController.text);
    double pricePerHour = double.parse(_priceController.text);

    double totalValue = calculateTotalValue(timeIn, timeOut, pricePerHour);
    setState(() {
      _result = "Total Value: \$${totalValue.toStringAsFixed(2)}";
    });
  }

  double calculateTotalValue(DateTime timeIn, DateTime timeOut, double pricePerHour) {
    Duration duration = timeOut.difference(timeIn);
    double hour = duration.inMinutes / 60.0;
    hours = hour.toString();
    return hour * pricePerHour;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _timeInController,
            decoration: InputDecoration(labelText: 'Time In (yyyy-MM-dd HH:mm:ss)'),
          ),
          TextField(
            controller: _timeOutController,
            decoration: InputDecoration(labelText: 'Time Out (yyyy-MM-dd HH:mm:ss)'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price per Hour'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculate,
            child: Text('Calculate'),
          ),
          SizedBox(height: 20),
          Text(_result),
        ],
      ),
    );
  }
}