import 'dart:async';
import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class OrderDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('订单详情'),
      ),
      body: Center(),
    );
  }
}
