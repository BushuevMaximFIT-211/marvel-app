// ignore_for_file: unused_import

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:marvel_app/main.dart';
import 'package:flutter/material.dart';
import '../../detailed_heroes/view/detailed_hero_page.dart';
import '../../detailed_heroes/view/detailed_hero_page_args.dart';
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
final curentHeroProvider = StateProvider<HeroMarvel?>((ref) => null);
final curentIndexStateProvider = StateProvider<int>((ref) {
  return 0;
});

final curentIDStateProvider = StateProvider<int>((ref) {
  return 1009718;
});

class HeroesPage extends ConsumerStatefulWidget {
  static const routeName = '/heroes';

  const HeroesPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeroesPageState();
}

class _HeroesPageState extends ConsumerState<ConsumerStatefulWidget> {
  late HeroMarvel hero;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ref.read(curentIDStateProvider.notifier).state =
          int.parse(message.data['id']);
      Navigator.of(context).pushNamed(DetailedHeroPage.routeName,
          arguments: DetailedHeroPageArgs(id: int.parse(message.data['id'])));
    });
  }

  Future _goToDetailsPage(BuildContext context, int id) async {
    Feedback.forLongPress(context);

    Navigator.of(context).pushNamed(DetailedHeroPage.routeName,
        arguments: DetailedHeroPageArgs(id: id));
  }

  @override
  Widget build(BuildContext context) {
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
                        itemCount: data?.length,
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
                            GestureDetector(
                                onLongPress: () {
                                  ref
                                      .read(curentIDStateProvider.notifier)
                                      .state = data[index].id;
                                  _goToDetailsPage(context, data[index].id);
                                },
                                child: CardHero(hero: data![index])),
                      ),
                    ],
                  ),
                ))));
  }
}
