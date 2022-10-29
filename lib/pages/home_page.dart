import 'dart:convert';
import '../api_utils/constants/consts.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/api_utils/classes/hero_list_response.dart';
import 'package:marvel_app/api_utils/classes/http_service.dart';
import '../api_utils/classes/hero_marvel.dart';
import '../widgets/background_painter.dart';
import '../widgets/card_hero.dart';
import '../widgets/logo_marvel.dart';
import '../widgets/text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  HttpService? http;
  List<HeroMarvel>? characterList;
  List<Color> colorList = const [
    Color.fromARGB(255, 63, 175, 190),
    Color.fromARGB(255, 25, 138, 74),
    Color.fromARGB(255, 189, 194, 61),
    Color.fromARGB(255, 106, 33, 162),
    Color.fromARGB(255, 36, 90, 185)
  ];
  Future getHeroID() async {
    Response response;
    try {
      isLoading = true;
      response = await http!.getRequest('/v1/public/characters', {
        'orderBy': '-name',
        'comics': 66397,
        'limit': 5,
        'apikey': publicKey,
        'ts': ts,
        'hash': md5.convert(utf8.encode(hash)).toString()
      });
      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          characterList = HeroListResponse.fromJson(response.data).listHeroes;
        });
      }
    } on DioError {
      isLoading = false;
    }
  }

  @override
  void initState() {
    http = HttpService(baseHost);

    getHeroID();
    super.initState();
  }

  var _curentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : characterList == null
                ? const Center(
                    child: TextApp(text: 'No data'),
                  )
                : CustomPaint(
                    painter: BackgroundPainter(
                        colorList[_curentIndex]), // add colorLIst;
                    child: Center(
                      child: Column(
                        children: [
                          const LogoMarvel(),
                          const TextApp(text: 'Choose your hero'),
                          const SizedBox(
                            height: 40,
                          ),
                          CarouselSlider(
                              items: characterList
                                  ?.map((hero) => CardHero(hero: hero))
                                  .toList(),
                              options: CarouselOptions(
                                height: 555,
                                enableInfiniteScroll: false,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _curentIndex = index;
                                  });
                                },
                              ))
                        ],
                      ),
                    ),
                  ));
  }
}

String mD5(String dataToHash) {
  var bytesToHash = utf8.encode(dataToHash);
  var md5Digest = md5.convert(bytesToHash);
  return md5Digest.toString();
}
