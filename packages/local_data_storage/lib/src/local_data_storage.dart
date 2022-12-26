import 'dart:convert';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage {
  late final SharedPreferences prefs;
  LocalDataStorage() {
    initStorage();
  }
  Future<void> initStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> updateValue(int id, String? description) async {
    final characterList = await getValue();
    if (characterList.isEmpty) {
      return;
    }

    HeroMarvel hero = characterList.firstWhere((element) => element.id == id);
    hero.info = description;
    final jsonData = jsonEncode(characterList.map((e) => e.toJson()).toList());
    prefs.setString('json_data', jsonData);
  }

  Future<void> saveValue(List<HeroMarvel> characterList) async {
    final jsonData = jsonEncode(characterList.map((e) => e.toJson()).toList());
    prefs.setString('json_data', jsonData);
  }

  Future<List<HeroMarvel>> getValue() async {
    String stringValue = prefs.getString('json_data') ?? '';

    final result = jsonDecode(stringValue);

    final characterList =
        result.map((e) => HeroMarvel.fromJson(e)).toList().cast<HeroMarvel>();

    return characterList;
  }
}
