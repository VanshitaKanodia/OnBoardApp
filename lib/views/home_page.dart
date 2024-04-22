import 'package:flutter/material.dart';
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
    });
  }

  void _toggleAutoQuery(bool value) {
    setState(() {
      isAutoQueryEnabled = value;
    });
  }




  void _toggleFavouriteMode(bool value) {
    setState(() {
      isFavouriteModeEnabled = value;
    });
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }
  ////some great changes

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
                            onPressed: () {
                              // Handle button 1 action
                              Navigator.push(context, MaterialPageRoute(builder: (context) => QueryPage(title: 'Query Scanner')));
                            },
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
                            onPressed: () {
                              // Handle button 1 action
                              Navigator.push(context, MaterialPageRoute(builder: (context) => QueryPage(title: 'Query Scanner')));
                            },
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
                            onPressed: () {
                              // Handle button 1 action
                              Navigator.push(context, MaterialPageRoute(builder: (context) => QueryPage(title: 'Query Scanner')));
                            },
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
