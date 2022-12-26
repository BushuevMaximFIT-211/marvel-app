import 'package:heroes_repository/src/models/hero_marvel.dart';
import 'package:heroes_repository/src/heroes_repository.dart';
import 'package:api_client/api_client.dart';
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
  final String _publicKey;
  final String _privateKey;
  String getHash() {
    return '$_ts$_privateKey$_publicKey';
  }

  final _ts = DateTime.now().millisecondsSinceEpoch;

  HeroesRepositoryImpl(this._publicKey, this._privateKey,
      {required ApiClient apiClient})
      : assert(_publicKey.isNotEmpty, 'Api key must not be empty'),
        _apiClient = apiClient;

  @override
  Future<String> fetchDescriptionHeroById(int id) async {
    final response = await _apiClient.dio.get(
        _HeroesEndpoint.characterById.endpoint + id.toString(),
        queryParameters: {
          'characterId': id,
          'apikey': _publicKey,
          'ts': _ts,
          'hash': md5.convert(utf8.encode(getHash())).toString()
        });

    final info = response.data['data']['results'][0]['description'];
    return info;
  }

  @override
  Future<List<HeroMarvel>> fetchHeroList() async {
    List<HeroMarvel> characterList = [];
    final List<dynamic> result;
    final response = await _apiClient.dio
        .get(_HeroesEndpoint.listCharacters.endpoint, queryParameters: {
      'orderBy': '-name',
      'comics': 66397,
      'limit': 5,
      'apikey': _publicKey,
      'ts': _ts,
      'hash': md5.convert(utf8.encode(getHash())).toString()
    });

    result = ResponseMapper.fromJson(response.data).heroes;

    characterList = result.map((e) => HeroMarvel.fromJson(e)).toList();

    return characterList;
  }
}
