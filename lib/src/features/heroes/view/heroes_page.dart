import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:marvel_app/main.dart';
import 'package:flutter/material.dart';
import '../../detailed_heroes/view/detailed_hero_page.dart';
import 'widgets/background_painter.dart';
import 'widgets/card_hero.dart';
import 'widgets/logo_marvel.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final heroesProvider = FutureProvider((ref) async {
  final heroesRepository = ref.watch(heroesRepositoryProvider);
  final storage = ref.watch(localDataStorageProvider);
  final connectivity = ref.read(connectivityProvider);

  Future<List<HeroMarvel>> heroes;
  final connectionResult = await connectivity.checkConnectivity();
  if (connectionResult != ConnectivityResult.none) {
    heroes = heroesRepository.fetchHeroList();
    heroes.then((value) {
      storage.saveValue(value);
    });
  } else {
    heroes = storage.getValue();
  }
  heroes.then((value) => ref.read(heroListProvider.notifier).state = value);

  return heroes;
});
final curentHeroProvider = StateProvider<HeroMarvel?>((ref) => null);
final _curentIndexStateProvider = StateProvider<int>((ref) {
  return 0;
});

final curentIDStateProvider = StateProvider<int>((ref) {
  return 1009718;
});

final heroListProvider = StateProvider<List<HeroMarvel>>((ref) => []);

class HeroesPage extends ConsumerStatefulWidget {
  static const routeName = '/heroes';

  const HeroesPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeroesPageState();
}

class _HeroesPageState extends ConsumerState<ConsumerStatefulWidget> {
  late HeroMarvel hero;
  late int indexPage;

  @override
  void initState() {
    indexPage = 0;

    super.initState();
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ref.read(curentIDStateProvider.notifier).state =
          int.parse(message.data['id']);
      Navigator.of(context).pushNamed(DetailedHeroPage.routeName);
    });
  }

  Future<void> _goToDetailsPage(BuildContext context, int id) async {
    Feedback.forLongPress(context);

    Navigator.of(context).pushNamed(DetailedHeroPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final heroesList = ref.watch(heroesProvider);
    int currentIndex = ref.watch(_curentIndexStateProvider);
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        body: heroesList.when(
            error: ((error, stackTrace) =>
                Center(child: Text(AppLocalizations.of(context)!.error))),
            loading: () => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/marvel_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),
            data: ((data) {
              return CustomPaint(
                painter: BackgroundPainter(currentIndex, primaryColor),
                child: Column(
                  children: [
                    const Center(child: LogoMarvel()),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    CarouselSlider.builder(
                      itemCount: data.length,
                      options: CarouselOptions(
                        height: 555,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          ref.read(_curentIndexStateProvider.notifier).state =
                              index;
                        },
                      ),
                      itemBuilder: (context, index, realIndex) =>
                          GestureDetector(
                              onLongPress: () {
                                ref.read(curentIDStateProvider.notifier).state =
                                    data[index].id;
                                _goToDetailsPage(context, data[index].id);
                              },
                              child: CardHero(hero: data[index])),
                    ),
                  ],
                ),
              );
            })));
  }
}
