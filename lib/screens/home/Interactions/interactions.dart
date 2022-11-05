import 'package:flutter/material.dart';

class Interactions extends StatefulWidget {
  const Interactions({Key? key}) : super(key: key);

  @override
  State<Interactions> createState() => _InteractionsState();
}

class _InteractionsState extends State<Interactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Interaction page"),
      ),
    );
  }
}
