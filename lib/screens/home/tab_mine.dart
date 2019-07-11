import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';
import '../../exports.dart';

class TabMineScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabMineSceneState();
}

class _TabMineSceneState extends State<TabMineScene> {
  Widget _buildListHeader(BuildContext context, _ViewModel vm) {
    User currentUser = vm.currentUser;

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                height: MediaQuery.of(context).padding.top,
              ),
              GestureDetector(
                onTap: () {
                  if (currentUser == null) {
                    Navigator
                      .of(context)
                      .push(MaterialPageRoute(builder: (_) => LoginScreen(), fullscreenDialog: true));
                    return;
                  }
                  Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      CustomAvatar(
                        currentUser?.avatarUrl,
                        size: 56,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                currentUser?.name ?? '登录/注册',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '99',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('积分', style: TextStyle(height: 1.2, fontSize: 13),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('优惠券', style: TextStyle(height: 1.2, fontSize: 13),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '340',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('钱包', style: TextStyle(height: 1.2, fontSize: 13),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListItem(
          '我的订单',
          onTap: () {
            Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (_) => MyOrdersScreen()));
          },
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(height: 1,),
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          child: Material(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Image.asset('assets/images/ic_order_paying.png', width: 32, fit: BoxFit.fitHeight,),
                        ),
                        Text('待付款')
                      ],
                    ),
                    onTap: () {
                      Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (_) => MyOrdersScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Image.asset('assets/images/ic_order_shipping.png', width: 32, fit: BoxFit.fitHeight,),
                        ),
                        Text('待收货')
                      ],
                    ),
                    onTap: () {
                      Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (_) => MyOrdersScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Image.asset('assets/images/ic_order_reviewing.png', width: 32, fit: BoxFit.fitHeight,),
                        ),
                        Text('待评价')
                      ],
                    ),
                    onTap: () {
                      Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (_) => MyOrdersScreen()));
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Image.asset('assets/images/ic_order_aftersale.png', width: 32, fit: BoxFit.fitHeight,),
                        ),
                        Text('退换/售后')
                      ],
                    ),
                    onTap: () {
                      Navigator
                        .of(context)
                        .push(MaterialPageRoute(builder: (_) => MyOrdersScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildListFooter(BuildContext context, _ViewModel vm) {
    return Container();
  }

  Widget _buildBody(BuildContext context, _ViewModel vm) {
    List<Map<String, dynamic>> items = [
      {
        'type': 'header',
      },
      {
        'type': 'section',
      },
      {
        'title': '我的收藏夹',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => MyFavoritesScreen()));
        },
      },
      {
        'title': '我的地址簿',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => MyAddressesScreen()));
        },
      },
      {
        'type': 'section',
      },
      {
        'title': '设置',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => SettingsScreen()));
        },
      },
    ];
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (context, index) {
        if (items[index]['type'] == 'section'
          || (index < items.length && items[index + 1]['type'] == 'section')
          || items[index]['type'] == 'header') {
          return Container();
        }
        return Container(
          height: 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Divider(indent: 16, height: 1));
      },
      itemBuilder: (context, index) {
        var item = items[index];

        switch (item['type']) {
          case 'header':
            return _buildListHeader(context, vm);
          case 'footer':
            return _buildListFooter(context, vm);
          case 'section':
            return ListSection(
              item['title'],
            );
          default:
            return ListItem(
              item['title'],
              onTap: item['onTap'],
            );
        }
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      body: _buildBody(context, vm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return _build(context, vm);
      },
    );
  }
}

class _ViewModel {
  final User currentUser;
  final Function doLogout;

  _ViewModel({
    this.currentUser,
    this.doLogout
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final authState = store.state.authState;
    return _ViewModel(
      currentUser: authState.user,
      doLogout: () {
        LogoutAction action = new LogoutAction();
        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
