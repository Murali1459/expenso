import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String name;
  const Tag({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 128, 128, 128),
        borderRadius: BorderRadiusGeometry.all(Radius.circular(5)),
      ),
      child: Text("#$name"),
    );
  }
}
