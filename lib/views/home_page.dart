import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:iwayplus_bluetooth/controller/bluetooth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BluetoothDevice> _devices = [];

  Future<void> _scanDevices() async {
    List<BluetoothDevice> devices = await BluetoothController().scanDevices();
    setState(() {
      _devices = devices;
    });
  }

  ////some great changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
        bottom: PreferredSize(
            preferredSize: const Size(100, 40),
            child: ElevatedButton(
                onPressed: _scanDevices, child: const Text('Scan'))),
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = _devices[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
          );
        },
      ),
    );
  }
}