import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/screens/auto_query.dart';
import 'package:iwayplus_bluetooth/screens/myRoute_page.dart';
import 'package:iwayplus_bluetooth/screens/query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_service/audio_service.dart';


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
  AudioService audioService = AudioService();

  @override
  void initState() {

    // Map<Permission, PermissionStatus> statuses = await [Permission.bluetoothScan, Permission.bluetoothAdvertise].request();
    //
    // if (statuses[Permission.bluetoothScan] == PermissionStatus.granted && statuses[Permission.bluetoothScan] == PermissionStatus.granted) {
    // permission granted
      super.initState();
    // }
    // return;
  }

  bool _isMuted = false; // Variable to track mute/unmute state


  // Function to toggle mute/unmute state
  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }



  // void _toggleQuery(bool value) {
  //   setState(() {
  //     isQueryEnabled = value;
  //     isAutoQueryEnabled = false;
  //     isFavouriteModeEnabled = false;
  //   });
  // }
  //
  // void _toggleAutoQuery(bool value) {
  //   setState(() {
  //     isAutoQueryEnabled = value;
  //     isQueryEnabled = false;
  //     isFavouriteModeEnabled = false;
  //   });
  // }
  //
  // void _toggleFavouriteMode(bool value) {
  //   setState(() {
  //     isFavouriteModeEnabled = value;
  //     isQueryEnabled = false;
  //     isAutoQueryEnabled = false;
  //   });
  // }

  int _currentPageIndex = 0;

  final List<String> devicesList = [];


  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      print(_currentPageIndex);
    });
  }


  String navTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                IconButton(
                  icon: _currentPageIndex == 1 ?
                  (_isMuted ? Icon(Icons.volume_off,) : Icon(Icons.volume_up)): Icon(null),
                  onPressed: () {

                  },
                ),
          // IconButton(
          //           icon: Image.asset('assets/quill_mute.png',),
          //           onPressed: () {
          //
          //           },
          //       ) : Icon(null),
            Text(
              _currentPageIndex == 0 ? 'Query' : (_currentPageIndex == 1 ? 'Auto Query' : 'Favourites'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF72777A),
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                height: 0.05,
              )
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 25,
                  color: Color(0xFF72777A),
                  icon: Icon(Icons.notifications_active),
                  onPressed: () {
                    // Handle notification button pressed
                  },
                ),
                IconButton(
                  iconSize: 10,
                  color: Color(0xFF72777A),
                  icon: Image.asset('assets/menu_24px.png'),
                  onPressed: () {
                    // Handle profile button pressed
                    Navigator.pushNamed(context, 'profile_page');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 327,
                height: 48,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      // strokeJoin: StrokeJoin.round,
                      color: Color(0xFF72777A),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Bus',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10),
                        ),
                        style: TextStyle(
                          color: Color(0xFF72777A),
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 25,
                      color: Color(0xFF72777A),
                      icon: Icon(Icons.mic),
                      onPressed: () {
                        // Implement audio search functionality here
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildBody()
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem('Query', 0),
                  _buildNavItem('Auto Query', 1),
                  _buildNavItem('Favourites', 2),
                ],
              ),
            ),
          ]
      ),

    );
  }

  Widget _buildNavItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Container(
        width: 110,
        height: 48,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _currentPageIndex == index ? Color(0x7FD4D4D4) : Color(0xB2F5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                // color: _currentPageIndex == index ? Colors.white : Colors.black,
                color: Color(0x993C3C43),
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }


   Widget _buildBody() {
    switch (_currentPageIndex) {
      case 0:
        return QueryPage();
      case 1:
        return AutoQueryPage();
      case 2:
        return MyRoutes();
      default:
        return Container();
    }
  }
}


