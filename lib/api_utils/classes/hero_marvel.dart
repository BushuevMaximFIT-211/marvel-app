import 'package:flutter/material.dart';

class HeroMarvel {
  final String name;
  final Color color;
  final String path;
  final String info;

  const HeroMarvel(this.color, this.info,
      {required this.name, required this.path});

  // factory HeroMarvel.fromJson(Map<String, dynamic> json) {
  //   return HeroMarvel(
  //       name: json['name'],
  //       path: json['thumbnail']['path'],
  //       color: Color.fromARGB(1, 1, 1, 1));
  // }
}
