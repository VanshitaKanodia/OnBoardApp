import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

class AutoQueryPage extends StatefulWidget {
  AutoQueryPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  AutoQueryPageState createState() => AutoQueryPageState();
}

class AutoQueryPageState extends State<AutoQueryPage> {
  bool isConnected = false;
  final _writeController = TextEditingController();
  BluetoothDevice? _connectedDevice;
  final List<BluetoothService> _services = [];
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  Map<String, Timer?> disconnectTimers = {};
  FlutterTts flutterTts = FlutterTts();
  bool isDeviceConnected = true;


  void toggleConnection() {
    setState(() {
      isConnected = !isConnected;
    });
  }

  void _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  void disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      setState(() {
        _connectedDevice = null;
        _services.clear();
      });
    }
  }


  _initBluetooth() async {
    var scanP = await Permission.bluetoothScan.request();
    var connectP = await Permission.bluetoothConnect.request();

    print('Permissions are granting');

    if(scanP.isGranted && connectP.isGranted){

      print('Permission Granted');

      var subscription = FlutterBluePlus.onScanResults.listen(
            (results) {
          print('Print the results $results');
          if (results.isNotEmpty) {

            print('result listened carefully');
            for (ScanResult result in results) {
              print('Devices are scanning');
              // if (!_services.contains(result.device) && result.device.advName.startsWith("BM")) {
              _addDeviceTolist(result.device);
              // }
            }
          }
        },
        onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(

            content: Text(e.toString()),
          ),
        ),
      );

      FlutterBluePlus.cancelWhenScanComplete(subscription);

      await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;

      await FlutterBluePlus.startScan();

      await FlutterBluePlus.isScanning.where((val) => val == false).first;

      FlutterBluePlus.connectedDevices.map((device) {
        _addDeviceTolist(device);
      });
    }

  }

  @override
  void initState() {
    () async {
      var status = await Permission.location.status;
      if (status.isDenied) {
        final status = await Permission.location.request();
        if (status.isGranted || status.isLimited) {
          _initBluetooth();
        }
      } else if (status.isGranted || status.isLimited) {
        _initBluetooth();
      }

      if (await Permission.location.status.isPermanentlyDenied) {
        openAppSettings();
      }
    }();
    super.initState();
  }

  ListView _buildListViewOfDevices() {
    List<Widget> containers = <Widget>[];
    for (BluetoothDevice device in devicesList) {
      String deviceId = device.id.toString();


      void _startDisconnectTimer(String deviceId) {
        disconnectTimers[deviceId] = Timer(Duration(seconds: 2), () async {
          // Disconnect the device after 2 seconds
          await device.disconnect();
          setState(() {
            isDeviceConnected = !isDeviceConnected;
          });
        });
      }

      void _cancelDisconnectTimer(String deviceId) {
        if (disconnectTimers[deviceId] != null) {
          disconnectTimers[deviceId]!.cancel();
        }
      }


      containers.add(
        SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.platformName == '' ? '(unknown device)' : device.advName),
                    Text(device.remoteId.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = <ButtonTheme>[];

    if (characteristic.properties.read) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
              child: const Text('READ', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                var sub = characteristic.lastValueStream.listen((value) {
                  setState(() {
                    readValues[characteristic.uuid] = value;
                  });
                });
                await characteristic.read();
                sub.cancel();
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.write) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              child: const Text('WRITE', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Write"),
                      content: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _writeController,
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Send"),
                          onPressed: () {
                            characteristic.write(utf8.encode(_writeController.value.text));
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.notify) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              child: const Text('NOTIFY', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                characteristic.lastValueStream.listen((value) {
                  setState(() {
                    readValues[characteristic.uuid] = value;
                  });
                });
                await characteristic.setNotifyValue(true);
              },
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  ListView _buildConnectDeviceView() {
    List<Widget> containers = <Widget>[];

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = <Widget>[];

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(characteristic.uuid.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('Value: ${readValues[characteristic.uuid]}')),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        ExpansionTile(title: Text(service.uuid.toString()), children: characteristicsWidget),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: _buildView(),
  );
}
