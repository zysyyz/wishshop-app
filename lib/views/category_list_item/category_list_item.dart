import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  Category parentCategory;

  CategoryListItem({Key key, this.category, this.parentCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.white,
      onTap: () {
        Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (_) => CategoryDetailScreen(category: parentCategory ?? category)));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 100,
        child: FadeInImage(
          placeholder: AssetImage("images/placeholder.jpg"),
          image: NetworkImage(
            category.imageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
