import 'package:flutter/material.dart';

import '../../exports.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen(this.order);

  @override
  State<StatefulWidget> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('订单详情'),
      ),
      body: Center(),
    );
  }
}
