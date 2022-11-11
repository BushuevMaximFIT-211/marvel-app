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
  List<Color> colorList = const [
    Color.fromARGB(255, 49, 68, 153),
    Color.fromARGB(255, 201, 64, 64),
    Color.fromARGB(255, 112, 93, 133),
    Color.fromARGB(255, 76, 148, 88),
    Color.fromARGB(255, 185, 200, 208),
  ];
  var _curentIndex = 0;
  final List<HeroMarvel> characterList = const [
    HeroMarvel(name: 'Iron Man', path: 'assets/iron-man.jpg'),
    HeroMarvel(name: 'Deadpool', path: 'assets/deadpool.jpg'),
    HeroMarvel(name: 'Dr Strange', path: 'assets/dr-strange.jpg'),
    HeroMarvel(name: 'Groot', path: 'assets/groot.jpg'),
    HeroMarvel(name: 'Spider Man', path: 'assets/spider-man.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(colorList[_curentIndex]),
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
