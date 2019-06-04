import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';
import './view_by_carousel.dart';
import './view_by_image.dart';
import './view_by_list.dart';
import './view_by_slider.dart';
import './view_by_video.dart';

class CollectionListItem extends StatelessWidget {
  final Collection collection;

  CollectionListItem(this.collection);

  @override
  Widget build(BuildContext context) {
    switch (collection.viewBy) {
      case 'carousel':
        return ViewByCarousel(collection);
      case 'image':
        return ViewByImage(collection);
      case 'list':
        return ViewByList(collection);
      case 'slider':
        return ViewBySlider(collection);
      case 'video':
        return ViewByVideo(collection);
    }
    return Container();
  }
}
