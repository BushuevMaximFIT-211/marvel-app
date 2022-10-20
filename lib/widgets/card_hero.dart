import 'package:application_marvel/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/text_widget.dart';

class CardHero extends StatelessWidget {
  final String pathImage;
  final String textCard;

  const CardHero({super.key, required this.pathImage, required this.textCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Stack(children: [
        Ink.image(
          image: NetworkImage(pathImage),
          fit: BoxFit.cover,
          height: 600,
          alignment: Alignment.center,
        ),
        Positioned(
            bottom: 16, right: 16, left: 16, child: TextApp(text: textCard))
      ]),
    );
  }
}
