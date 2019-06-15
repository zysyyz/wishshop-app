import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String url;

  final double width;
  final double height;
  BoxFit fit;

  CustomImage(this.url, {
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = AssetImage("assets/images/placeholder.png");

    if (url != null && url.isNotEmpty) {
      if (url.startsWith('http')) {
        imageProvider = NetworkImage(this.url ?? '');
      }
    }

    return FadeInImage(
      width: this.width,
      height: this.height,
      placeholder: AssetImage("assets/images/placeholder.png"),
      image: imageProvider,
      fit: this.fit,
    );
  }

}
