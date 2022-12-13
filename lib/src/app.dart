import 'package:flutter/material.dart';
import 'package:marvel_app/src/features/detailed_heroes/view/detailed_hero_page.dart';
import 'package:marvel_app/src/features/heroes/view/heroes_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel App',
      theme: ThemeData(),
      home: const HeroesPage(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(builder: ((context) {
          switch (settings.name) {
            case DetailedHeroPage.routeName:
              {
                return const DetailedHeroPage();
              }
            default:
              throw ('Undefined route');
          }
        }));
      },
    );
  }
}
