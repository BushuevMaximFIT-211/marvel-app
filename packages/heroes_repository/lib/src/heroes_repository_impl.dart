import 'package:heroes_repository/src/models/hero_marvel.dart';
import 'package:heroes_repository/src/heroes_repository.dart';
import 'package:api_client/api_client.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

enum _HeroesEndpoint {
  listCharacters('/v1/public/characters'),
  characterById('/v1/public/characters/');

  const _HeroesEndpoint(this.endpoint);

  final String endpoint;
}

class HeroesRepositoryImpl implements HeroesRepository {
  final ApiClient _apiClient;
  final String publicKey;
  final String privateKey;
  String getHash() {
    return '$ts$privateKey$publicKey';
  }

  final ts = DateTime.now().millisecondsSinceEpoch;

  HeroesRepositoryImpl(this.publicKey, this.privateKey,
      {required ApiClient apiClient})
      : assert(publicKey.isNotEmpty, 'Api key must not be empty'),
        _apiClient = apiClient;

  @override
  Future<void> fetchDecription(HeroMarvel hero) async {
    final response = await _apiClient.dio.get(
        _HeroesEndpoint.characterById.endpoint + hero.id.toString(),
        queryParameters: {
          'characterId': hero.id,
          'apikey': publicKey,
          'ts': ts,
          'hash': md5.convert(utf8.encode(getHash())).toString()
        });
    final String description =
        response.data['data']['results'][0]['description'];
    hero.info = description;
  }

  @override
  Future<List<HeroMarvel>> fetchHeroList() async {
    final response = await _apiClient.dio
        .get(_HeroesEndpoint.listCharacters.endpoint, queryParameters: {
      'orderBy': '-name',
      'comics': 66397,
      'limit': 5,
      'apikey': publicKey,
      'ts': ts,
      'hash': md5.convert(utf8.encode(getHash())).toString()
    });
    final result = ResponseMapper.fromJson(response.data);
    final List<HeroMarvel> characterList =
        result.heroes.map((e) => HeroMarvel.fromJson(e)).toList();

    return characterList;
  }
}
