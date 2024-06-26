import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobilepos_beta/bluetoothPrint.dart';

import 'main.dart';
import 'timeinScreen.dart';
import 'timeoutScreen.dart';
import 'asset/themecolor.dart';

const Color appColor = Colors.blueAccent; // Define the color you want to use

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: appColor),
          ),
          bottom: const TabBar(
            indicatorColor: appColor,
            tabs: [
              Tab(
                  icon: Icon(FontAwesomeIcons.car, color: appColor)),
              Tab(
                  icon: Icon(FontAwesomeIcons.toilet, color: appColor)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            ToiletScreen(), // Updated to ToiletScreen
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}



class HomeScreen extends StatelessWidget {
  final TextEditingController plateController = TextEditingController();

  void _timeIn(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time In: ${DateFormat('yyyy-MM-dd  hh:mm a').format(DateTime.now())}' ,style: TextStyle(
              color: appColor, fontSize: 12
          ),),
          content: TextField(
            controller: plateController,
            decoration: InputDecoration(
              hintText: 'Enter Plate Number',
              border: OutlineInputBorder(

              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without any action
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BluetoothPrintPage()), (route) => false);

                String plateNumber = plateController.text;
                // Handle time in action (e.g., save to database)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Plate: $plateNumber\nTime In: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())}'),
                    duration: Duration(seconds: 4),

                  ),
                );
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Print', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _timeOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time Out', style: TextStyle(
              color: appColor, fontSize: 15
          ),),
          content: TextField(
            controller: plateController,
            decoration: InputDecoration(
              hintText: 'Enter Plate Number',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without any action
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                String plateNumber = plateController.text;
                // Implement your logic to search for the plate number
                // For demonstration purposes, showing a SnackBar with the plate number
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Searching for Plate: $plateNumber'),
                    duration: Duration(seconds: 4),
                  ),
                );
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Search', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Parking Screen',
          style: TextStyle(color: appColor),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _timeIn(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Time In', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => _timeOut(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Time Out', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class ToiletScreen extends StatelessWidget {
  // Define the fixed amount
  final double fixedAmount = 10.00;

  void _printReceipt(BuildContext context) {
    String amount = fixedAmount.toStringAsFixed(2); // Format to two decimal places
    String currentDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Amount: ₱ $amount\nDate: $currentDateTime'),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Toilet Receipt', style: TextStyle(color: appColor,

        ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _printReceipt(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('ISSUE RECEIPT',
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [appColor, appColor]
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 30),
                const Text(
                  " ",
                  style: TextStyle(fontSize: 35, color: Colors.black),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.house,
              color: appColor,
              size: 20,
            ),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.gear,
              color: appColor,
              size: 20,
            ),
            title: const Text("Settings"),
            onTap: () => _navigateTo(context, themepicker()), // Assuming a SettingsScreen exists
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.signOut,
              color: appColor,
              size: 20,
            ),
            title: const Text("Logout"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Please Wait...'),
                    content: Text('Do you really want to Logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold, color: appColor),),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('CANCEL', style: TextStyle(fontWeight: FontWeight.bold, color: appColor),),
                      ),
                    ],
                  );
                },
              );

            },
          ),
        ],
      ),
    );
  }
}
