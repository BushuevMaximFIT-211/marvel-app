import 'package:flutter/material.dart';
import 'package:heroes_repository/heroes_repository.dart';

import 'package:marvel_app/src/features/heroes/view/widgets/image_hero.dart';
import 'package:marvel_app/src/features/heroes/view/widgets/text_app.dart';

class DetailedHeroPage extends StatelessWidget {
  const DetailedHeroPage({super.key});
  static const routeName = '/detailed-heroes';
  @override
  Widget build(BuildContext context) {
    final HeroMarvel hero =
        ModalRoute.of(context)!.settings.arguments as HeroMarvel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TextApp(text: hero.name),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(alignment: Alignment.bottomLeft, children: [
        Hero(tag: hero.name, child: ImageHero(imgUrl: hero.getPath())),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            hero.info == ''
                ? 'Hello! My name is ${hero.name} and I am character of Marvel.'
                : hero.info.toString(),
            style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w900),
          ),
        ),
      ]),
    );
  }
}
