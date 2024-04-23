import 'package:flutter/material.dart';


class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<BusInfo> busList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus List'),
      ),
      body: ListView.builder(
        itemCount: busList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Bus Number: ${busList[index].busNumber}'),
            subtitle: Text('Route: ${busList[index].route}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBusInfoDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showBusInfoDialog(BuildContext context) async {
    String? busNumber;
    String? route;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
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
            TextButton(
              onPressed: () {
                if (busNumber != null && route != null) {
                  setState(() {
                    busList.add(BusInfo(busNumber!, route!));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class BusInfo {
  final String busNumber;
  final String route;

  BusInfo(this.busNumber, this.route);
}
