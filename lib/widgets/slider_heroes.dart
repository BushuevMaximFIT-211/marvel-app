import 'package:application_marvel/api_utils/classes/hero_marvel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/card_hero.dart';
import 'custom_clipper.dart';
import '../pages/HomePage.dart';
import 'custom_clipper.dart';

class SliderHeroes extends StatefulWidget {
  final List<HeroMarvel> listOfHeroes;
  final BackgroundPainter backgroundPainter;
  SliderHeroes(
      {Key? key, required this.listOfHeroes, required this.backgroundPainter})
      : super(key: key);

  @override
  State<SliderHeroes> createState() =>
      _SliderHeroesState(listOfHeroes, backgroundPainter);
}

class _SliderHeroesState extends State<SliderHeroes> {
  final List<HeroMarvel> listOfHeroes;
  final BackgroundPainter backgroundPainter;
  _SliderHeroesState(this.listOfHeroes, this.backgroundPainter);
  final List<Color> listColor = [
    Color.fromRGBO(1, 0, 0, 1),
    Color.fromRGBO(0, 1, 0, 1),
    Color.fromRGBO(0, 0, 1, 1)
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateFunc) {
      return CarouselSlider(
          items: [
            CardHero(
              textCard: listOfHeroes[0].name,
              pathImage: '${listOfHeroes[0].path}.jpg',
            ),
            CardHero(
                textCard: listOfHeroes[1].name,
                pathImage: '${listOfHeroes[1].path}.jpg'),
            CardHero(
                textCard: listOfHeroes[2].name,
                pathImage: '${listOfHeroes[2].path}.jpg'),
            CardHero(
                textCard: listOfHeroes[3].name,
                pathImage: '${listOfHeroes[3].path}.jpg'),
            CardHero(
                textCard: listOfHeroes[4].name,
                pathImage: '${listOfHeroes[4].path}.jpg'),
          ],
          options: CarouselOptions(
            height: 555,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,

            enlargeCenterPage: true,
            // onPageChanged: (index, reason) =>
            onPageChanged: (index, reason) {
              setState(() {
                var _currentPage = index;
                backgroundPainter.colorShape = listColor[_currentPage];
              });
            },
            // onPageChanged: callbackFunction, смена фона
            scrollDirection: Axis.horizontal,
          ));
    });
  }
}
