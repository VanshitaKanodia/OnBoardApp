import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

class QueryPage extends StatefulWidget {
  QueryPage({Key? key}) : super(key: key);
  // final List<BluetoothDevice> favouriteDevices;

  @override
  QueryPageState createState() => QueryPageState();
}

class QueryPageState extends State<QueryPage> {


  final _writeController = TextEditingController();
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  Map<String, Timer?> disconnectTimers = {};
  FlutterTts flutterTts = FlutterTts();
  bool isDeviceConnected = true;
  Map<String, bool> deviceConnectionStatus = {};

  List<BluetoothDevice> favoriteDevicesList = <BluetoothDevice>[];

  // Function to add a favorite device to the list
  void _addToFavorites(BluetoothDevice device) {
    if (!favoriteDevicesList.contains(device)) {
      setState(() {
        favoriteDevicesList.add(device);
      });
    }
  }


  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  void disconnectDevice(String deviceId) async {
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
    if (scanP.isGranted && connectP.isGranted) {
      var subscription = FlutterBluePlus.onScanResults.listen(
            (results) {
              if (results.isNotEmpty) {
                for (ScanResult result in results) {
                  if (!_services.contains(result.device)
                      &&
                      result.device.advName.startsWith("BM")) {
                    {
                      _addDeviceTolist(result.device);
                    }
                  }
                }
              }
            },
        onError: (e) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            ),
      );

      FlutterBluePlus.cancelWhenScanComplete(subscription);
      await FlutterBluePlus.adapterState
          .where((val) => val == BluetoothAdapterState.on)
          .first;
      await FlutterBluePlus.startScan();
      await FlutterBluePlus.isScanning
          .where((val) => val == false)
          .first;
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
    }
    ();
    super.initState();
  }

  // void _speakDeviceName(String name) async {
  //   print(name);
  //   await flutterTts.speak(name);
  // }

  ListView _buildListViewOfDevices() {
    List<Widget> containers = <Widget>[];
    for (BluetoothDevice device in devicesList) {


      String deviceId = device.id.toString();


      void _startConnecting(String deviceId) async {
        try{

          await device.connect();
          setState(() {
            // deviceConnectionStatus[deviceId] = !deviceConnectionStatus[deviceId]!;
            isDeviceConnected = !isDeviceConnected;
          });
        }catch(e){
          print('error iun coinnecting device $e');
        }
      }


      void _startDisconnectTimer(String deviceId) {
        disconnectTimers[deviceId] = Timer(Duration(seconds: 2), () {
          // Disconnect the device after 2 seconds
          device.disconnect();
          setState(() {
            // deviceConnectionStatus[deviceId] = !deviceConnectionStatus[deviceId]!;
            isDeviceConnected = !isDeviceConnected;
          });
        });
      }


      void _cancelDisconnectTimer(String deviceId) {
        if (disconnectTimers[deviceId] != null) {
          disconnectTimers[deviceId]!.cancel();
        }
      }



      List<bool> isFavoriteList = [];

      containers.add(
        // SizedBox(
        //   height: 50,
        //   child: Row(
        //     children: <Widget>[
        //       Expanded(
        //         child: Column(
        //           children: <Widget>[
        //             Text(device.platformName == '' ? '(unknown device)' : device.advName),
        //             Text(device.remoteId.toString()),
        //           ],
        //         ),
        //       ),
        //       TextButton(
        //         onPressed: () async {
        //           // deviceConnectionStatus[deviceId] == true ? null : () => _toggleConnection(deviceId);
        //           FlutterBluePlus.stopScan();
        //           try {
        //             // await device.connect();
        //             _startConnecting(deviceId);
        //             if (isDeviceConnected) {
        //               _startDisconnectTimer(deviceId);
        //             }
        //           } catch (e) {
        //             print('error $e but outside');
        //           } finally {
        //             // _services = await device.discoverServices();
        //           }
        //         },
        //         style: ButtonStyle(
        //           backgroundColor: MaterialStateProperty.resolveWith<Color>((
        //               states) {
        //             if (isDeviceConnected) {
        //               return Colors.grey;
        //             } else {
        //               return Colors.green;
        //             }
        //           }),
        //         ),
        //         child: Text(
        //           isDeviceConnected == true
        //               ? 'Connect'
        //               : 'Connected',
        //           style: TextStyle(color: Colors.black),
        //         ),
        //       ),
        //
        //     ],
        //   ),
        // ),
          ListView.builder(
            itemCount: devicesList.length,
            itemBuilder: (context, index) {
              BluetoothDevice device = devicesList[index];
              print(device);
              if (index >= isFavoriteList.length) {
                isFavoriteList.add(false);
              }
              return GestureDetector(
                onTap: () async {
                  print('1111111111111111111111');
                  await device.connect().whenComplete(() => setState(() {
                    _connectedDevice = device;_services = device.servicesList;
                  }));
                  _buildView();
                  // _speakDeviceName(device.advName == '' ? 'unknown device' : device.advName);
                  print('22222222222222222222222');
                },
                child: Card(
                  color: Color(0xFFE3E4E5),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(device.advName == '' ? '(unknown device)' : device.advName,
                              style: TextStyle(
                                color: Color(0xFF72777A),
                                fontSize: 14,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                              ),),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {

                                  },
                                  icon: Icon(Icons.share_outlined,
                                    color: Colors.grey[700],),
                                  color: Colors.grey,),
                                IconButton(
                                  icon: Icon(
                                    isFavoriteList[index]
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_outline_rounded,
                                    color: isFavoriteList[index] ? Colors
                                        .grey[700] : null,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavoriteList[index] =
                                      !isFavoriteList[index];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 25,),
                        Text(device.remoteId.id,
                          style: TextStyle(
                            color: Color(0xFF72777A),
                            fontSize: 10,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                          ),)
                      ],
                    ),
                  ),
                ),
              );
            },
          )
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
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
                              characteristic.write(
                                  utf8.encode(_writeController.value.text));
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
                    });
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
              child: const Text(
                  'NOTIFY', style: TextStyle(color: Colors.black)),
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
    print('entereds');
    List<Widget> containers = <Widget>[];

    for (BluetoothService service in _services) {
      print('aj aja aj a');
      List<Widget> characteristicsWidget = <Widget>[];

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print('Coming in');
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(characteristic.uuid.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Text(
                        'Value: ${readValues[characteristic.uuid]}')),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        ExpansionTile(title: Text(service.uuid.toString()),
            children: characteristicsWidget),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  ListView _buildView() {

    if (_connectedDevice != null) {
      print('++++++++++++CLICKED++++');
      return _buildConnectDeviceView();
    }
    else {
      print('+++++++++++++NULL++++++');
      return _buildListViewOfDevices();
    }
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.white,
        body: _buildView(),
      );
}



// import 'package:flutter/material.dart';
//
// class QueryPage extends StatefulWidget {
//   @override
//   _QueryPageState createState() => _QueryPageState();
// }
//
// class _QueryPageState extends State<QueryPage> {
//   List<bool> isFavoriteList = [false, false, false]; // Initial favorite state for each card
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: 3, // Number of cards in the list
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Item ${index + 1}"),
//                       IconButton(
//                         icon: Icon(
//                           isFavoriteList[index]
//                               ? Icons.favorite
//                               : Icons.favorite_border,
//                           color: isFavoriteList[index] ? Colors.red : null,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             isFavoriteList[index] =
//                             !isFavoriteList[index]; // Toggle favorite state
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.0),
//                   Text("Description of Item ${index + 1}"),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }