import 'package:flutter/material.dart';
import '../../exports.dart';

class CartListItem extends StatelessWidget {
  final Product product;

  CartListItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () {

      },
      child: Container(
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: 6),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 16, bottom: 16, right: 16),
          child: Row(
            children: <Widget>[
              Checkbox(
                activeColor: Colors.green,
                value: false,
                onChanged: (value) {
                },
              ),
              Container(
                height: 70,
                width: 70,
                // decoration: new BoxDecoration(
                //   border: new Border.all(color: Colors.grey)
                // ),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Theme.of(context).dividerColor, width: 1.0)
                ),
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: new BorderRadius.all(Radius.circular(0.0)),
                  child: FadeInImage(
                    placeholder: AssetImage("images/placeholder.jpg"),
                    image: NetworkImage(
                      product.imageUrl,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 16),),
              Expanded(
                child: Container(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff333333),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(padding: EdgeInsets.only(top: 2),),
                      Expanded(flex: 1, child: Container(),),
                      Row(
                        children: <Widget>[
                          Text(
                            '￥${product.price}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff333333),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 4),),
                          product.originalPrice == null || product.originalPrice <= 0 ? Container() : Text(
                            '￥${product.originalPrice}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'x10',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff333333),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
