import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../models/models.dart';

class _Item extends StatelessWidget {
  final String icon;
  final String title;

  const _Item({
    Key key,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 78,
      child: IconButton(
        iconSize: 78,
        icon: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 14)),
            CircleAvatar(
              backgroundColor: Color(0xffdadada),
              child: ClipOval(
                child: Image.asset('assets/images/$icon.png', width: 50, height: 50),
              ),
              radius: 50 / 2,
            ),
            Padding(padding: EdgeInsets.only(top: 8),),
            Text(title, style: TextStyle(color: Color(0xff666666), fontSize: 14))
          ],
        ),
        onPressed: () { 
          
        },
      ),
    );
  }
}

class ProductShareActionSheet extends StatelessWidget {
  final Product product;

  const ProductShareActionSheet({Key key, this.product}) : super(key: key);

  Widget _buildSocialPart(BuildContext context) {
    const items = [
      {
        'icon': 'ic_action_sheet_wechat',
        'title': '微信',
      },
      {
        'icon': 'ic_action_sheet_wechat_timeline',
        'title': '朋友圈',
      },
      {
        'icon': 'ic_action_sheet_qq',
        'title': 'QQ',
      },
    ];

    var children = items.map((item) => _Item(
      icon: item['icon'], 
      title: item['title'],
    )).toList();
    return Container(
      height: 126,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.5, right: 18.5),
            child: Row(
              children: children,
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - 8.0, 0.0);
    return Container(
      padding: EdgeInsets.only(bottom: additionalBottomPadding),
      height: (126.0 + 50.0 + additionalBottomPadding),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          this._buildSocialPart(context),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: FlatButton(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              }
            ),
          ),
        ],
      ),
    );
  }
}