import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'timeinScreen.dart';
import 'timeoutScreen.dart';
import 'asset/themecolor.dart';

const Color appColor = Colors.redAccent; // Define the color you want to use

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
  void _timeIn() {
    // Handle Time In button press
  }

  void _timeOut() {
    // Handle Time Out button press
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Parking Ticket', style: TextStyle(
            color: appColor,
            fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Timein()), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor, // Use backgroundColor instead of primary
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('TIME IN',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 20), // Add some space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Timeout()), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor, // Use backgroundColor instead of primary
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('TIME OUT',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
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
        content: Text('Amount: $amount\nDate: $currentDateTime'),
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
            fontWeight: FontWeight.bold
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
