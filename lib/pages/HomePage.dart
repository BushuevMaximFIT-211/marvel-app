import 'package:flutter/material.dart';
import '../widgets/custom_clipper.dart';
import '../widgets/logo_marvel.dart';
import '../widgets/text_widget.dart';
import '../widgets/slider_heroes.dart';
import '../api_utils/classes/hero_marvel.dart';
import '../api_utils/methods/get_dataMarvel.dart';
import '../api_utils/constants/consts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BackgroundPainter backgroundPainter = BackgroundPainter();
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: backgroundPainter,
      child: Column(children: [
        const LogoMarvel(),
        const TextApp(text: 'Choose your hero'),
        const SizedBox(
          height: 40,
        ),
        FutureBuilder<List<HeroMarvel>>(
            future: (ApiClient(BASE_HOST, URL_HEROES).getDataApi<HeroMarvel>()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return SliderHeroes(
                  listOfHeroes: snapshot.data!,
                  backgroundPainter: backgroundPainter,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ]),
    );
  }
}
