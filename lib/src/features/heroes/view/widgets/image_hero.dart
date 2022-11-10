import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'text_app.dart';

class ImageHero extends StatelessWidget {
  final String imgUrl;

  const ImageHero({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Center(
          child:
              TextApp(text: 'Loading error.\nCheck your Internet conection')),
    );
  }
}
