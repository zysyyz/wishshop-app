import 'package:flutter/material.dart';
import '../../exports.dart';

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xfff1f1f1),
      margin: EdgeInsets.fromLTRB(16, 10, 10, 10),
      child: Container(
        height: 48,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/ic_menu_search.png',
              color: Color(0xffa3a3a3),
              width: 20,
              height: 20,
            ),
            Padding(padding: EdgeInsets.only(left: 6)),
            Expanded(
              child: TextFormField(
                autofocus: true,
                // initialValue: _keyword,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal
                ),
                decoration: new InputDecoration(
                  hintText: '搜索...',
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  return null;
                },
                onFieldSubmitted: (value) {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  List<Product> _items = [];

  Widget _buildBodyWithResult(BuildContext context) {
    return Container();
  }

  Widget _buildBodyWithEmpty(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("历史搜索")
            ],
          ),
          Row(
            children: <Widget>[
              Text("热门搜索")
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_items.length > 0) {
      return _buildBodyWithResult(context);
    }
    return _buildBodyWithEmpty(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: _SearchBar(),
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
      body: _buildBody(context),
    );
  }
}
