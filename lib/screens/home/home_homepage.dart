import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../search/search.dart';

class HomeHomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: Image.asset('assets/images/ic_logo.png', height: 12),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/ic_menu_search.png'),
            onPressed: () {
              Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => SearchScreen()));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 210,
            child: PageView.builder(
              onPageChanged: (index) {
              },
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    color: Colors.grey,
                    child: Text("$index")
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
