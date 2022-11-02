import 'package:flutter/material.dart';
import 'package:marvel_app/api_utils/classes/hero_marvel.dart';
import 'package:marvel_app/api_utils/methods/image_from_net.dart';
import 'package:marvel_app/widgets/text_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HeroMarvel hero =
        ModalRoute.of(context)!.settings.arguments as HeroMarvel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TextApp(
          text: hero.name.contains('(')
              ? hero.name.substring(0, hero.name.indexOf('('))
              : hero.name,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(alignment: Alignment.bottomLeft, children: [
        Hero(tag: hero.name, child: imageFromNetwork(context, hero.getPath())),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            hero.info != ''
                ? hero.info
                : 'Hello! My name is ${hero.name} and I am character of Marvel. ',
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
