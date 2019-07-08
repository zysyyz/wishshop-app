
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Color backgroundColor;
  final Color numberTextColor;
  final int number;

  const Badge({
    Key key,
    this.backgroundColor = Colors.red,
    this.numberTextColor = Colors.white,
    this.number
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 3, right: 3),
          constraints: BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${number > 99 ? '99+' : number}',
            style: new TextStyle(
              color: numberTextColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
