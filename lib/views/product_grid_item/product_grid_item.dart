import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;

  ProductGridItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product)));
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(0.5),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 6),
              child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(0.0)),
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/placeholder.png"),
                  image: NetworkImage(
                    product.imageUrl,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Text(
              product.name,
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
              product.summary,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            Padding(padding: EdgeInsets.only(top: 4),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '￥${product.price}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: product.originalPrice == null || product.originalPrice <= 0 ? Color(0xff333333) : Colors.red,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 0),
                  child: product.originalPrice == null || product.originalPrice <= 0 ? Container() : Text(
                    '￥${product.originalPrice}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
