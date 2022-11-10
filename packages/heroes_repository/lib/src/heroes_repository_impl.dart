import 'package:heroes_repository/src/models/hero_marvel.dart';
import 'package:heroes_repository/src/heroes_repository.dart';
import 'package:api_client/api_client.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

const publicKey = '975e037e637c378702204436c23e4898';
const privateKey = '99a77ccbd252a0a188145dc48cae268c89d8c45d';
const ts = 2;
const hash = '$ts$privateKey$publicKey';

enum _HeroesEndpoint {
  listCharacters('/v1/public/characters'),
  characterById('/v1/public/characters/');

  const _HeroesEndpoint(this.endpoint);

  final String endpoint;
}

class HeroesRepositoryImpl implements HeroesRepository {
  final ApiClient _apiClient;
  final String apiKey;
  final String hash;

  HeroesRepositoryImpl(
      {required ApiClient apiClient, required this.apiKey, required this.hash})
      : assert(apiKey.isNotEmpty, 'Api key must not be empty'),
        _apiClient = apiClient;

  @override
  Future<void> fetchDecription(HeroMarvel hero) async {
    final response = await _apiClient.dio.get(
        _HeroesEndpoint.characterById.endpoint + hero.id.toString(),
        queryParameters: {
          'characterId': hero.id,
          'apikey': apiKey,
          'ts': 2,
          'hash': md5.convert(utf8.encode(hash)).toString()
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
      'apikey': apiKey,
      'ts': 2,
      'hash': md5.convert(utf8.encode(hash)).toString()
    });
    final result = ResponseMapper.fromJson(response.data);
    final List<HeroMarvel> characterList =
        result.heroes.map((e) => HeroMarvel.fromJson(e)).toList();

    return characterList;
  }
}

String mD5(String dataToHash) {
  var bytesToHash = utf8.encode(dataToHash);
  var md5Digest = md5.convert(bytesToHash);
  return md5Digest.toString();
}
