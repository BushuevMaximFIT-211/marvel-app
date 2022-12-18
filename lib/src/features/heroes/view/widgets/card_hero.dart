// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';

import 'image_hero.dart';
import '../../../../../main.dart';
import '../../../detailed_heroes/view/detailed_hero_page.dart';
import 'text_app.dart';

class CardHero extends ConsumerWidget {
  final HeroMarvel hero;

  const CardHero({super.key, required this.hero});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        color: Colors.grey.shade800,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: HeroWidget(hero: hero));
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
    final name = hero.name;

    return Stack(alignment: AlignmentDirectional.bottomStart, children: [
      Hero(
        tag: hero.id,
        child: ImageHero(imgUrl: hero.getPath()),
      ),
      TextApp(text: name)
    ]);
  }
}
