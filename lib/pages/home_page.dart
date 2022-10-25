import 'package:flutter/material.dart';
import '../api_utils/classes/hero_marvel.dart';
import '../widgets/background_painter.dart';
import '../widgets/card_hero.dart';
import '../widgets/logo_marvel.dart';
import '../widgets/text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _curentIndex = 0;
  final List<HeroMarvel> characterList = const [
    HeroMarvel(
        name: 'Iron Man',
        path: 'assets/iron-man.jpg',
        Color.fromARGB(255, 49, 68, 153),
        'I AM IRON MAN'),
    HeroMarvel(
        name: 'Deadpool',
        path: 'assets/deadpool.jpg',
        Color.fromARGB(255, 201, 64, 64),
        'You might be wondering why the red suit. Well, that’s so bad guys don’t see me bleed.'),
    HeroMarvel(
        name: 'Dr Strange',
        path: 'assets/dr-strange.jpg',
        Color.fromARGB(255, 112, 93, 133),
        'Look at me. Stretching one moment out into a thousand just so I can watch the snow.'),
    HeroMarvel(
        name: 'Groot',
        path: 'assets/groot.jpg',
        Color.fromARGB(255, 76, 148, 88),
        'I AM GROOT'),
    HeroMarvel(
        name: 'Spider Man',
        path: 'assets/spider-man.jpg',
        Color.fromARGB(255, 185, 200, 208),
        'Have no fear! Spidey is here!'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(characterList[_curentIndex].color),
      child: Center(
        child: Column(
          children: [
            const LogoMarvel(),
            const TextApp(text: 'Choose your hero'),
            const SizedBox(
              height: 40,
            ),
            CarouselSlider(
                items:
                    characterList.map((hero) => CardHero(hero: hero)).toList(),
                options: CarouselOptions(
                  height: 555,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _curentIndex = index;
                    });
                  },
                ))
          ],
        ),
      ),
    );
  }
}
