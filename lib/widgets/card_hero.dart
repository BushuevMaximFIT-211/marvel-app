import 'package:application_marvel/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/text_widget.dart';

class CardHero extends StatelessWidget {
  final String imgpath;
  final String textCard;

  const CardHero({super.key, required this.imgpath, required this.textCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Stack(children: [
        Image(
          image: ExactAssetImage(imgpath),
          fit: BoxFit.cover,
          height: 600,
        ),
        Positioned(
            bottom: 16, right: 16, left: 10, child: TextApp(text: textCard))
      ]),
    );
  }
}
