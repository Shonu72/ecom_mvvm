import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight? fontWeight;
  const AppText(
      {super.key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54,  this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
        ));
  }
}
