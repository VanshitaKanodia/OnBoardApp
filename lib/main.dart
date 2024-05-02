import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/auth_page/Init_page.dart';
import 'package:iwayplus_bluetooth/auth_page/edit_profile.dart';
import 'package:iwayplus_bluetooth/auth_page/otp_screen.dart';
import 'package:iwayplus_bluetooth/auth_page/logInPage.dart';
import 'package:iwayplus_bluetooth/auth_page/profile_page.dart';
import 'package:iwayplus_bluetooth/auth_page/signup_page.dart';
import 'package:iwayplus_bluetooth/views/auto_query.dart';
import 'package:iwayplus_bluetooth/views/home_page.dart';
import 'package:iwayplus_bluetooth/views/myRoute_page.dart';
import 'package:iwayplus_bluetooth/views/query.dart';


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
          'logIn_page' : (context) => LogInPage(),
          'signUp_page' : (context) => SignupPage(),
          'otp_page' : (context) => OtpPage(phoneNum: '',),
          'home_page': (context) => HomePage(),
          'query_page' : (context) => QueryPage(),
          'auto_query_page' : (context) => AutoQueryPage(),
          'myRoute_page': (context) => MyRoutes(),
          'profile_page' : (context) => ProfilePage(),
          'edit_profile': (context) => EditProfilePage(),
        },
      );
}
