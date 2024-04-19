import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController{

  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<List<BluetoothDevice>> scanDevices() async {
    List<BluetoothDevice> devices = [];

    while(true){
      final statusScan = await Permission.bluetoothScan.request();
      final statusConnect = await Permission.bluetoothConnect.request();

      if(await Permission.bluetoothScan.isDenied)
        {
          await Permission.bluetoothScan.request();
        }
      else if(statusScan.isGranted && statusConnect.isGranted){
        debugPrint("permission granted");
        try{
          await flutterBlue.startScan(timeout: const Duration(seconds: 3));

          flutterBlue.scanResults.listen((results) {
            for (ScanResult result in results) {
              if (!devices.contains(result.device) && result.device.name.startsWith("BM")) {
                  devices.add(result.device);
              }
            }
          });
          debugPrint(devices.toString());

          await Future.delayed(const Duration(seconds: 3));

          await flutterBlue.stopScan();
          break;
        } catch (e) {
          debugPrint('Error scanning for devices: $e');
        }
      } else {
        debugPrint("permission not granted");
      }
    }
    return devices;
  }
}