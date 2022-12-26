import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'image_hero.dart';

class CardHero extends ConsumerWidget {
  final HeroMarvel hero;

  const CardHero({super.key, required this.hero});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        color: Theme.of(context).primaryColor, child: HeroWidget(hero: hero));
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
      Padding(
          padding: const EdgeInsets.all(17.0),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headlineLarge,
          ))
    ]);
  }
}
