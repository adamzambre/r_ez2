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
            appBar: AppBar(
              backgroundColor: Colors.brown,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                      "Search locals based on location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ]
              )
            )
            );
  }
}
