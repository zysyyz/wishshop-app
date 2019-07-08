import 'package:flutter/material.dart';
import '../../exports.dart';

class ViewByImage extends StatefulWidget {
  final Collection collection;

  ViewByImage(this.collection);

  @override
  State<StatefulWidget> createState() => _ViewByImageState();
}

class _ViewByImageState extends State<ViewByImage> {


  @override
  Widget build(BuildContext context) {
    List<CollectionItem> collectionItems = widget.collection.items ?? [];

    CollectionItem collectionItem = collectionItems[0];

    return Container(
      height: 200,
      child: CustomImage(
        collectionItem.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
