import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  final String text;
  const TextApp({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
