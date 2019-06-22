import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String url;

  final double size;

  CustomAvatar(this.url, {
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = AssetImage("assets/images/placeholder_avatar.png");

    if (url != null && url.isNotEmpty) {
      if (url.startsWith('http')) {
        imageProvider = NetworkImage(this.url ?? '');
      }
    }

    return CircleAvatar(
      child: ClipOval(
        child: FadeInImage(
          width: this.size,
          height: this.size,
          placeholder: AssetImage("assets/images/placeholder_avatar.png"),
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
      radius: this.size / 2,
    );
  }

}
