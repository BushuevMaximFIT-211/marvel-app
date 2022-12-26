import 'package:flutter/material.dart';

class AppTheme {
  static const transparentColor = Color.fromRGBO(0, 0, 0, 0);
  static const colorWhite = Colors.white;
  static final lightTheme = ThemeData(
      cardTheme: const CardTheme(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: transparentColor,
      ),
      primaryColor: const Color.fromARGB(255, 239, 190, 130),
      scaffoldBackgroundColor: const Color.fromARGB(255, 239, 190, 130),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: colorWhite,
            fontSize: 34,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: colorWhite, fontSize: 20, fontWeight: FontWeight.w900),
      ));

  static final darkTheme = ThemeData(
      indicatorColor: colorWhite,
      primaryColor: Colors.grey.shade900,
      appBarTheme: const AppBarTheme(backgroundColor: transparentColor),
      scaffoldBackgroundColor: Colors.grey.shade900,
      cardTheme: const CardTheme(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: colorWhite,
            fontSize: 34,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
          color: colorWhite,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ));
}
