// import 'package:application_marvel/api_utils/classes/hero_marvel.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import '../widgets/card_hero.dart';
// import 'custom_clipper.dart';
// import '../pages/HomePage.dart';
// import 'custom_clipper.dart';
// import 'package:flutter/material.dart';
// import '../widgets/custom_clipper.dart';
// import '../widgets/logo_marvel.dart';
// import '../widgets/text_widget.dart';
// import '../widgets/slider_heroes.dart';
// import '../api_utils/classes/hero_marvel.dart';
// import '../api_utils/methods/get_dataMarvel.dart';
// import '../api_utils/constants/consts.dart';

// class SliderHeroes extends StatefulWidget {
//   final DecorationImage backgroudImage;
//   SliderHeroes({Key? key, required this.backgroudImage}) : super(key: key);

//   @override
//   State<SliderHeroes> createState() => _SliderHeroesState(backgroudImage);
// }

// class _SliderHeroesState extends State<SliderHeroes> {
//   // final List<HeroMarvel> listOfHeroes;
//   // final BackgroundPainter backgroundPainter;
//   final listOfHeroes = GetterImgReturnSlider();
//   final DecorationImage backgroudImage;
//   _SliderHeroesState(this.backgroudImage);
//   final List<Color> listColor = [
//     Color.fromRGBO(1, 0, 0, 1),
//     Color.fromRGBO(0, 1, 0, 1),
//     Color.fromRGBO(0, 0, 1, 1)
//   ];
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, StateFunc) {
//       return CarouselSlider(
//           items: [
//             CardHero(
//               textCard: listOfHeroes[0].name,
//               pathImage: '${listOfHeroes[0].path}.jpg',
//             ),
//             CardHero(
//                 textCard: listOfHeroes[1].name,
//                 pathImage: '${listOfHeroes[1].path}.jpg'),
//             CardHero(
//                 textCard: listOfHeroes[2].name,
//                 pathImage: '${listOfHeroes[2].path}.jpg'),
//             CardHero(
//                 textCard: listOfHeroes[3].name,
//                 pathImage: '${listOfHeroes[3].path}.jpg'),
//             CardHero(
//                 textCard: listOfHeroes[4].name,
//                 pathImage: '${listOfHeroes[4].path}.jpg'),
//           ],
//           options: CarouselOptions(
//             height: 555,
//             aspectRatio: 16 / 9,
//             viewportFraction: 0.8,
//             initialPage: 0,
//             enableInfiniteScroll: false,
//             reverse: false,
//             autoPlayInterval: const Duration(seconds: 3),
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,

//             enlargeCenterPage: true,
//             // onPageChanged: (index, reason) =>
//             onPageChanged: (index, reason) {
//               setState(() {
//                 var _currentPage = index;
//                 backgroundPainter.colorShape = listColor[_currentPage];
//               });
//             },
//             // onPageChanged: callbackFunction, смена фона
//             scrollDirection: Axis.horizontal,
//           ));
//     });
//   }
// }

// List<MarvelHero> GetterImgReturnSlider {

//   FutureBuilder<List<HeroMarvel>>(
//         future: (ApiClient(BASE_HOST, URL_HEROES).getDataApi<HeroMarvel>()),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('An error has occurred!'),
//             );
//           } else if (snapshot.hasData) {
//             return SliderHeroes(
//               listOfHeroes: snapshot.data!,
              
              
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         });
//   }
// }
