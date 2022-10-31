import 'package:flutter/material.dart';

class LogoMarvel extends StatelessWidget {
  const LogoMarvel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/marvel.png',
        width: 150,
        height: 60,
      ),
    );
  }
}
