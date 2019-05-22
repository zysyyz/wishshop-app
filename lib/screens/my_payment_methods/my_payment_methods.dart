import 'dart:async';
import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class MyPaymentMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('支付方式'),
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
