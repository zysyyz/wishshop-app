import 'dart:async';
import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class MyFavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('我的心愿单'),
      ),
      body: Center(),
    );
  }
}
