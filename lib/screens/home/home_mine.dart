import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/models.dart';
import '../../redux/redux.dart';
import '../../screens/screens.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class HomeMineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeMineScreenState();
}

class _HomeMineScreenState extends State<HomeMineScreen> {
  Widget _build(BuildContext context, _ViewModel vm) {
    if (vm.user == null) return Container();

    List<Map<String, dynamic>> items = [
      {
        'key': 'profile',
        'title': '登录',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
        },
      },
      {
        'type': 'section',
      },
      {
        'title': '我的收藏',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => MyFavoritesScreen()));
        },
      },
      {
        'title': '我的地址',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => MyAddressesScreen()));
        },
      },
      {
        'title': '支付方式',
        'onTap': () {
          Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => MyPaymentMethodsScreen()));
        },
      },
      {
        'type': 'section',
      },
      {
        'type': 'section',
      },
      {
        'key': 'logout',
        'title': '退出登录',
        'titleAlign': TextAlign.center,
        'titleStyle': TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        'onTap': () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return CupertinoAlertDialog(
                title: new Text("确定要退出登录吗？"),
                actions: <Widget>[
                  new CupertinoDialogAction(
                    child: new Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new CupertinoDialogAction(
                    child: new Text("确定"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // 最后执行退出登录（使页面切换到登录时更顺畅）
                      vm.doLogout();
                    },
                  ),
                ],
              );
            },
          );
        },
        'accessoryType': "none"
      },
    ];
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text('我的'),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/ic_menu_settings.png'),
            onPressed: () {
              Navigator
                .of(context)
                .push(MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          )
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          if (items[index]['type'] == 'section' || (index < items.length && items[index + 1]['type'] == 'section')) {
            return Padding(padding: EdgeInsets.all(0));
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Divider(indent: 16, height: 1));
        },
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];

          var key = item['key'];
          var title = item['title'];

          if (item['type'] == 'section') {
            return ListSection(title);
          }

          var titleAlign = item['titleAlign'];
          var titleStyle = item['titleStyle'];
          var detailText = item['detailText'];
          var onTap = item['onTap'];
          var accessoryType = item['accessoryType'];

          if (key == 'profile') {
            bool isLoggedIn = vm.user != null;

            var user = vm.user;

            return Material(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  child: !isLoggedIn ? Text("") :
                  ClipOval(
                    child: FadeInImage.memoryNetwork(
                      placeholder: Uint8List.fromList(<int>[]),
                      image: user.avatarUrl,
                      // height: 32,
                      // width: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  radius: 32,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 2)),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 13,
                      )
                    )
                  ],
                ),
                trailing: Icon(FeatherIcons.chevronRight, size: 18),
                onTap: onTap,
                contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16)
              ),
            );
          }

          return ListItem(
            title,
            titleAlign: titleAlign,
            titleStyle: titleStyle,
            detailText: detailText,
            onTap: onTap,
            accessoryType: accessoryType,
          );
        },
      ),
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
  final User user;
  final Function doLogout;

  _ViewModel({
    this.user,
    this.doLogout
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final auth = store.state.auth;
    return _ViewModel(
      user: auth.user,
      doLogout: () {
        LogoutAction action = new LogoutAction();
        store.dispatch(action);

        return action.completer.future;
      }
    );
  }
}
