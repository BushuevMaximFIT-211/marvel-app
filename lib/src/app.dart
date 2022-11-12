import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/features/detailed_heroes/view/detailed_hero_page.dart';
import 'package:marvel_app/src/features/detailed_heroes/view/detailed_hero_page_args.dart';
import 'package:marvel_app/src/features/heroes/view/heroes_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel App',
      theme: ThemeData(),
      home: const HeroesPage(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(builder: ((context) {
          switch (settings.name) {
            case DetailedHeroPage.routeName:
              {
                final args = settings.arguments as DetailedHeroPageArgs;
                return ProviderScope(
                  overrides: [
                    selectedHeroProvider.overrideWithValue(args.hero)
                  ],
                  child: const DetailedHeroPage(),
                );
              }
            default:
              throw ('Undefined route');
          }
        }));
      },
    );
  }
}
