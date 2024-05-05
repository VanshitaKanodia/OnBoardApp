import 'package:flutter/material.dart';


class BusDetailCard extends StatefulWidget {
  const BusDetailCard({super.key});

  @override
  State<BusDetailCard> createState() => _BusDetailCardState();
}

class _BusDetailCardState extends State<BusDetailCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Card()
    );
  }
}
