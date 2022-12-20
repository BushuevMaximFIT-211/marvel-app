import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/src/features/heroes/view/heroes_page.dart';
import 'package:marvel_app/src/features/heroes/view/widgets/image_hero.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final heroProvider = FutureProvider<HeroMarvel>(((ref) async {
  final id = ref.watch(curentIDStateProvider);
  final connectivity = Connectivity();
  final connectionResult = await connectivity.checkConnectivity();
  final heroList = ref.watch(heroListProvider);
  HeroMarvel hero = heroList.firstWhere((hero) => hero.id == id);
  if (connectionResult != ConnectivityResult.none) {
    hero.info =
        await ref.watch(heroesRepositoryProvider).fetchDescriptionHeroById(id);
    ref.watch(localDataStorageProvider).updateValue(id, hero.info);
  } else {
    hero.info ??= '';
  }

  return hero;
}));

class DetailedHeroPage extends ConsumerStatefulWidget {
  static const routeName = '/detailed-heroes';

  const DetailedHeroPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailedHeroPageState();
}

class _DetailedHeroPageState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final asyncHero = ref.watch(heroProvider);
    return asyncHero.when(
        data: ((data) {
          final hero = data;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                hero.name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Hero(tag: hero.id, child: ImageHero(imgUrl: hero.getPath())),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    hero.info == ''
                        ? AppLocalizations.of(context)!
                            .default_description(hero.name)
                        : hero.info.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ]),
          );
        }),
        error: ((error, stackTrace) {
          return Text(error.toString());
        }),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())));
  }
}
