import 'package:flutter/material.dart';
import 'package:marvel_app/api_utils/classes/hero_marvel.dart';
import '../pages/detail_page.dart';
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
                child: HeroWidget(hero: hero))));
  }

  void _goToDetailsPage(BuildContext context, HeroMarvel hero) {
    Feedback.forLongPress(context);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => DetailPage(hero: hero)));
  }
}

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    Key? key,
    required this.hero,
  }) : super(key: key);

  final HeroMarvel hero;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: hero.name,
      child: Stack(children: [
        Image(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          image: ExactAssetImage(hero.path),
          fit: BoxFit.cover,
        ),
        Positioned(bottom: 16, left: 10, child: TextApp(text: hero.name))
      ]),
    );
  }
}
