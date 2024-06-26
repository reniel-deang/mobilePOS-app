import 'dart:async';
import 'dart:convert';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';


class BluetoothPrintPage extends StatefulWidget {
  @override
  _BluetoothPrintPageState createState() => _BluetoothPrintPageState();
}

class _BluetoothPrintPageState extends State<BluetoothPrintPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'No device connected';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));
    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('Device status: $state');
      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Connected successfully';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Disconnected successfully';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          title: const Text('Print Screen ', style: TextStyle(fontSize: 22, color: appColor, )),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    tips,
                    style: TextStyle(
                      fontSize: 16,
                      color: _connected ? Colors.green : Colors.red,
                    ),
                  ),
                ),
                Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!
                        .map((d) => ListTile(
                      title: Text(d.name ?? ''),
                      subtitle: Text(d.address ?? ''),
                      onTap: () async {
                        setState(() {
                          _device = d;
                        });
                      },
                      trailing: _device != null && _device!.address == d.address
                          ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                          : null,
                    ))
                        .toList(),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColor,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Connect', style: TextStyle(fontSize: 18, color: Colors.white)),
                            onPressed: _connected
                                ? null
                                : () async {
                              if (_device != null && _device!.address != null) {
                                setState(() {
                                  tips = 'Connecting...';
                                });
                                await bluetoothPrint.connect(_device!);
                              } else {
                                setState(() {
                                  tips = 'Please select a device';
                                });
                              }
                            },
                          ),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(

                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              backgroundColor: appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Disconnect', style: TextStyle(fontSize: 18, color: Colors.white)),
                            onPressed: _connected
                                ? () async {
                              setState(() {
                                tips = 'Disconnecting...';
                              });
                              await bluetoothPrint.disconnect();
                            }
                                : null,
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Print Receipt (ESC)', style: TextStyle(fontSize: 18, color: Colors.white)),
                        onPressed: _connected
                            ? () async {
                          Map<String, dynamic> config = Map();
                          List<LineText> list = [];
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'PARKING TICKET',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1,
                              fontZoom: 2));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'CHEKWA Corp.',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '1234 West Philippine Sea',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '--------OFFICIAL RECEIPT--------',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'TICKET NO: 139477984',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'PLATE NO: HCN879',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'DATE: JUNE 24 2024',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '--------------------------------',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'TIME IN : ',
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'TIME OUT : ',
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '------------------------------',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'PRICE : ',
                              align: LineText.ALIGN_LEFT,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '------------------------------',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'This ticket is non-refundable',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'It is subject to the rules and',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'regulation of carpark management',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: '',
                              weight: 1,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(
                              type: LineText.TYPE_QRCODE,
                              content: 'HCN879',
                              size: 60,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1,
                              fontZoom: 2));
                          list.add(LineText(
                              type: LineText.TYPE_TEXT,
                              content: 'Scan me',
                              weight: 0,
                              align: LineText.ALIGN_CENTER,
                              linefeed: 1));
                          list.add(LineText(linefeed: 1));

                          await bluetoothPrint.printReceipt(config, list);
                        }
                            : null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
              );
            }
          },
        ),
      ),
    );
  }
}
