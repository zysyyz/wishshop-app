import 'package:flutter/material.dart';
import '../../exports.dart';

class ViewByList extends StatefulWidget {
  final Collection collection;

  ViewByList(this.collection);

  @override
  State<StatefulWidget> createState() => _ViewByListState();
}

class _ViewByListState extends State<ViewByList> {


  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Collection collection = this.widget.collection;
    List<CollectionItem> collectionItems = collection.items ?? [];

    return Container(
      color: themeData.scaffoldBackgroundColor,
      padding: EdgeInsets.only(bottom: 16),
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
          Column(
            children: collectionItems.map((v) {
              return InkWell(
                onTap: () {
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 22, right: 22),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.all(Radius.circular(0.0)),
                          child: CustomImage(
                            v.imageUrl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(width: 22,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              v.title ?? '',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff333333),
                              )
                            ),
                            Container(height: 8,),
                            Text(
                              v.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(width: 16,),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
