import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/auth_page/signup_page.dart';
import 'package:iwayplus_bluetooth/views/auto_query.dart';
import 'package:iwayplus_bluetooth/views/myRoute_page.dart';
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
  final pages = [
    QueryPage(title: 'Query Page'),
    AutoQueryPage(title: 'Auto Query'),
    MyRoutes(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 23,
                color: Color(0xFF72777A),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // Handle back button pressed
                },
              ),
              Text(
                'Query',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF72777A),
                  fontSize: 18,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.05,
                ),
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
                    iconSize: 25,
                    color: Color(0xFF72777A),
                    icon: Icon(Icons.account_circle),
                    onPressed: () {
                      // Handle profile button pressed
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement screen 1 navigation functionality here
                      print('---------Query tapped------');
                    },
                    child: Container(
                      width: 110,
                      height: 48,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Color(0x7FD4D4D4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Query',
                            style: TextStyle(
                              color: Color(0x993C3C43),
                              fontSize: 14,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              height: 0.08,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement screen 2 navigation functionality here
                      print('-----Auto query tapped------');
                    },
                    child: Container(
                      width: 110,
                      height: 48,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Color(0x7FD4D4D4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Auto Query',
                            style: TextStyle(
                              color: Color(0x993C3C43),
                              fontSize: 14,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              height: 0.08,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement screen 3 navigation functionality here
                      print('-------My Route tapped--------');
                    },
                    child: Container(
                      width: 110,
                      height: 48,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Color(0x7FD4D4D4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Favourites',
                            style: TextStyle(
                              color: Color(0x993C3C43),
                              fontSize: 14,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              height: 0.08,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      // BottomNavigationBar(
      //           items: [
      //             BottomNavigationBarItem(
      //               icon: Icon(null),
      //               label: 'Screen 1',
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(null),
      //               label: 'Screen 2',
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(null),
      //               label: 'Screen 3',
      //             ),
      //           ],
      //         ),
            ],
          ),
      ),
    );
    //   Scaffold(
    //   appBar: AppBar(
    //     title: Text('Audio Search'),
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(20.0),
    //         child: Text(
    //           'Query',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             color: Color(0xFF72777A),
    //             fontSize: 18,
    //             fontFamily: 'Open Sans',
    //             fontWeight: FontWeight.w600,
    //             height: 0.05,
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                   hintText: 'Type your search...',
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(10.0),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             IconButton(
    //               icon: Icon(Icons.mic),
    //               onPressed: () {
    //                 // Implement audio search functionality here
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //       Spacer(),
    //       BottomNavigationBar(
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.screen_share),
    //             label: 'Screen 1',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.screen_share),
    //             label: 'Screen 2',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.screen_share),
    //             label: 'Screen 3',
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    //     Scaffold(
    //     bottomNavigationBar: BottomNavigationBar(
    //       items: [
    //         BottomNavigationBarItem(
    //           label: 'Query',
    //           icon: Icons.null,
    //         )
    //       ],
    //       type: BottomNavigationBarType.fixed,
    //       selectedItemColor: Color(0x993C3C43),
    //       unselectedItemColor: Color(0xB2F5F5F5),
    //       backgroundColor: Colors.transparent,
    //   ),
    // //       // onDestinationSelected: (int index) {
    // //       //   setState(() {
    // //       //     currentPageIndex = index;
    // //       //   });
    // //       // },
    // //       // selectedIndex: currentPageIndex,
    // // //       destinations: <Widget>[
    // // //         ElevatedButton(onPressed: (){
    // // //           setState(() {
    // // //             currentPageIndex = 0;
    // // //           });
    // // //         }, child: Text(currentPageIndex == 0 ? 'Query' : 'Query'),
    // // //         ),
    // // //         ElevatedButton(onPressed: (){
    // // //           setState(() {
    // // //             currentPageIndex = 1;
    // // //           });
    // // //         }, child: Text(currentPageIndex == 1 ? 'Auto Qury' : 'Auto uery'),
    // // //         ),
    // // //         ElevatedButton(onPressed: (){
    // // //           setState(() {
    // // //             currentPageIndex = 2;
    // // //           });
    // // //         },
    // // // child: Text(currentPageIndex == 2 ? 'My Routes' : 'unselected'),
    // // //         ),
    // // //       ],
    // //     ),
    //     body: <Widget>[
    //       QueryPage(title: 'Query'),
    //       AutoQueryPage(title: 'Auto Query'),
    //       SignupPage()
    //     ][currentPageIndex],
    //   );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     switch (_selectedIndex) {
//       case 0:
//         print('---------Query tapped------');
//         break;
//       case 1:
//         print('-----Auto query tapped------');
//         break;
//       case 2:
//         print('-------My Route tapped--------');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Search'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Handle notification button pressed
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.account_circle),
//             onPressed: () {
//               // Handle profile button pressed
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text(
//               'Welcome to Audio Search',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     _onItemTapped(0);
//                   },
//                   child: Container(
//                     width: 110,
//                     height: 48,
//                     padding: const EdgeInsets.all(10),
//                     decoration: ShapeDecoration(
//                       color: _selectedIndex == 0 ? Colors.blue : Color(0x7FD4D4D4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Query',
//                         style: TextStyle(
//                           color: _selectedIndex == 0 ? Colors.white : Color(0x993C3C43),
//                           fontSize: 14,
//                           fontFamily: 'Open Sans',
//                           fontWeight: FontWeight.w600,
//                           height: 0.08,
//                           letterSpacing: 0.14,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _onItemTapped(1);
//                   },
//                   child: Container(
//                     width: 110,
//                     height: 48,
//                     padding: const EdgeInsets.all(10),
//                     decoration: ShapeDecoration(
//                       color: _selectedIndex == 1 ? Colors.blue : Color(0x7FD4D4D4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Auto Query',
//                         style: TextStyle(
//                           color: _selectedIndex == 1 ? Colors.white : Color(0x993C3C43),
//                           fontSize: 14,
//                           fontFamily: 'Open Sans',
//                           fontWeight: FontWeight.w600,
//                           height: 0.08,
//                           letterSpacing: 0.14,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _onItemTapped(2);
//                   },
//                   child: Container(
//                     width: 110,
//                     height: 48,
//                     padding: const EdgeInsets.all(10),
//                     decoration: ShapeDecoration(
//                       color: _selectedIndex == 2 ? Colors.blue : Color(0x7FD4D4D4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Favourites',
//                         style: TextStyle(
//                           color: _selectedIndex == 2 ? Colors.white : Color(0x993C3C43),
//                           fontSize: 14,
//                           fontFamily: 'Open Sans',
//                           fontWeight: FontWeight.w600,
//                           height: 0.08,
//                           letterSpacing: 0.14,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
