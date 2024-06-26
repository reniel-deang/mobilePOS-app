import 'package:flutter/material.dart';
import 'package:mobilepos_beta/homePage.dart';

class themepicker extends StatefulWidget {
  const themepicker({super.key});

  @override
  State<themepicker> createState() => _themepickerState();
}

class _themepickerState extends State<themepicker> {
  // Define a list of colors
  final List<Color> colors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.brown,
    Colors.grey,
    Colors.cyanAccent,
    Colors.indigoAccent,
    Colors.tealAccent,
    Colors.limeAccent,
    Colors.amberAccent,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.black,
  ];

  Color newColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Theme Color',
          style: TextStyle(
            color: appColor, // Assuming `appColor` is defined somewhere
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns in the grid
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle the tap event
              print('Selected color: ${colors[index]}'); // Replace with desired action
              setState(() {
                newColor = colors[index];
              });
              // For example, you could store the selected color in a variable or pass it to another widget
            },
            child: Container(
              color: colors[index],
              child: Center(
                child: Text(
                  'Theme Color $index',
                  style: TextStyle(
                    color: Colors.white, // Adjust text color for visibility
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
