import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/views/auto_query.dart';
import 'package:iwayplus_bluetooth/views/query.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  TextEditingController _searchController = TextEditingController();
  bool isQueryEnabled = false;
  bool isAutoQueryEnabled = false;
  bool isFavouriteModeEnabled = false;

  void _toggleQuery(bool value) {
    setState(() {
      isQueryEnabled = value;
      isAutoQueryEnabled = false;
      isFavouriteModeEnabled = false;
    });
  }

  void _toggleAutoQuery(bool value) {
    setState(() {
      isAutoQueryEnabled = value;
      isQueryEnabled = false;
      isFavouriteModeEnabled = false;
    });
  }




  void _toggleFavouriteMode(bool value) {
    setState(() {
      isFavouriteModeEnabled = value;
      isQueryEnabled = false;
      isAutoQueryEnabled = false;
    });
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Enter your search query',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Perform search based on the entered query
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          ElevatedButton(
                            onPressed: isQueryEnabled ?
                                () {
                              // Handle button 1 action
                              Navigator.push(context, MaterialPageRoute(builder: (context) => QueryPage(title: 'Query Scanner')));
                            } : null,
                            child:
                                Text('Query'),
                          ),
                          Switch(
                                  value: isQueryEnabled,
                                  onChanged: _toggleQuery,
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: isAutoQueryEnabled ? () {
                              // Handle button 1 action
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AutoQueryPage(title: "Autoquery")));
                            } : null,
                            child:
                            Text('Auto-Query'),
                          ),
                          Switch(
                            value: isAutoQueryEnabled,
                            onChanged: _toggleAutoQuery,
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: isFavouriteModeEnabled ? () {
                              // Handle button 1 action
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => QueryPage(title: 'Query Scanner')));
                            }: null,
                            child:
                            Text('Favourite Mode'),
                          ),
                          Switch(
                            value: isFavouriteModeEnabled,
                            onChanged: _toggleFavouriteMode,
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}
