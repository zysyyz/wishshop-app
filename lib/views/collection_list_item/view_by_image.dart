import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

class ViewByImage extends StatefulWidget {
  final Collection collection;

  ViewByImage(this.collection);

  @override
  _ViewByImageState createState() => _ViewByImageState();
}

class _ViewByImageState extends State<ViewByImage> {


  @override
  Widget build(BuildContext context) {
    List<CollectionItem> collectionItems = widget.collection.items ?? [];

    CollectionItem collectionItem = collectionItems[0];

    return Container(
      height: 200,
      child: FadeInImage(
        placeholder: AssetImage("assets/images/placeholder.png"),
        image: NetworkImage(
          collectionItem.imageUrl,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
