import 'package:application_marvel/api_utils/classes/hero_marvel.dart';
import 'package:application_marvel/widgets/card_hero.dart';
import 'package:application_marvel/widgets/backgroundPainter.dart';
import 'package:flutter/material.dart';
import '../widgets/logo_marvel.dart';
import '../widgets/text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<BackgroundPainter> backgroundPainterList = [
    BackgroundPainter(const Color.fromARGB(255, 49, 68, 153)),
    BackgroundPainter(const Color.fromARGB(255, 201, 64, 64)),
    BackgroundPainter(const Color.fromARGB(255, 112, 93, 133)),
    BackgroundPainter(const Color.fromARGB(255, 76, 148, 88)),
    BackgroundPainter(const Color.fromARGB(255, 185, 200, 208)),
  ];

  BackgroundPainter backgroundPainter =
      BackgroundPainter(const Color.fromARGB(255, 49, 68, 153));
  final List<HeroMarvel> characterList = const [
    HeroMarvel(name: 'Iron Man', path: 'lib/assets/iron-man.jpg'),
    HeroMarvel(name: 'Deadpool', path: 'lib/assets/deadpool.jpg'),
    HeroMarvel(name: 'Dr Strange', path: 'lib/assets/dr-strange.jpg'),
    HeroMarvel(name: 'Groot', path: 'lib/assets/groot.jpg'),
    HeroMarvel(name: 'Spider Man', path: 'lib/assets/spider-man.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: backgroundPainter,
      child: Center(
        child: Column(
          children: [
            const LogoMarvel(),
            const TextApp(text: 'Choose your hero'),
            const SizedBox(
              height: 40,
            ),
            CarouselSlider(
                items: characterList
                    .map((hero) =>
                        CardHero(imgpath: hero.path, textCard: hero.name))
                    .toList(),
                options: CarouselOptions(
                  height: 555,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      backgroundPainter = backgroundPainterList[index];
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ))
          ],
        ),
      ),
    );
  }
}
