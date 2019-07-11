import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart';

import '../../exports.dart';
import './tab_homepage.dart';
import './tab_category.dart';
import './tab_cart.dart';
import './tab_mine.dart';

class _IconWithBadge extends StatelessWidget {
  final String icon;
  Color color;
  int badgeNumber;

  _IconWithBadge(
    this.icon, {
    Key key,
    this.color = Colors.grey,
    this.badgeNumber = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 6, left: 12, right: 12),
          child: Image.asset(icon, color: color, width: 20),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: badgeNumber <= 0 ? Container() : Badge(number: this.badgeNumber),
        )
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget _build(BuildContext context, _ViewModel vm) {
    final tabBarItems = [
      {
        'title': '首页',
        'icon': 'assets/images/ic_tab_homepage.png',
        'badgeNumber': 0,
        'scene': TabHomepageScene(),
      },
      {
        'title': '分类',
        'icon': 'assets/images/ic_tab_category.png',
        'badgeNumber': 0,
        'scene': TabCategoryScene(),
      },
      {
        'title': '购物车',
        'icon': 'assets/images/ic_tab_cart.png',
        'badgeNumber': vm.cartOrder?.numberOfItems ?? 0,
        'scene': TabCartScene(),
      },
      {
        'title': '我的',
        'badgeNumber': 0,
        'icon': 'assets/images/ic_tab_mine.png',
        'scene': TabMineScene(),
      }
    ];

    List<Widget> stackItems = [];
    List<BottomNavigationBarItem> bottomNavigationBarItems = [];
    for (var i = 0; i < tabBarItems.length; i++) {
      bool isSelected = _selectedIndex == i;
      var item = tabBarItems[i];
      final title = item['title'];
      final icon = item['icon'];
      final badgeNumber = item['badgeNumber'] ?? 0;
      final scene = item['scene'];

      Offstage offstage = Offstage(
        offstage: !isSelected,
        child: TickerMode(
          enabled: isSelected,
          child: scene,
        ),
      );

      stackItems.add(offstage);

      BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem(
        icon: _IconWithBadge(icon, color: Colors.grey, badgeNumber: badgeNumber),
        activeIcon: _IconWithBadge(icon, color: Colors.black, badgeNumber: badgeNumber),
        title: Text(title, style: TextStyle(fontSize: 10)),
      );
      bottomNavigationBarItems.add(bottomNavigationBarItem);
    }

    return Scaffold(
      body: Stack(children: stackItems),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        inactiveColor: Colors.grey,
        activeColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
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
      onWillChange: (_ViewModel vm) {
        if (vm.currentUser == null && _selectedIndex == 3) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
    );
  }
}

class _ViewModel {
  final User currentUser;
  final Order cartOrder;

  _ViewModel({
    this.currentUser,
    this.cartOrder,
  });

  static _ViewModel fromStore(redux.Store<AppState> store) {
    final authState = store.state.authState;
    final orderState = store.state.orderState;
    return _ViewModel(
      currentUser: authState.user,
      cartOrder: orderState.cartOrder,
    );
  }
}
