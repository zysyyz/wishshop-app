import 'package:flutter/material.dart';
import '../../routes/routes.dart';
import '../../screens/screens.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xfff1f1f1),
      margin: EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: FlatButton(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/ic_menu_search.png',
              color: Color(0xffa3a3a3),
              width: 20,
              height: 20,
            ),
            Padding(padding: EdgeInsets.only(left: 6)),
            Text(
              "搜索...",
              style: TextStyle(
                color: Color(0xffa3a3a3),
                fontSize: 15,
                fontWeight: FontWeight.normal
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => SearchScreen()));
        },
      ),
    );
  }
}
