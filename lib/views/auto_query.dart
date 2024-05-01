import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

class AutoQueryPage extends StatefulWidget {
  AutoQueryPage({Key? key}) : super(key: key);


  @override
  AutoQueryPageState createState() => AutoQueryPageState();
}

class AutoQueryPageState extends State<AutoQueryPage> {
  final _writeController = TextEditingController();
  BluetoothDevice? _connectedDevice;
  final List<BluetoothService> _services = [];
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  Map<String, Timer?> disconnectTimers = {};
  FlutterTts flutterTts = FlutterTts();
  bool isDeviceConnected = true;
  Timer? _speakTimer;

  Future<void> _addDeviceTolist(final BluetoothDevice device) async {
    print("checker-------->>>> ${device.platformName}");
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
        startDeviceSpeakTimer();
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

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _speakTimer?.cancel();
    super.dispose();
  }

  Future<void> _initBluetooth() async {
    var scanP = await Permission.bluetoothScan.request();
    var connectP = await Permission.bluetoothConnect.request();

    if (scanP.isGranted && connectP.isGranted) {
      var subscription = FlutterBluePlus.onScanResults.listen(
            (results) {
          if (results.isNotEmpty) {
            for (ScanResult result in results) {
              if (!_services.contains(result.device) &&
                  result.device.advName.startsWith("BM")) {
                _addDeviceTolist(result.device);
              }
              _speakDeviceNameSequentially();
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

      FlutterBluePlus.connectedDevices.map((device) async {
        await _addDeviceTolist(device);
      });
    }
  }


  void _speakDeviceNameSequentially() async {
    for (BluetoothDevice device in devicesList) {
      _speakDeviceName(device.platformName);
      await Future.delayed(const Duration(seconds: 3));
    }
  }


  void startDeviceSpeakTimer() {
    int currentIndex = 0;
    _speakTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (currentIndex < devicesList.length) {
        _speakDeviceName(devicesList[currentIndex].platformName);
        currentIndex++;
      } else {
        // Stop the timer when all devices have been spoken
        timer.cancel();
      }
    });
  }


  void _speakDeviceName(String name) async {
    await flutterTts.speak(name);
    await flutterTts.awaitSpeakCompletion(true);
  }

  ListView _buildListViewOfDevices() {
    List<Widget> containers = <Widget>[];
    for (BluetoothDevice device in devicesList) {
      containers.add(
        SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.platformName == '' ? '(unknown device)' : device
                        .advName),
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


  List<bool> isFavoriteList = [];
  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: ListView.builder(
          itemCount: devicesList.length,
          itemBuilder: (context, index) {
            BluetoothDevice device = devicesList[index];
            if (index >= isFavoriteList.length) {
              isFavoriteList.add(false);
            }
            return GestureDetector(
              onTap: () {
                _buildView();
                // _speakDeviceName(device.platformName == '' ? '(unknown device)' : device.advName);
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
                          Text(device.platformName == '' ? '(unknown device)' : device.advName,
                            style: TextStyle(
                              color: Color(0xFF72777A),
                              fontSize: 14,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                            ),),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
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
                                    !isFavoriteList[index]; // Toggle favorite state
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