import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:marvel_app/src/features/detailed_heroes/view/detailed_hero_page_args.dart';
import 'image_hero.dart';
import '../../../../../main.dart';
import '../../../detailed_heroes/view/detailed_hero_page.dart';
import 'text_app.dart';

class CardHero extends ConsumerWidget {
  final HeroMarvel hero;

  const CardHero({super.key, required this.hero});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (hero.info == null) {
      _loadDescription(hero, ref);
    }
    return GestureDetector(
        onLongPress: () {
          _goToDetailsPage(context, hero, ref);
        },
        child: Card(
            color: Colors.grey.shade800,
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: HeroWidget(hero: hero)));
  }

  Future _goToDetailsPage(
      BuildContext context, HeroMarvel hero, WidgetRef ref) async {
    Feedback.forLongPress(context);

    Navigator.of(context).pushNamed(DetailedHeroPage.routeName,
        arguments: DetailedHeroPageArgs(hero: hero));
  }
}

Future _loadDescription(HeroMarvel hero, WidgetRef ref) async {
  await ref.watch(heroesRepositoryProvider).fetchDecription(hero);
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

    return Stack(alignment: Alignment.bottomLeft, children: [
      Hero(
        tag: hero.id,
        child: ImageHero(imgUrl: hero.getPath()),
      ),
      TextApp(text: name)
    ]);
  }
}
