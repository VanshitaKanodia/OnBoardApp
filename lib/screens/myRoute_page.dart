import 'package:flutter/material.dart';

class MyRoutes extends StatefulWidget {
  const MyRoutes({super.key});

  @override
  State<MyRoutes> createState() => _MyRoutesState();
}

class _MyRoutesState extends State<MyRoutes> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Routes'),
    );
  }
}
