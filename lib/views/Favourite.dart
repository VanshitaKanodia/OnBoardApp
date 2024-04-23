import 'package:flutter/material.dart';

class FavouriteMode extends StatelessWidget {
  List<Widget> containers = <Widget>[];
  bool ifBuses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          ElevatedButton(onPressed: (){
            _showBusInfoDialog(context);
          },
            child: Icon(Icons.add),)
        ],
      ),
      body: Center(
        child: Text('Add Bus Info'),
        ),
    );
  }


  void _showBusInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String busNumber = '';
        String route = '';
        return AlertDialog(
          title: Text('Add Bus Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Bus Number'),
                onChanged: (value) {
                  busNumber = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Route'),
                onChanged: (value) {
                  route = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),

          ],
        );
      },
    );
  }
}

class BusInfoPage extends StatelessWidget {
  final String busNumber;
  final String route;

  BusInfoPage({required this.busNumber, required this.route});

  @override
  Widget build(BuildContext context) {
    // Simulating RSSI ID
    String rssiId = 'RSSI1234';

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bus Number: $busNumber',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Route: $route',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'RSSI ID: $rssiId',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
