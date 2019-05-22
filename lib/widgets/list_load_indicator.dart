import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListLoadIndicator extends StatelessWidget {
  String title;
  String message;

  ListLoadIndicator({
    this.title = '',
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(16, 130, 16, 80),
      child: Column(
        children: <Widget>[
          SpinKitFadingCube(
            color: theme.primaryColor,
            size: 26.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Text(title),
          ),
          // Text(message),
        ],
      ),
    );
  }
}
