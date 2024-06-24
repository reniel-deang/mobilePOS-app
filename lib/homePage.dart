import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'timeinScreen.dart';
import 'timeoutScreen.dart';

void main() {
  runApp(home());
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, // Use backgroundColor instead of primary
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
                color: Colors.yellow),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                  icon: Icon(FontAwesomeIcons.car, color: Colors.amber,)),
              Tab(
                  icon:
                  Icon(FontAwesomeIcons.toilet, color: Colors.amber,)),
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
            color: Colors.amber,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Timein()), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Use backgroundColor instead of primary
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
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Timeout()), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Use backgroundColor instead of primary
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const  Text('TIME OUT',
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
          'Toilet Receipt', style: TextStyle(color: Colors.amber,
            fontWeight: FontWeight.bold
        ),

        ),

      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _printReceipt(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const  Text('PRINT RECEIPT',
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
                  colors: [Colors.amber, Colors.amber]
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
              color: Colors.amber,
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
              color: Colors.amber,
              size: 20,
            ),
            title: const Text("Settings"),
            onTap: () => _navigateTo(context, ToiletScreen()), // Assuming a SettingsScreen exists
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.signOut,
              color: Colors.amber,
              size: 20,
            ),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
    );
  }
}
