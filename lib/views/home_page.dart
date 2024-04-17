import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:iwayplus_bluetooth/controller/bluetooth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    return Scaffold(
      body: GetBuilder<BluetoothController>(
        init: BluetoothController(),
        builder: (controller){
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Center(
                    child: Text('Bluetooth Devices',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    onPressed: () => controller!.scanDevices(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 55),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    child: const Text(
                      "Scan",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // StreamBuilder<List<ScanResult>> (
                //   builder: (context, snapshot)
                //   {
                //     print('Snapshot is taken------');
                //     if(snapshot.hasData)
                //       {
                //         return ListView.builder(
                //           itemCount: snapshot.data!.length,
                //             itemBuilder: (context, index){
                //             final data = snapshot.data![index];
                //             return Card(
                //               elevation: 2,
                //               child: ListTile(
                //                 title: Text(data.device.name),
                //                 subtitle: Text(data.device.id.toString()),
                //                 trailing: Text(data.rssi.toString()),
                //               ),
                //             );
                //             });
                //       }
                //     else
                //       {
                //         return const Center(
                //           child: Text("No Device Found"),
                //         );
                //       }
                //   },
                //   stream: flutterBlue.scanResults,
                //   // stream: controller.scanResults,
                // )

                StreamBuilder<List<ScanResult>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(data.device.name ?? 'Unknown'),
                              subtitle: Text(data.device.id.toString()),
                              trailing: Text(data.rssi.toString()),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No Device Found"),
                      );
                    }
                  },
                  stream: FlutterBlue.instance.scanResults,
                )

              ],
            ),
          );
        },
      )
    );
  }
}
