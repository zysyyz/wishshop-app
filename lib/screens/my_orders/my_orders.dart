import 'package:flutter/material.dart';
import '../../exports.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('我的订单'),
      ),
      body: Center(),
    );
  }
}
