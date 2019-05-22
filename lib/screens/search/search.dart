import 'dart:async';
import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        // title: Text('分类'),
        title: SearchBar(),
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Center(),
    );
  }
}
