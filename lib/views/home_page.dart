import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/auth_page/signup_page.dart';
import 'package:iwayplus_bluetooth/views/auto_query.dart';
import 'package:iwayplus_bluetooth/views/query.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
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

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          ElevatedButton(onPressed: (){
            setState(() {
              currentPageIndex = 0;
            });
          }, child: Text(currentPageIndex == 0 ? 'Query se' : 'Query'),
          ),
          ElevatedButton(onPressed: (){
            setState(() {
              currentPageIndex = 1;
            });
          }, child: Text(currentPageIndex == 1 ? 'Auto Qury s' : 'Auto uery'),
          ),
          ElevatedButton(onPressed: (){
            setState(() {
              currentPageIndex = 2;
            });
          }, child: Text(currentPageIndex == 2 ? 'My Routes' : 'unselected'),
          ),
        ],
      ),
      body: <Widget>[
        QueryPage(title: 'Query'),
        AutoQueryPage(title: 'Auto Query'),
        SignupPage()
      ][currentPageIndex],
    );
  }
}
