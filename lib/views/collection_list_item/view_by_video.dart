import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

class ViewByVideo extends StatefulWidget {
  final Collection collection;

  ViewByVideo(this.collection);

  @override
  _ViewByVideoState createState() => _ViewByVideoState();
}

class _ViewByVideoState extends State<ViewByVideo> {


  @override
  Widget build(BuildContext context) {
    List<CollectionItem> collectionItems = widget.collection.items ?? [];

    return Container();
  }
}
