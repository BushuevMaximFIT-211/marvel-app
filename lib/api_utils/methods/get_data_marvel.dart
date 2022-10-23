// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import '../classes/hero_marvel.dart';
// import 'package:crypto/crypto.dart';
// import '../constants/consts.dart';

// class ApiClient {
//   final String host;
//   final String path;
//   final String scheme = 'https';
//   final hash = '2$PRIVATE_KEY$PUBLIC_KEY';
//   ApiClient(this.host, this.path);
//   Future<List<HeroMarvel>> getDataApi<T>() async {
//     final Uri uri =
//         Uri(scheme: scheme, host: host, path: path, queryParameters: {
//       'apikey': PUBLIC_KEY,
//       'ts': '2',
//       'hash': md5.convert(utf8.encode(hash)).toString()
//     });

//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       return compute(parseHeroes, response.body);
//     } else {
//       throw Exception(response.hashCode);
//     }
//   }
// }

// String MD5(String dataToHash) {
//   var bytesToHash = utf8.encode(dataToHash);
//   var md5Digest = md5.convert(bytesToHash);
//   return md5Digest.toString();
// }

// List<HeroMarvel> parseHeroes(String responseBody) {
//   Map<String, dynamic> user = jsonDecode(responseBody);
//   final List<dynamic> listJson = user['data']['results'];
//   final heroes = listJson
//       .map((dynamic hero) => HeroMarvel.fromJson(hero as Map<String, dynamic>))
//       .toList();

//   return heroes;
// }
