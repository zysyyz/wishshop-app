import 'package:flutter/material.dart';
import '../../exports.dart';

class ViewBySlider extends StatefulWidget {
  final Collection collection;

  ViewBySlider(this.collection);

  @override
  _ViewBySliderState createState() => _ViewBySliderState();
}

class _ViewBySliderState extends State<ViewBySlider> {


  @override
  Widget build(BuildContext context) {
    Collection collection = widget.collection;
    List<CollectionItem> collectionItems = collection.items ?? [];

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              collection.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.horizontal,
              itemCount: collection.items.length,
              itemBuilder: (context, index) {
                CollectionItem collectionItem = collectionItems[index];
                return Container(
                  height: 200,
                  width: 136,
                  margin: EdgeInsets.all(0.5),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 120,
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 6),
                        child: ClipRRect(
                          borderRadius: new BorderRadius.all(Radius.circular(0.0)),
                          child: CustomImage(
                            collectionItem.imageUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Text(
                        collectionItem.title ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff333333),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      Padding(padding: EdgeInsets.only(top: 2),),
                      Text(
                        collectionItem.description ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      Padding(padding: EdgeInsets.only(top: 4),),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
