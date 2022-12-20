import 'package:flutter/material.dart';
import 'package:marvel_app/src/features/detailed_heroes/view/detailed_hero_page.dart';
import 'package:marvel_app/src/features/heroes/view/heroes_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
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

class AppTheme {
  static const transparentColor = Color.fromRGBO(0, 0, 0, 0);
  static const colorText = Colors.white;
  static final lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: transparentColor),
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: const Color.fromARGB(255, 239, 190, 130),
      scaffoldBackgroundColor: const Color.fromARGB(255, 239, 190, 130),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: colorText,
            fontSize: 34,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: colorText, fontSize: 20, fontWeight: FontWeight.w900),
      ));

  static final darkTheme = ThemeData(
      primaryColor: Colors.grey.shade900,
      appBarTheme: const AppBarTheme(backgroundColor: transparentColor),
      scaffoldBackgroundColor: Colors.grey.shade900,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: colorText,
            fontSize: 34,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: colorText, fontSize: 20, fontWeight: FontWeight.w900),
      ));
}
