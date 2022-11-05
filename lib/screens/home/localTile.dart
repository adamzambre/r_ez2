import 'package:flutter/material.dart';
import 'package:r_ez2/models/local.dart';

class LocalTile extends StatelessWidget {
  //const LocalTile({Key? key}) : super(key: key);

  final Local local;
  LocalTile({required this.local});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 50.0,
              backgroundImage:
              NetworkImage(local.PPUrl),
              backgroundColor: Colors.transparent,
            ),
            title: Text(local.Name),
            subtitle: Text("${local.Country},${local.State}, ${local.City}"),
          ),
        ),
    );

  }
}
