import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

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
          .push(MaterialPageRoute(builder: (_) => CategoryDetailScreen(category: parentCategory ?? category)));
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
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/placeholder.png"),
                  image: NetworkImage(
                    category.imageUrl,
                  ),
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
