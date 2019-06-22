import 'package:flutter/material.dart';
import '../../exports.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  Category parentCategory;

  CategoryGridItem({Key key, this.category, this.parentCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (_) => CategoryDetailScreen(parentCategory ?? category)));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              padding: EdgeInsets.only(bottom: 6),
              child: ClipRRect(
                borderRadius: new BorderRadius.all(Radius.circular(0.0)),
                child: CustomImage(
                  category.imageUrl ?? '',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff333333),
              )
            ),
          ],
        ),
      ),
    );
  }
}
