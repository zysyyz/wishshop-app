import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class HomeShoppingCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeShoppingCartScreen();
}

class _HomeShoppingCartScreen extends State<HomeShoppingCartScreen> {

  bool _isSelectAll = false;

  Widget _buildBottomNavigationBar(BuildContext context) {
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - 8.0, 0.0);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
            child: Stack(
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: additionalBottomPadding),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.0
                            )
                          )
                        ),
                        height: kBottomNavigationBarHeight,
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.green,
                                  value: _isSelectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      _isSelectAll = value;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isSelectAll = !_isSelectAll;
                                    });
                                  },
                                  child: Text(
                                    "全选",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                )
                              ]
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(right: 12),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '¥0',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 120,
                                height: kBottomNavigationBarHeight,
                                child: RaisedButton(
                                  elevation: 0,
                                  highlightElevation: 0,
                                  child: Text(
                                    '下单',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        backgroundColor: Color(0xfff5f6f7),
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Text('编辑'),
            onPressed: () {
              
            },
          ),
        ],
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: Center(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
