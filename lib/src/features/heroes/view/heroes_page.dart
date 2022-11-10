import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/main.dart';
import 'package:flutter/material.dart';
import 'widgets/background_painter.dart';
import 'widgets/card_hero.dart';
import 'widgets/logo_marvel.dart';
import 'widgets/text_app.dart';
import 'package:carousel_slider/carousel_slider.dart';

final heroesProvider = FutureProvider((ref) {
  final heroesRepository = ref.watch(heroesRepositoryProvider);
  final heroes = heroesRepository.fetchHeroList();

  return heroes;
});

final curentIndexStateProvider = StateProvider<int>((ref) {
  return 0;
});

class HeroesPage extends ConsumerWidget {
  static const routeName = '/heroes';

  const HeroesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroesList = ref.watch(heroesProvider);
    int currentIndex = ref.watch(curentIndexStateProvider);

    return Scaffold(
        body: heroesList.when(
            error: ((error, stackTrace) => const Center(
                child: Text('There was exception while loading data!'))),
            loading: () => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/marvel_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
            data: ((data) => CustomPaint(
                  painter: BackgroundPainter(currentIndex),
                  child: Column(
                    children: [
                      const LogoMarvel(),
                      const TextApp(text: 'Choose your hero'),
                      const SizedBox(
                        height: 40,
                      ),
                      CarouselSlider.builder(
                        itemCount: data.length,
                        options: CarouselOptions(
                          height: 555,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            ref.read(curentIndexStateProvider.notifier).state =
                                index;
                          },
                        ),
                        itemBuilder: (context, index, realIndex) =>
                            CardHero(hero: data[index]),
                      ),
                    ],
                  ),
                ))));
  }
}
