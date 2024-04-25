
// import 'package:flutter/material.dart';
// import 'package:iwayplus_bluetooth/views/home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bluetooth Scanner',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/auth_page/Init_page.dart';
import 'package:iwayplus_bluetooth/auth_page/otp_screen.dart';
import 'package:iwayplus_bluetooth/auth_page/signIn_page.dart';
import 'package:iwayplus_bluetooth/auth_page/signup_page.dart';
import 'package:iwayplus_bluetooth/views/home_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        title: 'BLE Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'init_page',
        routes: {
          'init_page' : (context) => InitPage(),
          'signIn_page' : (context) => SignInPage(),
          'signUp_page' : (context) => SignupPage(),
          'otp_page' : (context) => OtpPage(),
          'home_page': (context) => HomePage(),
        },
        home: SignInPage(),

      );
}
