import 'package:flutter/material.dart';

class ListSection extends StatelessWidget {
  final String title;

  ListSection(this.title);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: title == null ? 10 : null,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: title == null ? null : Text(title, style: TextStyle(fontSize: 12, color: Color(0xff333333)))
      ),
    );
  }
}
