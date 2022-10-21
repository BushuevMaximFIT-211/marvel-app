import 'package:flutter/material.dart';
import 'text_widget.dart';

class CardHero extends StatelessWidget {
  final String imgpath;
  final String textCard;

  const CardHero({super.key, required this.imgpath, required this.textCard});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Stack(children: [
        Image(
          height: 555,
          width: 400,
          image: ExactAssetImage(imgpath),
          fit: BoxFit.cover,
        ),
        Positioned(bottom: 16, left: 10, child: TextApp(text: textCard))
      ]),
    ));
  }
}
