import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class MyAddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('我的地址簿'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Center(),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    elevation: 0,
                    highlightElevation: 0,
                    child: Text(
                      '添加新收货地址',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator
                          .of(context)
                          .push(MaterialPageRoute(builder: (_) => AddressesScreen()));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
