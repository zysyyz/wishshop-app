import 'dart:async';
import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('我的订单'),
      ),
      body: Center(),
    );
  }
}
