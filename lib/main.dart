import 'package:flutter/material.dart';
import 'package:marvel_app/pages/detail_page.dart';
import 'package:marvel_app/pages/home_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      routes: {
        '/home_page': (context) => const HomePage(),
        '/detail_page': (context) => const DetailPage()
      },
      title: 'Marvel App',
      initialRoute: '/home_page',
    );
  }
}
