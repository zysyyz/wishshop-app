import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

class CategoryListSection extends StatelessWidget {
  final Category category;
  Category parentCategory;

  CategoryListSection({Key key, this.category, this.parentCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator
          .of(context)
          .push(MaterialPageRoute(builder: (_) => CategoryDetailScreen(parentCategory ?? category)));
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8),
        height: 40,
        child: Text(
          category.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          )
        ),
      ),
    );
  }
}
