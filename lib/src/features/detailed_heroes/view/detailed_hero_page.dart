import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/src/features/heroes/view/heroes_page.dart';
import 'package:marvel_app/src/features/heroes/view/widgets/image_hero.dart';
import 'package:marvel_app/src/features/heroes/view/widgets/text_app.dart';

final selectedHeroProvider =
    Provider<int>(((ref) => throw UnimplementedError()));
final heroProvider = FutureProvider<HeroMarvel>(((ref) async {
  final id = ref.watch(curentIDStateProvider);
  final hero = await ref.watch(heroesRepositoryProvider).fetchHeroById(id);
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
              title: TextApp(text: hero.name),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(alignment: Alignment.bottomLeft, children: [
              Hero(tag: hero.id, child: ImageHero(imgUrl: hero.getPath())),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  hero.info == ''
                      ? 'Hello! My name is ${hero.name} and I am character of Marvel.'
                      : hero.info.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900),
                ),
              ),
            ]),
          );
        }),
        error: ((error, stackTrace) {
          return Text(error.toString());
        }),
        loading: () => const CircularProgressIndicator());
  }
}
