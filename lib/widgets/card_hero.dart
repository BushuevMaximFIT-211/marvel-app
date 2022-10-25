import 'package:flutter/material.dart';
import 'package:marvel_app/api_utils/classes/hero_marvel.dart';
import 'text_widget.dart';

class CardHero extends StatelessWidget {
  final HeroMarvel hero;

  const CardHero({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onLongPress: () => _goToDetailsPage(context, hero),
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Hero(
                  tag: hero.name,
                  child: Stack(children: [
                    Image(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      image: ExactAssetImage(hero.path),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        bottom: 16, left: 10, child: TextApp(text: hero.name))
                  ]),
                ))));
  }

  void _goToDetailsPage(BuildContext context, HeroMarvel hero) {
    Feedback.forLongPress(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          foregroundColor: const Color.fromRGBO(0, 0, 0, 0),
          shadowColor: const Color.fromRGBO(0, 0, 0, 0),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Hero(
          tag: hero.name,
          child: Stack(children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              image: ExactAssetImage(hero.path),
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextApp(text: '${hero.name}\n${hero.info}'),
            )
          ]),
        ),
      ),
    ));
  }
}
