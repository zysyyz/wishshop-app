import 'package:flutter/material.dart';

class ListEmptyIndicator extends StatelessWidget {
  String message;

  ListEmptyIndicator({
    this.message = '没有找到数据',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey
              ),
            ),
          ),
        ],
      ),
    );
  }
}
