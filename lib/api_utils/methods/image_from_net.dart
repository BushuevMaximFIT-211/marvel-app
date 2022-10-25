import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

CachedNetworkImage imageFromNetwork(BuildContext context, String url) {
  return CachedNetworkImage(
    imageUrl: url,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Center(
        child: TextApp(text: 'Loading error.\nCheck your Internet conection')),
  );
}
