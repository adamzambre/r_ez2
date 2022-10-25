import 'package:flutter/material.dart';

class Locals extends StatefulWidget {
  const Locals({Key? key}) : super(key: key);

  @override
  State<Locals> createState() => _LocalsState();
}

class _LocalsState extends State<Locals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Text("local screen"),
            );
  }
}
