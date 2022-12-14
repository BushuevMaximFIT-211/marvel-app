import 'package:heroes_repository/src/models/hero_marvel.dart';

abstract class HeroesRepository {
  Future<List<HeroMarvel>?> fetchHeroList();

  Future<String> fetchDescriptionHeroById(int index);
}
