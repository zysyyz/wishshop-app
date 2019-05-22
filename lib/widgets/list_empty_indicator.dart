import 'package:flutter/material.dart';

class ListEmptyIndicator extends StatelessWidget {
  String title;
  String message;

  ListEmptyIndicator({
    this.title = '没有找到数据',
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 130, 16, 20),
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          message != null && message.isNotEmpty ? Container(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
